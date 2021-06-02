import Vue from 'vue'
/**权限指令**/
const has = Vue.directive('has', {
    // 当被绑定的元素插入到 DOM 中时……
    inserted: function (el, binding, vnode) {
        let btnPermission = '';
        // 获取路由按钮权限，路由的js文件中配置，是操作所需要的权限
        btnPermission = vnode.context.$route.meta.btnPermission;
        if (!Vue.prototype.$_has(btnPermission)) {
            console.log("not have this permission");
            el.remove()
        }
    }
});
// 权限检查方法
Vue.prototype.$_has = function (value) {
    let btnPermission = sessionStorage.getItem("btnPermission");
    if (btnPermission == undefined || btnPermission == null) {
        return false;
    }
    // value 是路由中所需要的权限，btnPermission是实际拥有的权限，在Login.vue登录时授权
    // console.log(value + "   === test ===   " + btnPermission)
    let res = value == btnPermission
    if(res) return true
    return false
};

export {has}