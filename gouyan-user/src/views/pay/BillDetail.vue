<template>
  <div>
    <el-steps :active="3" align-center>
      <el-step title="选择影片场次"></el-step>
      <el-step title="选择座位"></el-step>
      <el-step title="15分钟内付款"></el-step>
      <el-step title="影院取票观影" status="wait"></el-step>
    </el-steps>
    <div class="bill-info-container">
      <!-- 订单状态 -->
      <div class="bill-info-status" v-if="state === false && (minutes > 0 || seconds > 0)">
        <div class="pay-icon">
          <img src="../../assets/money.png">
        </div>
        <div class="pay-info">
          <div class="pay-info-status">待支付</div>
          <div class="pay-info-desc">请在<span>{{minutes}}分钟{{seconds}}秒</span>内完成支付</div>
        </div>
      </div>
      <div class="bill-info-status invalid" v-if="state === false && minutes <= 0 && seconds <= 0">
        <div class="pay-icon">
          <img src="../../assets/bill-invalid.png">
        </div>
        <div class="pay-info">
          <div class="pay-info-status invalid">订单由于未支付，已失效</div>
        </div>
      </div>
      <div class="bill-info-status finish" v-if="state === true">
        <div class="pay-icon">
          <img src="../../assets/finish.png">
        </div>
        <div class="pay-info">
          <div class="pay-info-status finish">已完成</div>
        </div>
      </div>

      <!-- 订单信息 -->
      <div class="bill-info-desc">
        <div class="bill-info-header">
          <span>狗眼订单号: {{billInfo.billId}}</span>
          <span class="bill-info-helper">(有订单问题可拨打客服电话<div>1111-1111</div>，工作时间: 9:00-24:00)</span>
        </div>
        <table class="order-table">
          <thead>
          <tr>
            <th>影片</th>
            <th>时间</th>
            <th>影院</th>
            <th>座位</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td class="movie-name">《{{billInfo.sysSession.sysMovie.movieNameCn}}》</td>
            <td class="showtime">{{billInfo.sysSession.sessionDate}} {{billInfo.sysSession.sysMovieRuntime.beginTime}}</td>
            <td class="cinema-name">{{billInfo.sysSession.sysCinema.cinemaName}}</td>
            <td>
              <span class="hall">{{billInfo.sysSession.sysHall.hallName}}</span>
              <div class="seats">
                <span class="bill-seat" v-for="item in billSeats" :key="item"> {{item}} </span>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <!-- 影院信息、提交订单 -->
      <div class="bill-info-area">
        <div class="cinema-info">
          <span class="bill-cinema-name">{{billInfo.sysSession.sysCinema.cinemaName}}</span>
          <div class="bill-cinema-info">
            <span>地址: {{billInfo.sysSession.sysCinema.cinemaAddress}} </span>
            <span>电话: {{billInfo.sysSession.sysCinema.user.phoneNumber}} </span>
          </div>
        </div>
        <div class="submit-bill">
          <div>总价：<span>{{(billInfo.sysSession.sessionPrice * billSeats.length).toFixed(1)}}</span></div>
          <div v-if="state === false && (minutes > 0 || seconds > 0)">
            <el-button @click="payForBill" type="primary" style="width: 200px; margin-top: 20px;" round>立即支付</el-button></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "BillDetail",
  data() {
    return {
      billId: this.$route.params.billId,
      billInfo: {
        sysSession:{
          sysCinema:{
            user:{}
          },
          sysMovie:{},
          sysHall:{},
          sysMovieRuntime:{}
        },
      },
      billSeats:[],
      state: null,
      //计时
      minutes: 1,
      seconds: 0,
    }
  },
  created() {
    this.getBillInfo()
  },
  mounted() {
    this.add()
  },
  methods:{
    async getBillInfo(){
      const { data : res } = await axios.get('sysBill/' + this.billId)
      if(res.code !== 200) return this.$message.error('获取信息失败')
      this.billInfo = res.data

      //处理订单座位信息
      this.billSeats = JSON.parse(this.billInfo.seats)
      this.state = this.billInfo.billState
      this.computeLeftTime()
    },
    async payForBill(){
      //更新订单状态
      this.billInfo.billState = true
      //获取场次座位信息
      const { data : curSession } = await axios.get('sysSession/' + this.billInfo.sessionId)
      let sessionSeats = JSON.parse(curSession.data.sessionSeats)
      //解析出订单选择的座位，更新座位信息
      for(let seat of this.billSeats){
        let row = seat.substring(0, seat.indexOf('排'))
        let col = Number.parseInt(seat.substring(seat.indexOf('排') + 1, seat.length - 1))
        sessionSeats[row][col - 1] = 3
      }
      //更新订单信息和场次座位信息
      axios.defaults.headers.put['Content-Type'] = 'application/json'
      const { data: res } = await axios.put('sysBill',JSON.stringify({sysBill: this.billInfo, sessionSeats: JSON.stringify(sessionSeats)}))
      if(res.code !== 200) return this.$message.error('支付失败')

      this.state = true
      this.$alert('支付成功！您可以前往个人中心查看订单信息', '支付通知', {
        confirmButtonText: '我知道了',
        callback: action => {
          this.$router.push('/movie')
        }
      });
    },
    computeLeftTime(){
      let cur = new Date()
      let billDate = new Date(this.billInfo.billDate)
      let diff = 15 * 60 - (cur - billDate) / 1000
      if(diff < 0){
        this.minutes = 0
        this.seconds = 0
      }else{
        this.minutes = Math.floor(diff / 60)
        this.seconds = Math.floor(diff % 60)
      }
    },
    //计时转换数字格式
    num: function (n) {
      return n < 10 ? '0' + n : '' + n
    },
    //计时走动
    add: function () {
      var _this = this
      var time = window.setInterval(function () {
        if (_this.seconds === 0 && _this.minutes !== 0) {
          _this.seconds = 59
          _this.minutes -= 1
        } else if (_this.minutes === 0 && _this.seconds === 0) {
          _this.seconds = 0
          window.clearInterval(time)
        } else {
          _this.seconds -= 1
        }
      }, 1000)
    },
  },
  watch: {
    second: {
      handler (newVal) {
        this.num(newVal)
      }
    },
    minute: {
      handler (newVal) {
        this.num(newVal)
      }
    }
  },
  computed: {
    second: function () {
      return this.num(this.seconds)
    },
    minute: function () {
      return this.num(this.minutes)
    }
  }
}
</script>

<style scoped>
.el-step {
  margin: 40px auto;
}

.bill-info-container{
  width: 80%;
  margin: 0 auto 40px auto;
}

.bill-info-status{
  height: 120px;
  background: #FFFBF2;
  display: flex;
  align-items: center;
  margin-bottom: 40px;
}

.pay-icon{
  width: 40px;
  height:40px;
  margin-left: 50px;
}

.pay-icon>img{
  width: 100%;
  height: 100%;
}

.pay-info{
  display: flex;
  flex-direction: column;
  margin-left: 20px;
}

.pay-info-status{
  color: #FAAF00;
  font-size: 24px;
  font-weight: 700;
}

.pay-info-desc{
  color: #999;
  font-size: 13px;
}

.pay-info-desc>span{
  font-size: 16px;
  color: #faaf00;
  margin: 5px 5px;
}

.bill-info-status.finish{
  background: #F4FFF8;
}

.bill-info-status.invalid{
  background: #FFE0E0;
}

.pay-info-status.finish{
  color: #26CE61;
}

.pay-info-status.invalid{
  color: #faaaaa;
}

.bill-info-header{
  display: flex;
  justify-content: space-between;
}

.bill-info-header>span>div{
  color: #f03d37;
}

.bill-info-helper{
  color: #999;
  font-size: 13px;
  display: flex;
  margin-bottom: 8px;
}

.order-table{
  width: 100%;
  border: 1px solid #e5e5e5;
  border-spacing: 0;
  margin-bottom: 60px;
}

.order-table thead {
  background-color: #f7f7f7;
}

.order-table thead th {
  font-size: 16px;
  color: #333;
  width: 25%;
  padding: 14px 0;
  font-weight: 400;
}

.order-table td {
  text-align: center;
  padding: 20px 0;
  color: #333;
}

.order-table .movie-name {
  font-size: 16px;
}

.order-table .showtime {
  font-size: 14px;
  color: #f03d37;
}

.order-table .cinema-name {
  font-size: 14px;
}

.order-table .hall {
  display: inline-block;
  font-size: 14px;
  color: #424242;
  font-weight: 700;
  margin-right: 10px;
  vertical-align: top;
}

.order-table .seats {
  display: inline-flex;
  text-align: left;
  flex-wrap: wrap;
}

.order-table .seats span{
  margin-right: 5px;
}

.bill-info-area{
  display: flex;
  justify-content: space-between;
}

.bill-cinema-name{
  font-weight: 700;
}

.bill-cinema-info{
  display: flex;
  flex-direction: column;
  margin-top: 15px;
}

.submit-bill{
  margin-top: 40px;
}

.submit-bill span{
  color: #f03d37;
  font-size: 32px;
  font-weight: 700;
}

.submit-bill span:before{
  content: '￥';
  font-size: 20px;
}
</style>