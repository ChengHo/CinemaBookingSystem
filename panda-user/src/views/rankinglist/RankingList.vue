<template>
  <div>
    <el-menu
        :default-active="$route.path"
        class="el-menu-demo"
        mode="horizontal"
        background-color="#545c64"
        text-color="#fff"
        active-text-color="#ffd04b"
        router>
      <el-menu-item v-for="item in menuList" :key="item.id" :index="item.path">{{ item.name }}</el-menu-item>
    </el-menu>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  data(){
    return {
      menuList: [
        {
          id: 1,
          name: '总票房榜',
          path: '/rankingList/totalBoxOfficeList'
        },
        {
          id: 2,
          name: '国内票房榜',
          path: '/rankingList/domesticBoxOfficeList'
        },
        {
          id: 3,
          name: '国外票房榜',
          path: '/rankingList/foreignBoxOfficeList'
        }
      ],
    }
  },
  methods:{
  },

}
</script>

<style scoped>
.el-menu{
  display: flex;
  justify-content: space-between;
}

.el-menu-item{
  font-size: 16px;
}


</style>
