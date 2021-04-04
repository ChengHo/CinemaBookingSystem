<template>
  <!-- 分类查询 -->
  <div>
    <div class="tags-container">
      <div class="tags-line">
        <div class="tags-title">类型:</div>
        <el-radio-group v-model="brandRadio" size="medium">
          <el-radio-button :label="0">全部</el-radio-button>
          <el-radio-button :label="item.cinemaBrandId" v-for="item in cinemaBrandList" :key="item.cinemaBrandId">
            {{ item.cinemaBrandName }}
          </el-radio-button>
        </el-radio-group>
      </div>
      <div class="tags-line">
        <div class="tags-title">行政区:</div>
        <el-radio-group v-model="areaRadio" size="medium">
          <el-radio-button :label="0">全部</el-radio-button>
          <el-radio-button :label="item.cinemaAreaId" v-for="item in cinemaAreaList" :key="item.cinemaAreaId">
            {{ item.cinemaAreaName }}
          </el-radio-button>
        </el-radio-group>
      </div>
      <div class="tags-line">
        <div class="tags-title">特殊厅:</div>
        <el-radio-group v-model="hallCategoryRadio" size="medium">
          <el-radio-button :label="0">全部</el-radio-button>
          <el-radio-button :label="item.hallCategoryId" v-for="item in hallCategoryList" :key="item.hallCategoryId">
            {{ item.hallCategoryName }}
          </el-radio-button>
        </el-radio-group>
      </div>
      <div class="tags-line">
        <div class="tags-title">服务:</div>
        <el-radio-group v-model="serviceRadio" size="medium">
          <el-radio-button :label="0">全部</el-radio-button>
          <el-radio-button :label="1">可改签</el-radio-button>
          <el-radio-button :label="2">可退票</el-radio-button>
        </el-radio-group>
      </div>
    </div>
    <div class="list-header">
      <h2 class=""><span>影院列表</span></h2>
    </div>
    <div class="list-content" v-for="item in cinemaList">
      <div class="list-left">
        <a href="#" class="cinema-name">{{ item.cinemaName }}</a>
        <p class="cinema-address">地址：{{ item.cinemaAddress }}</p>
        <el-tag size="small" effect="plain" type="danger" v-if="item.isRefunded">可退票</el-tag>
        <el-tag size="small" effect="plain" type="danger" v-if="item.isTicketChanged">可改签</el-tag>
        <el-tag size="small" effect="plain" type="danger" v-for="hall in item.sysHallCategoryList" :key="hall.hallId">{{hall.hallCategoryName}}</el-tag>
      </div>
      <div class="list-right">
        <el-button @click="toCinemaInfo(item.cinemaId)" type="primary" round size="medium">选座购票</el-button>
      </div>
    </div>
    <div class="no-cinema" v-if="sorry">
      <p>抱歉，没有找到相关结果，请尝试用其他条件筛选。</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "Cinema",
  data() {
    return {
      queryInfo: {
        cinemaBrandId: 0,
        cinemaAreaId: 0,
        hallCategoryId: 0,
        isTicketChanged: null,
        isRefunded: null
      },
      brandRadio: 0,
      areaRadio: 0,
      hallCategoryRadio: 0,
      serviceRadio: 0,
      cinemaBrandList: [],
      cinemaAreaList: [],
      hallCategoryList: [],
      cinemaList: [],
      sorry: false
    }
  },
  created() {
    this.getCinemaBrandList()
    this.getCinemaAreaList()
    this.getHallCategoryList()
    this.getCinemaList()
  },
  computed: {
    listenChange () {
      const {brandRadio, areaRadio, hallCategoryRadio, serviceRadio } = this
      return {brandRadio, areaRadio, hallCategoryRadio, serviceRadio}
    }
  },
  watch: {
    listenChange(){
      this.getCinemaList()
    }
  },
  methods: {
    async getCinemaBrandList() {
      const {data: res} = await axios.get('sysCinemaBrand')
      if (res.code !== 200) return this.$message.error('获取服务器信息失败')
      this.cinemaBrandList = res.data
    },
    async getCinemaAreaList() {
      const {data: res} = await axios.get('sysCinemaArea')
      if (res.code !== 200) return this.$message.error('获取服务器信息失败')
      this.cinemaAreaList = res.data
    },
    async getHallCategoryList() {
      const {data: res} = await axios.get('sysHallCategory')
      if (res.code !== 200) return this.$message.error('获取服务器信息失败')
      this.hallCategoryList = res.data
    },
    async getCinemaList(){
      console.log(this.brandRadio)
      this.queryInfo.cinemaBrandId = this.brandRadio
      this.queryInfo.cinemaAreaId = this.areaRadio
      this.queryInfo.hallCategoryId = this.hallCategoryRadio
      if (this.serviceRadio == 1) {
        this.queryInfo.isTicketChanged = true
      }else if (this.serviceRadio == 2){
        this.queryInfo.isRefunded = true
      }else{
        this.queryInfo.isTicketChanged = null
        this.queryInfo.isRefunded = null
      }
      const {data: res} = await axios.get('sysCinema', { params: this.queryInfo })
      if (res.code !== 200) return this.$message.error('获取服务器信息失败')
      this.cinemaList = res.data
      if (this.cinemaList.length == 0 ) this.sorry = true
      else this.sorry = false
    },
    toCinemaInfo(id){
      this.$router.push('/cinemaInfo/' + id)
    }
  }
}
</script>

<style scoped>

.tags-container {
  width: 1200px;
  margin: 40px auto;
  border: solid #EEEEEE 1px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1)
}

.tags-line {
  width: 100%;
  display: flex;
  padding: 10px;
  box-sizing: border-box;
  border-bottom: solid #EEEEEE 1px;
}

.tags-line:last-child {
  border-bottom: 0;
}

.tags-title {
  width: 5%;
  height: 24px;
  line-height: 24px;
  float: left;
  color: #999;
  font-size: 14px;
}

.el-radio-group {
  width: 92%;
  margin-left: 20px;
}

.el-radio-button {
  margin-right: 10px;
}

.el-radio-button:last-child {
  margin-right: 0;
}

.el-radio-button >>> .el-radio-button__inner {
  border: solid #eee 0px !important;
  border-radius: 50px !important;
}

.order-by-container {
  margin: 30px 10px 0 10px;
}

.list-header{
  width: 1200px;
  display: flex;
  margin: 0 auto;

}

.list-header > h2{
  padding-left: 6px;
  border-left: 4px solid #409EFF;
  font-size: 18px;
  color: #333;
}

.list-content{
  width: 1200px;
  display: flex;
  margin: 0 auto;
  justify-content: space-between;
  border-bottom: solid #EEEEEE 1px;
  padding: 10px 0;
  margin-bottom: 30px;
}

.list-left{

}

.list-right{
  margin-top: 30px;

}

a{
  text-decoration: none;
}

.cinema-name{
  color: #333;
}

.buy-ticket{
  display: inline-block;
  color: #FFFFFF;
  border-radius: 100px;
  background-color: #409EFF;
  width: 100%;
  font-size: 14px;
  text-align: center;
}

.cinema-address{
  color: #999999;
}

.el-tag{
  margin: 0 10px 10px 0;
}

.el-button{
  margin-right: 20px;
}

.no-cinema{
  display: flex;
  justify-content: center;
  margin-top: 40px;
  margin-bottom: 40px;
  font-size: 16px;
  color: #333;
}

</style>