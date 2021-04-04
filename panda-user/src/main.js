import Vue from 'vue'
import './plugins/axios'
import App from './App.vue'
import router from './router'
import store from './store'
import './plugins/element.js'
import {Message} from 'element-ui'
import './assets/css/fonts/iconfont.css'
import global_variable from "@/components/global_variable";

Vue.prototype.global = global_variable

Vue.config.productionTip = false

axios.defaults.baseURL = 'http://127.0.0.1:8181/'
axios.interceptors.request.use(config => {
  config.headers.Token = window.sessionStorage.getItem('token')
  return config
})

// 状态码错误信息
const codeMessage = {
  401: '用户没有权限，请登录',
  403: '用户没有权限，请联系管理员',
  404: '访问的资源不存在',
  406: '请求的格式不可得',
  410: '请求的资源被永久删除，且不会再得到的',
  422: '当创建一个对象时，发生一个验证错误',
  500: '服务器发生错误，请检查服务器',
  502: '网关错误',
  503: '服务不可用，服务器暂时过载或维护',
  504: '网关超时'
};

axios.interceptors.response.use(response => {
  return response
}, error => {
  if(error){
    if(!error.response){
      return console.log('Error', error.message);
    }
    //获取状态码
    const status = error.response.status;
    const errortext = codeMessage[status] || error.response.statusText;

    //提示错误信息
    Message.error(errortext)

    // 错误状态处理
    if (status === 401) {
      router.push('/login')
    } else if (status === 403) {
      router.push('/login')
    } else if (status >= 404 && status < 422) {
      router.push('/404')
    }
  }
  return Promise.reject(error)
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
