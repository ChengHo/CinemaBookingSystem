<template>
  <el-container>
    <el-header>
      <div class="header-inner">
        <a href="/welcome" class="logo">
          <img style="width: 200px; height: 68px; margin-top: 6px;" src="../assets/homeLogo.jpg">
        </a>
        <el-menu
            :default-active="activeUrl"
            class="nav-menu"
            mode="horizontal"
            :router="true"
            active-text-color="#409EFF"
            text-color="#000000">
          <el-menu-item :index="item.path" v-for="item in menuList" :key="item.id">{{item.name}}</el-menu-item>
        </el-menu>
        <div class="searchContainer">
          <el-input v-model="kw" class="searchBar" placeholder="找电影、影人、影院"></el-input>
          <el-button id="searchBtn" icon="el-icon-search" type="primary" circle @click="search"></el-button>
        </div>
        <el-dropdown @command="handleCommand">
          <span class="el-dropdown-link">
            <el-avatar :src="url" :size="50">{{url === '' || url === null ? 'user': ''}}</el-avatar>
            <i class="el-icon-arrow-down el-icon--right icon-arrow"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="userMenu">个人中心</el-dropdown-item>
            <el-dropdown-item command="logout">退出</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </el-header>
    <el-main>
      <router-view></router-view>
    </el-main>
    <el-footer>
      <div class="footer-mini"></div>
      <div class="footer">
        <img style="width: 357px; height: 50px" src="../assets/register-footer.png">
      </div>
      <el-backtop></el-backtop>
    </el-footer>
  </el-container>
</template>

<script>
export default {
  name: "Welcome",
  data() {
    return {
      url: '',
      activeUrl: this.$route.path.substring(0, this.$route.path.indexOf('/',1) === -1 ? this.$route.path.length : this.$route.path.indexOf('/',1)),
      menuList: [
        {
          id: 1,
          name: '首页',
          path: '/home'
        },
        {
          id: 2,
          name: '电影',
          path: '/movie'
        },
        {
          id: 3,
          name: '影院',
          path: '/cinema'
        },
        {
          id: 4,
          name: '榜单',
          path: '/rankingList'
        }
      ],
      //搜索关键字
      kw:''
    }
  },
  created() {
    const userPicture = JSON.parse(window.sessionStorage.getItem('loginUser')).userPicture
    const picture = JSON.parse(userPicture)
    if(picture === null || picture.length === 0) return;
    this.url = this.global.base + picture[0]
  },
  watch: {
    '$route'() {
      this.activeUrl = this.$route.path.substring(0, this.$route.path.indexOf('/',1) === -1 ? this.$route.path.length : this.$route.path.indexOf('/',1))
    }
  },
  methods: {
    handleSelect(key, keyPath){
      console.log(key, keyPath);
    },
    search(){
      let tmp = this.kw
      this.$router.push('/search/searchMovie?kw=' + tmp)
      this.kw = ''
    },
    handleCommand(command){
      if(command === 'logout'){
        window.sessionStorage.clear();
        return this.$router.push('/login')
      }
      this.$router.push('/' + command)
    }

  }
}
</script>

<style scoped>
.el-header{
  height: 80px !important;
  border-bottom: 1px solid #e6e6e6;
}

.header-inner{
  width: 75%;
  margin: 0 12.5%;
  display: flex;
}

.logo{
  height: 80px;
  width: 200px;
}

.nav-menu{
  border-bottom: 0px solid #eee !important;
  height: 60px;
  margin: 9px auto;
}

.el-menu-item{
  font-size: 20px;
}

.el-menu-item:hover{
  color: #409EFF !important;
}

.searchContainer{
  padding: 20px 0;
  display: flex;
}

.searchBar >>> input{
  border-radius: 50px;
}

#searchBtn{
  transform: translate(-100%, 0);
}

.el-dropdown-link{
  width: 70px;
  margin: 15px 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.icon-arrow {
  transition: all 0.2s ease-in-out;
  -webkit-transition: all 0.2s ease-in-out;
  -moz-transition: all 0.2s ease-in-out;
  -o-transition: all 0.2s ease-in-out;
}

.el-dropdown-link:hover .icon-arrow{
  /* 定义动画的状态 */
  -webkit-transform: rotate(180deg) scale(1);
  -moz-transform: rotate(180deg) scale(1);
  -o-transform: rotate(180deg) scale(1);
  -transform: rotate(180deg) scale(1);
}

.footer-mini{
  border-top: 1px solid #EEE;
  padding-top: 20px;
  text-align: center;
}

.footer{
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.el-main{
  padding: 0px;
}
</style>