<template>
  <div>
    <div class="list-header">
      <h2 class=""><span>影院信息</span></h2>
    </div>
    <div class="list-content" :model="cinemaInfo">
      <div class="list-left">
        <a @click="toChooseSession(cinemaInfo.cinemaId)"><h1>{{cinemaInfo.cinemaName}}</h1></a>
        <h3 class="cinema-address">地址：{{ cinemaInfo.cinemaAddress }}</h3>
        <h3 class="cinema-address">电话：{{ cinemaInfo.cinemaPhone }}</h3>
        <br/>
        <p class="list-header">&nbsp;</p>
        <el-tag type="danger" v-for="hall in halls" >{{hall}}</el-tag>
        <br/>
        <p>&nbsp;</p>
        <span v-for="item in pics">
            <el-popover placement="left" trigger="click" width="300">
              <img :src="item.url" width="200%"/>
              <img slot="reference" :src="item.url" :alt="item"
                   style="max-height: 300px;max-width: 300px;padding: 10px"/>
            </el-popover>
          </span>
        <br/>
        <el-button @click="toChooseSession(cinemaInfo.cinemaId)" type="primary" round size="medium" align="left">选座购票</el-button>
      </div>
      <div class="list-left-select"></div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Cinema",
  data() {
    return {
      cinemaInfo: {},
      halls: [],
      pics: [],
      sorry: false
    }
  },
  created() {
    this.getCinemaInfo()
  },
  methods: {
    async getCinemaInfo(){
      const _this = this
      await axios.get('sysCinema').then(resp => {
        _this.cinemaInfo = resp.data.data
      })
      _this.pics = []
      _this.halls = []

      for (const item of JSON.parse(this.cinemaInfo.cinemaPicture)) {
        let pic = {}
        pic['name'] = ''
        pic['url'] = this.global.base + item
        this.pics.push(pic)
      }
      for (const item of JSON.parse(this.cinemaInfo.hallCategoryList)) {
        this.halls.push(item)
      }
    },
    toChooseSession(id){
      this.$router.push('/chooseSession/' + id)
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

.list-left-select{
  margin-top: 300px;

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
