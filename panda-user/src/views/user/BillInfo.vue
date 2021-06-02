<template>
  <div class="bill-list-container">
    <div class="profile-title">我的订单</div>
    <div class="order-box" v-for="item in billList">
      <div class="order-header">
        <span class="order-date">订单时间：{{item.createTime}}</span>
        <span class="order-id">订单编号: {{item.billId}}</span>
        <span class="del-order"  @click="deleteBill(item.billId)">
          <i class="el-icon-delete"></i>
        </span>
      </div>
      <div class="order-body">
        <div class="poster">
          <img :src="item.sysSession.sysMovie.moviePoster">
        </div>
        <div class="order-content">
          <div class="movie-name">《{{item.sysSession.sysMovie.movieName}}》</div>
          <div class="cinema-name">{{item.sysSession.sysHall.sysCinema.cinemaName}}</div>
          <div class="hall-ticket">
            <span>放映厅：{{item.sysSession.sysHall.hallName}}({{item.sysSession.sysHall.hallCategory}})</span>
            <span></span>
          </div>
          <div class="show-time">播放时间：{{item.sysSession.sessionDate + ' ' + item.sysSession.playTime + ' - ' + item.sysSession.endTime}}</div>
        </div>
        <div class="order-price">
          ￥{{item.sysSession.sessionPrice * JSON.parse(item.seats).length}} (
          {{JSON.parse(item.seats).length}}*{{item.sysSession.sessionPrice}}/张 )
        </div>
        <div class="order-status">
          {{item.payState?'已完成':'未完成'}}
        </div>
        <div class="actions">
          <div>
            <a @click="toBillDetail(item.billId)" class="order-detail" >查看详情</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
import billDetail from '../pay/BillDetail'
export default {
  name: "BillInfo",
  data() {
    return {
      queryInfo: {
        userId: ''
      },
      billList: [
        {
          sysSession: {
            sysMovie: {
              moviePoster: ''
            },
            sysCinema: {},
            sysHall: {}
          }
        }
      ]
    }
  },
  created() {
    this.getUser()
    this.getBillList()
  },
  methods: {
    getUser() {
      this.queryInfo.userId = JSON.parse(window.sessionStorage.getItem('loginUser')).userId
    },
    async getBillList() {
      const _this = this
      await axios.get('sysBill',{params:_this.queryInfo}).then(resp=>{
        _this.billList = resp.data.data
      })

      for(let idx in this.billList) {
        this.billList[idx].sysSession.sessionDate = moment(this.billList[idx].sysSession.sessionDate).format('YYYY年MM月DD日')
        this.billList[idx].sysSession.sysMovie.moviePoster =
          this.global.base + JSON.parse(this.billList[idx].sysSession.sysMovie.moviePoster)[0]
      }

    },
    toBillDetail(id) {
      this.$router.push('/billDetail/' + id)
    },
    async deleteBill(id) {
      const _this = this
      const resp = await this.$confirm('此操作将永久删除订单信息,是否继续?','提示',{
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err=>err)
      if (resp==="cancel") {
        return _this.$message.info('已取消删除')
      }
      await axios.delete('sysBill/'+id).then(resp=>{
        if (resp.data.code !== 200){
          this.$message.error('删除失败！')
        }
      })
      await this.getBillList()
      this.$message.success('删除成功！')
    }
  }
}
</script>

<style scoped>
.bill-list-container{
  min-height: 900px;
}

.profile-title {
  padding: 26px 0;
  color: #ec443f;
  font-size: 18px;
  border-bottom: 1px solid #e1e1e1;
  margin-bottom: 30px;
}

.order-box {
  border: 1px solid #e5e5e5;
  margin: 0 40px 30px 0;
}

.order-box .order-header {
  background-color: #f7f7f7;
  font-size: 14px;
  padding: 16px 20px;
}

.order-box .order-header .order-date {
  color: #333;
  display: inline-block;
  margin-right: 30px;
}

.order-box .order-header .order-id {
  color: #999;
}

.del-order{
  float: right;
}

.order-box .order-body {
  padding: 20px;
  padding-right: 0;
  display: flex;
}

.order-box .order-body .poster {
  width: 66px;
  height: 91px;
  margin-right: 11px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04)
}

.poster img{
  width: 100%;
  height: 100%;
}

.order-content{
  width: 49%;
}

.movie-name{
  font-size: 16px;
  font-weight: 700;
  color: #333;
  margin: 4px 0 7px -6px;
}

.cinema-name, .hall-ticket {
  font-size: 12px;
  color: #999;
  margin-bottom: 4px;
}

.show-time {
  font-size: 12px;
  color: #f03d37;
}

.order-price, .order-status, .actions{
  font-size: 14px;
  color: #333;
  width: 15%;
  line-height: 95px;
}
.order-detail {
  color: #2d98f3;
}
a {
  text-decoration: none;
  cursor: pointer;
  color: #333;
}
</style>
