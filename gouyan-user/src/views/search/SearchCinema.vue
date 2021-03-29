<template>
  <div class="cinema-list-container">
    <!-- 搜索的一家影院 -->
    <div class="search-result" v-for="item in cinemaList" :key="item.cinemaId">
      <div class="result-left">
        <div class="cinema-name">
          <a :href="'/cinemaInfo/' + item.cinemaId">
            {{item.cinemaName}}
          </a>
        </div>
        <div class="cinema-address">
          {{item.cinemaAddress}}
        </div>
        <div>
          <el-tag size="small" effect="plain" type="danger" v-if="item.isRefunded">可退票</el-tag>
          <el-tag size="small" effect="plain" type="danger" v-if="item.isTicketChanged">可改签</el-tag>
          <el-tag size="small" effect="plain" type="danger" v-for="hall in item.sysHallCategoryList" :key="hall.hallId">{{hall.hallCategoryName}}</el-tag>
        </div>
      </div>
      <div class="result-right">
        <span>{{item.entryDate}}</span>入驻
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
export default {
  name: "SearchCinema",
  props:{
    keyword: {
      type: String,
      default: ''
    }
  },
  data() {
    return{
      cinemaList: [
        {

        }
      ]
    }
  },
  created() {
    this.getSearchCinemaList()
  },
  methods:{
    async getSearchCinemaList(){
      let queryInfo = {
        cinemaName: this.keyword
      }
      const { data : res } = await axios.get('sysCinema', {params : queryInfo})
      if(res.code !== 200) return this.$message.error('获取信息失败')
      this.cinemaList = res.data
      for(let cinema of this.cinemaList){
        cinema.entryDate = moment(cinema.entryDate).format('YYYY年MM月DD日')
      }
      console.log(this.cinemaList)
    }
  },
  watch:{
    '$route'(){
      this.getSearchCinemaList()
    }
  }
}
</script>

<style scoped>
.search-result:first-child{
  margin-top: 40px;
}

.search-result{
  width: 1200px;
  margin: 0 auto;
  padding: 30px 0;
  border-bottom: solid #eee 1px;
  display: flex;
  justify-content: space-between;
}

.cinema-name{
  color: #333333;
  font-size: 24px;
  font-weight: 700;
}

.cinema-address{
  margin: 10px 0;
  color: #999999;
}

a{
  text-decoration: none;
  cursor:pointer;
  color: #333333;
}

.result-right{
  display: flex;
  align-items: center;
}

.result-right span{
  color: #409EFF;
  font-size: 16px;
  font-weight: 700;
}
</style>