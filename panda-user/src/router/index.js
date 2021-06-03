import Vue from 'vue'
import VueRouter from 'vue-router'
import { Message }from 'element-ui'

import Login from "../views/Login";
import Welcome from "../views/Welcome";
import Register from "../views/Register";
import Error404 from "../views/Error404";

import Home from "../views/home/Home";
import Movie from "../views/movie/Movie";
import AboutUs from "../views/cinema/AboutUs";
import RankingList from "../views/rankinglist/RankingList";
import TotalBoxOfficeList from "../views/rankinglist/TotalBoxOfficeList";
import DomesticBoxOfficeList from "../views/rankinglist/DomesticBoxOfficeList";
import ForeignBoxOfficeList from "../views/rankinglist/ForeignBoxOfficeList";
import MovieOngoing from "../views/movie/MovieOngoing";
import MovieUpcoming from "../views/movie/MovieUpcoming";
import MovieClassics from "../views/movie/MovieClassics";
import MovieInfo from "../views/movie/MovieInfo";
import ChooseSession from "../views/cinema/ChooseSession";
import ChooseSeat from "../views/pay/ChooseSeat";
import BillDetail from "../views/pay/BillDetail";
import Search from "../views/search/Search";
import SearchMovie from "../views/search/SearchMovie";
import UserMenu from "../views/user/UserMenu";
import UserInfo from "../views/user/UserInfo";
import BillInfo from "../views/user/BillInfo";

Vue.use(VueRouter)

const routes = [
  {
    path:'/', redirect: 'home'
  },
  {
    path: '/login',
    component: Login
  },
  {
    path: '/welcome',
    component: Welcome,
    redirect: { name: 'home'},
    children: [
      { path: '/home/', name: 'home', component: Home },
      {
        path: '/userMenu',
        name: 'userMenu',
        component: UserMenu,
        redirect: {name: 'userInfo'},
        children:[
          {path: '/user', component: UserInfo,name:'userInfo'},
          {path: '/bill', component: BillInfo, name:'billInfo'}
        ]
      },
      {
        path: '/movie/',
        component: Movie,
        name: 'movie',
        redirect: {name: '正在热映'},
        children: [
          { path: 'movieOngoing', name:'正在热映', component: MovieOngoing },
          { path: 'movieUpcoming', name: '即将上映', component: MovieUpcoming },
          { path: 'movieClassics', name: '经典影片', component: MovieClassics }
          ]
      },
      {
        path: '/movieInfo/:movieId',
        name: '电影详细信息',
        component: MovieInfo
      },
      {
        path: '/aboutUs/',
        name: '关于我们',
        component: AboutUs
      },
      {
        path: '/chooseSession/:cinemaId',
        name: '影院详细信息',
        component: ChooseSession
      },
      {
        path: '/rankingList/',
        component: RankingList,
        name: 'rankingList',
        redirect: '/rankingList/totalBoxOfficeList',
        children: [
          { path: 'totalBoxOfficeList', name: '总票房榜', component: TotalBoxOfficeList},
          { path: 'domesticBoxOfficeList', name: '国内票房榜', component: DomesticBoxOfficeList},
          { path: 'foreignBoxOfficeList', name: '国外票房榜', component: ForeignBoxOfficeList}
        ]
      },
      {
        path: '/chooseSeat/:sessionId',
        component: ChooseSeat,
        name: 'chooseSeat'
      },
      {
        path: '/billDetail/:billId',
        component: BillDetail,
        name: 'billDetail'
      },
      {
        path: '/search/',
        component: Search,
        name: 'search',
        redirect: { name:'searchMovie' },
        children: [
          {
            path:'searchMovie',
            component: SearchMovie,
            name: 'searchMovie'
          }
        ]
      }
    ]
  },
  {
    path: '/register',
    component: Register
  },
  {
    path: '/*',
    component: Error404
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})


//挂载路由导航守卫
router.beforeEach((to, from, next) =>{
  //to 将要访问的路径
  //from 从哪个页面来
  //next 一个放行函数

  if (to.path === '/user' || to.path === '/bill' || to.path.indexOf('/billDetail') !== -1) {
    //获取token
    const token = window.sessionStorage.getItem("token")
    if(!token){
      Message.error('抱歉，请先登录')
      return next('/login');
    }
  }
  next();
})

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location){
  return originalPush.call(this, location).catch(err => err)
}
export default router
