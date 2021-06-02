<template>
  <div>
    <el-steps :active="2" align-center>
      <el-step title="选择影片场次"></el-step>
      <el-step title="选择座位"></el-step>
      <el-step title="15分钟内付款"></el-step>
      <el-step title="影院取票观影"></el-step>
    </el-steps>
    <div class="whole">
      <div class="left">
        <div class="seat-example">
          <span class="seat" :class="isSelected[0]"></span>
          <span style="margin: 0 20px">可选座位</span>
          <span class="seat" :class="isSelected[3]"></span>
          <span style="margin: 0 20px">已售座位</span>
          <span class="seat" :class="isSelected[2]"></span>
          <span style="margin: 0 20px">已选座位</span>
        </div>

        <div class="screen">银幕中央</div>

        <div class="seat-content">
            <div class="row" v-for="(value, key) in seats">
              <span style="width:10px;margin-right: 50px">{{key}}</span>
              <div style="display: flex; justify-content: flex-end">
                <span class="seat"
                      :class="isSelected[seats[key][index]]"
                      @click="pressSeat(key, index)"
                      v-for="(item, index) in value"></span>
              </div>
            </div>
        </div>
      </div>

      <div class="right">
        <div class="right-content">
          <div class="right-header">
            <div class="poster">
              <img :src="session.sysMovie.moviePoster" alt="">
            </div>
            <div class="movie-info">
              <p style="font-size: 20px;font-weight: 700">{{session.sysMovie.movieName}}</p>
              <span>类型：{{session.sysMovie.movieCategoryList.join('/')}}</span>
              <span>时长：{{session.sysMovie.movieLength}}分钟</span>
            </div>
          </div>
          <div class="right-content">
            <div class="info-item">
              <span>影院：</span>
              <span>{{session.sysHall.sysCinema.cinemaName}}</span>
            </div>
            <div class="info-item">
              <span>影厅：</span>
              <span>{{session.sysHall.hallName}}</span>
            </div>
            <div class="info-item">
              <span>版本：</span>
              <span>{{session.languageVersion}}</span>
            </div>
            <div class="info-item">
              <span>场次：</span>
              <span>{{session.sessionDate}} {{session.playTime}}</span>
            </div>
            <div class="info-item">
              <span>票价：</span>
              <span>￥{{session.sessionPrice}}/张</span>
            </div>
            <span style="color: #999">座位：</span>
            <div class="seat-chose">
              <span class="ticket" v-if="pickedSeats.length > 0" v-for="item in pickedSeats">{{ item }}</span>
            </div>
            <div class="info-item" style="align-items: center">
              <span style="color: #333">总价：</span>
              <span style="font-size: 20px;color: #f03d37">￥{{session.sessionPrice * pickedSeats.length}}</span>
            </div>
            <div style="text-align: center;margin-top: 30px">
              <el-button type="danger" round @click="submitBill">提交订单</el-button>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import moment from 'moment'
import { Message } from "element-ui";
export default {
  name: "ChooseSeat",
  data() {
    return {
      isSelected: {
        0: 'seat-default',
        1: 'seat-no',
        2: 'seat-pick',
        3: 'seat-sold'
      },
      seats: {},
      sessionId: this.$route.params.sessionId,
      session: {
        sysMovie: {
          movieCategoryList: []
        },
        sysCinema: {},
        sysHall: {}
      },
      pickedSeats: [],
      addForm: {
        userId: 0,
        sessionId: 0,
        seats: ''
      }
    }
  },
  created() {
    this.getSession()
  },
  methods: {
    async getSession(){
      const {data: resp} = await axios.get('sysSession/find/' + this.sessionId )
      if(resp.code !== 200) return this.$message.error(resp.msg)
      this.session = resp.data
      this.session.sysMovie.moviePoster = this.global.base + JSON.parse(this.session.sysMovie.moviePoster)[0]
      this.seats = JSON.parse(resp.data.sessionSeats)
      this.session.sysMovie.movieCategoryList = this.session.sysMovie.movieCategoryList.map((obj, index) => {
        return obj.movieCategoryName
      })
      console.log('加载页面时的座位状态')
      console.log(this.seats)
    },
    pressSeat(key, idx) {
      let seat_str = key + "排" + (idx+1) + "座"
      // 选座
      if (this.seats[key][idx] === 0) {
        // 判断选座是否超过5个，超过5个则不能选
        if (this.pickedSeats.length === 5) {
          this.$alert('您最多选择五个座位', '提示', {
            confirmButtonText: '确定',
            type: 'warning'
          }).catch(err => err)
          return
        }
        this.$set(this.seats[key], idx, 2)
        this.pickedSeats.push(seat_str)
      } else if (this.seats[key][idx] === 2) {
        // 取消选座
        this.$set(this.seats[key], idx, 0)
        this.pickedSeats.splice(this.pickedSeats.indexOf(seat_str), 1)
      }
      console.log(this.pickedSeats)
    },
    async submitBill() {
      // 获取token，校验登录
      const token = window.sessionStorage.getItem("token")
      if (!token) {
        window.sessionStorage.setItem('sessionId', this.session.sessionId)
        this.$alert('抱歉！提交订单前，请先登录', '提交订单异常通知', {
          confirmButtonText: '我知道了',
          callback: action => {
            this.$router.push('/login')
          }
        })
        return
      }
      // 校验是否选座，未选座则警告
      if (this.pickedSeats.length === 0){
        this.$alert('抱歉！您暂时未选座，无法提交订单，请选座后提交订单。', '提交订单异常通知', {
          confirmButtonText: '我知道了',
          callback: action => {
            this.$router.push('/chooseSeat/' + this.sessionId)
          }
        })
        return
      }
      //获取场次座位信息
      const { data : curSession } = await axios.get('sysSession/find/' + this.sessionId)
      let sessionSeats = JSON.parse(curSession.data.sessionSeats)
      //解析出订单选择的座位，更新座位信息
      for (let seat of this.pickedSeats) {
        let row = seat.substring(0, seat.indexOf('排'))
        let col = Number.parseInt(seat.substring(seat.indexOf('排') + 1, seat.length - 1))
        if (sessionSeats[row][col - 1] === 3){
          // 更新座位信息
          this.seats = JSON.parse(curSession.data.sessionSeats)
          this.$alert('抱歉！您所选的座位'+seat+'已被占用，请重新选择。', '选座异常通知', {
            confirmButtonText: '我知道了',
            callback: action => {
              this.$router.push('/chooseSeat/' + this.sessionId)
            }
          })
          return
        } else {
          sessionSeats[row][col - 1] = 3
        }
      }
      console.log('提交订单后的座位状态')
      console.log(sessionSeats)

      this.addForm.userId = JSON.parse(window.sessionStorage.getItem('loginUser')).userId
      this.addForm.sessionId = this.sessionId
      this.addForm.seats = JSON.stringify(this.pickedSeats)
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      const { data: res } = await axios.post('sysBill', JSON.stringify({sysBill: this.addForm, sessionSeats: JSON.stringify(sessionSeats)}))
      // const { data: res} = await axios.post('sysBill', JSON.stringify(this.addForm));
      if(res.code !== 200) return this.$message.error('添加订单失败！')
      await this.$router.push('/billDetail/' + res.data.billId)
    }
  }
}
</script>

<style scoped>

.el-step {
  margin: 40px auto;
}

.whole{
  width: 1200px;
  margin: 0 auto;
  border: 1px solid #e5e5e5;
  display: flex;
}

.left {
  width: 820px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-right: 1px solid #e5e5e5;
}

.right{
  width: 340px;
  background-color: #f9f9f9;
  padding: 20px;
}

.seat {
  display: inline-block;
  width: 30px;
  height: 26px;
  margin: 0 5px;
  background-position: 0 1px;
}

.seat-default {
  background: url("../../assets/sofa-unpick.png") no-repeat;
  background-size: cover;
}

.seat-empty {
  background: url("../../assets/sofa-empty.png") no-repeat;
  background-size: cover;
}

.seat-sold {
  background: url("../../assets/sofa-forbidden.png") no-repeat;
  background-size: cover;
}

.seat-pick{
  background: url("../../assets/sofa-pick.png") no-repeat;
  background-size: cover;
}

.seat-example{
  display: flex;
  align-items: center;
  margin: 20px 0 0 0;
}

.screen{
  width: 550px;
  padding-top: 50px;
  text-align: center;
  font-size: 16px;
  color: #666;
  background: url(data:image/png;base64,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) no-repeat;
  background-position-x: center;
  position: relative;
  margin: 40px 0 40px 0;
}

.row{
  white-space: nowrap;
  margin-top: 10px;
  padding: 0 10px;
  text-align: center;
  display: flex;
}


.seat-content{
  margin-bottom: 40px;
  overflow-x: scroll;
  width: 90%;
  padding: 10px;
}

.poster{
  width: 115px;
  height: 158px;
}

.poster>img{
  width: 100%;
  height: 100%;
}

.right-header{
  display: flex;
}

.movie-info{
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-left: 20px;
}

.info-item{
  display: flex;
  margin: 15px 0;
  font-size: 14px;
}

.info-item :first-child{
  color: #999999;
}

.seat-chose{
  margin-top: 20px;
  margin-left: 42px;
  margin-bottom: 20px;
  position: relative;
  top: -5px;
}

.ticket{
  cursor: default;
  position: relative;
  font-size: 13px;
  color: #f03d37;
  display: inline-block;
  width: 60px;
  height: 30px;
  line-height: 30px;
  text-align: center;
  margin: 0 12px 10px 0;
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAAAeCAYAAABwmH1PAAAAAXNSR0IArs4c6QAAAXlJREFUWAlj/Oho7cXAzLTg/89fogzDGDCys71m+PsvgeGji+2r38eP/h/u4Pexo/9BfmUCxSyLhdUwjluI11gsrRhAfmUa9j5F8+Coh9ECZNhxR2N42EUpmodGZgx/TYz9+nvzhn9ogTEsuUysDGxS/548jP4+qe/0l6zUL//fvh2WHoV5ihHGALa0GD872rQxamrm8EybzQMTH070RzsLBngeZmRk/M+7/0jVv9s3rw7n5A33MCgmQZ4GRnn7r3Vrvw+nmEX2C4qHQRLMPxlO/X38kA1Z0XBiY3h4OHkOm18wPPyXncGMWVb+FzbFw0EMxcOgkvo/A0MlW1Aw53DwHDY/wD0Mq5aYVNW1WX0D4OLYNA1lMZavtraSoGT8ydWukklTU5u7uWNY1sGwSGL5zfDrGYuM6ldQMh7OMQv3MIjBPX8xN0xguNPDNq/iirhRD+MKmeEiPhrDwyUmcflj5MUwaM7lz/FjuAJk2IiD/AjyK+NIm0wDAACxUs8MaULTAAAAAElFTkSuQmCC) no-repeat;
}
</style>
