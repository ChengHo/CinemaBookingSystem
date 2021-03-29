import Vue from 'vue'
/**权限指令**/
const has = Vue.directive('has', {
    // 当被绑定的元素插入到 DOM 中时……
    inserted: function (el, binding, vnode) {
        let btnPermission = '';
        // 获取路由按钮权限
        btnPermission = vnode.context.$route.meta.btnPermission;
        if (!Vue.prototype.$_has(btnPermission)) {
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
    //console.log(value + " " + btnPermission)
    let res = value == btnPermission
    if(res) return true
    return false
};

export {has}