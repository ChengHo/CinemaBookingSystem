<template>
  <el-container>
    <el-header>
      <el-menu :default-active="$route.path"
               class="nav-menu"
               mode="horizontal"
               :router="true"
               background-color="#545c64"
               text-color="#fff"
               active-text-color="#ffd04b">
        <el-menu-item :index="item.path" v-for="item in menuList" :key="item.id">{{item.name}}</el-menu-item>
      </el-menu>
    </el-header>
    <el-main>
      <!-- 类别查询 -->
      <div class="tags-container">
        <div class="tags-line">
          <div class="tags-title">类型:</div>
          <el-radio-group v-model="categoryRadio">
            <el-radio-button :label="0">全部</el-radio-button>
            <el-radio-button :label="item.movieCategoryId" v-for="item in categoryList" :key="item.movieCategoryId">{{item.movieCategoryName}}</el-radio-button>
          </el-radio-group>
        </div>
      </div>

      <!-- 按条件排序 -->
      <div class="order-by-container">
        <el-radio v-model="orderByColumn" label="releaseDate">按时间排序</el-radio>
<!--        <el-radio v-model="orderByColumn" label="movieScore">按评价排序</el-radio>-->
      </div>

<!--      <router-view :movieCategoryId="categoryRadio" :movieAreaId="areaRadio" :movieAgeId="ageRadio" :orderByColumn="orderByColumn"></router-view>-->
      <router-view :movieCategoryId="categoryRadio" :orderByColumn="orderByColumn"></router-view>
    </el-main>
  </el-container>
</template>

<script>
export default {
  name: "Movie",
  data(){
    return {
      menuList: [
        {
          id: '1',
          name: '正在热映',
          path: '/movie/movieOngoing'
        },
        {
          id: '2',
          name: '即将上映',
          path: '/movie/movieUpcoming'
        },
        {
          id: '3',
          name: '经典影片',
          path: '/movie/movieClassics'
        }
      ],
      categoryRadio: 0,
      categoryList: [],
      orderByColumn: 'releaseDate'
    }
  },
  created() {
    this.getCategoryList()
  },
  methods: {
    async getCategoryList() {
      const { data : res } = await axios.get('sysMovieCategory/find')
      if(res.code !== 200) return this.$message.error('获取服务器信息失败')
      this.categoryList = res.data
    }
  },
  watch:{
    '$route'(){
      //页面发生变化时初始化类别选项
      this.categoryRadio = 0
      this.orderByColumn = 'releaseDate'
    }
  }
}
</script>

<style scoped>
.el-header{
  padding: 0px;
}

.nav-menu{
  display: flex;
  justify-content: space-around;
}

.el-menu-item{
  font-size: 16px;
}

.el-menu-item:hover{
  color: #FFFFFF !important;
}

.el-main{
  width: 1200px;
  margin: 0 auto;
}

.tags-container{
  border: solid #EEEEEE 1px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1)
}

.tags-line{
  width: 100%;
  display: flex;
  padding: 10px;
  box-sizing: border-box;
  border-bottom: solid #EEEEEE 1px;
}

.tags-line:last-child{
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

.el-radio-group{
  width: 92%;
  margin-left: 20px;
}

.el-radio-button {
  margin-right: 10px;
}

.el-radio-button:last-child{
  margin-right: 0;
}

.el-radio-button >>> .el-radio-button__inner {
  border: solid #eee 0px !important;
  border-radius: 50px !important;
}

.order-by-container{
  margin: 30px 10px 0 10px;
}
</style>
