<template>
  <el-container class="home-container">
    <el-header>
      <div class="span-container" style="padding: 5px" @click="toWelcome">
        <span>&nbsp;&nbsp;</span>
        <img src="../assets/logo.png" alt="" height="40px" width="40px">
        <span>影院管理系统</span>
      </div>
      <el-button type="info" @click="logout">退出</el-button>
    </el-header>
    <el-container>
      <el-aside :width="isCollapsed ? '64px' : '250px'">
        <div class="toggle-button" @click="toggleCollapse">|||</div>
        <!--侧边栏菜单-->
        <el-menu
            background-color="#333744"
            text-color="#fff"
            active-text-color="#409EFF"
            unique-opened
            :collapse="isCollapsed"
            :collapse-transition="false"
            :router="true"
            :default-active="$route.path">
          <!--一级菜单-->
          <el-submenu v-for="item in menuList"
                      :index="String(item.id)" :key="item.id">
            <!--一级菜单的模板区域-->
            <template slot="title">
              <!--图标-->
              <i :class="iconList[item.id]"></i>
              <!--文本-->
              <span>{{item.id}} &nbsp; {{item.name}}</span>
            </template>
            <!--二级菜单-->
            <el-menu-item v-for="subItem in item.children"
                          :index="'/' + subItem.path" :key="subItem.id">
              <template slot="title">
                <!--图标-->
                <i class="el-icon-menu"></i>
                <!--文本-->
                <span>{{subItem.id}} &nbsp; {{ subItem.name }}</span>
              </template>
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>



<script>
export default {
  name: "Home",
  data() {
    return {
      //左侧菜单数据
      menuList: [],
      iconList: {
        '1': 'el-icon-s-home',
        '2': 'el-icon-video-camera-solid',
        '3': 'el-icon-s-help',
        '4': 'el-icon-message-solid',
        '5': 'el-icon-s-custom',
        '6': 'el-icon-user-solid',
        '7': 'el-icon-warning',
        '8': 'el-icon-edit'
      },
      isCollapsed: false
    }
  },
  created(){
    this.getMenuList()
  },
  methods: {
    logout() {
      //清空sessionStorage
      window.sessionStorage.clear();
      this.$router.push('/login')
    },
    async getMenuList(){
      const loginUser = JSON.parse(window.sessionStorage.getItem("loginUser"))
      this.menuList = loginUser.sysUser.sysRole.children
      this.$router.push('/cinema')
    },
    // 菜单展开与闭合：点击事件
    toggleCollapse() {
      this.isCollapsed = !this.isCollapsed
    },
    toWelcome(){
      this.$router.push('/welcome')
    }
  }
}
</script>

<style scoped>

.home-container{
  height: 100%;
}

.el-header {
  background-color: #373d41;
  display: flex;
  justify-content: space-between;
  padding-left: 0;
  align-items: center;
  color: whitesmoke;
  font-size: 20px;
}

.el-header > div{
  display: flex;
  align-items: center;
}

div > span{
  margin-left: 15px;
}

.el-aside {
  background-color: #333744;
}


.toggle-button{
  background-color: #4A5064;
  font-size: 10px;
  line-height: 24px;
  color: #fff;
  text-align: center;
  letter-spacing: 0.1em;
  cursor: pointer;
}

.span-container{
  cursor: pointer;
}

.el-main{
  background: url("../assets/welcome.jpg");
  background-size: cover;
}

.el-menu{
  border: solid 0 grey;
}
</style>
