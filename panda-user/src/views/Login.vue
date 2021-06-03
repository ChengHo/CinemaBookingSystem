<template>
  <div class="login_container">
    <div class="login_box">
      <div class="title_box">
        <p>用户登录</p>
      </div>
      <!-- 登录表单区域 -->
      <el-form class="login_form" :model="loginForm" :rules="loginFormRules" ref="loginFormRef">
        <!-- 用户名 -->
        <el-form-item prop="userName">
          <el-input v-model="loginForm.userName" placeholder="请输入用户名" clearable
                    prefix-icon="iconfont icon-user" ></el-input>
        </el-form-item>
        <!-- 密码 -->
        <el-form-item prop="password">
          <el-input v-model="loginForm.password" type="password" placeholder="请输入密码" show-password
                    prefix-icon="iconfont icon-lock"></el-input>
        </el-form-item>
        <!-- 按扭区域 -->
        <el-form-item class="btns">
          <el-button size="medium" :round="true" type="primary" @click="login">点击登录</el-button>
          <el-button size="medium" :round="true" type="warning" @click="registerAccount">注册帐号</el-button>
        </el-form-item>
      </el-form>
    </div>

  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      // 登录表单数据对象
      loginForm:{
        userName : 'admin',
        password : '123456'
      },
      // 登录表单验证规则
      loginFormRules: {
        // 验证用户名格式
        userName: [
          { required: true, message: "请输入用户名称", trigger: "blur"},
          { min:2, max: 20, message: "用户名称长度在2到20个字符之间", trigger: "blur"}
        ],
        // 验证密码格式
        password: [
          { required: true, message: "请输入密码", trigger: "blur"},
          { min:6, max: 16, message: "登录密码长度在6到16个字符之间", trigger: "blur"}
        ]
      },
      sessionId: 0
    }
  },
  created() {
    this.sessionId = window.sessionStorage.getItem('sessionId')
    console.log('this sessionId is : ' + this.sessionId)
    window.sessionStorage.setItem('sessionId', 0)
  },
  methods: {
    success(params) {
      this.login()
    },
    login() {
      this.$refs.loginFormRef.validate(async valid => {
        if(!valid) return;
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        const { data: res} = await axios.post('sysUser/login', JSON.stringify(this.loginForm));
        if(res.code !== 200) return this.$message.error(res.msg);

        this.$message.success({message: "登录成功", duration: 1000});
        console.log(res.data);
        // 保存token
        window.sessionStorage.setItem("token", res.data.token);
        res.data.sysUser.sysRole = null
        window.sessionStorage.setItem("loginUser", JSON.stringify(res.data.sysUser));
        if (this.sessionId !==0 && this.sessionId !=='0' && this.sessionId !== null) {
          this.$router.push('/chooseSeat/' + this.sessionId)
          return
        }
        // 导航跳转到首页
        this.$router.push('/welcome');
      })
    },
    registerAccount() {
      this.$router.push('/register')
    }
  }
}
</script>

<style scoped>
.login_container{
  background: url("../assets/login-background.jpg");
  background-size: cover;
  height: 100%;
}

.login_box{
  width: 450px;
  height: 300px;
  background-color: #fff;
  border-radius: 3px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.avatar_box{
  height: 130px;
  width: 130px;
  border: 1px solid #eee;
  border-radius: 50%;
  padding: 10px;
  box-shadow: 0 0 10px #ddd;
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #fff;
}

.avatar_box > img{
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background-color: #eee;
}

.title_box{
  text-align: center;
  font-size: 200%;
}

.login_form{
  position: absolute;
  bottom: 0;
  width: 100%;
  padding: 0 20px;
  box-sizing: border-box;
}

.btns{
  display: flex;
  justify-content: center;
}
</style>
