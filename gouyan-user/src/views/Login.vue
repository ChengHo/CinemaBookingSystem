<template>
  <div class="login_container">
    <div class="login_box">
      <!-- 头像区域 -->
      <div class="avatar_box">
        <img src="../assets/logo.jpg">
      </div>
      <!-- 登录表单区域 -->
      <el-form class="login_form" :model="loginForm" :rules="loginFormRules" ref="loginFormRef">
        <!-- 用户名 -->
        <el-form-item prop="userName">
          <el-input v-model="loginForm.userName" prefix-icon="iconfont icon-user" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <!-- 密码 -->
        <el-form-item prop="password">
          <el-input v-model="loginForm.password" prefix-icon="iconfont icon-lock" placeholder="请输入密码" type="password"></el-input>
        </el-form-item>
        <!-- 按扭区域 -->
        <el-form-item class="btns">
          <el-button size="medium" :round="true" type="primary" @click="useVerify">点击登录</el-button>
          <el-button size="medium" :round="true" type="warning" @click="registerAccount">注册帐号</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div>
      <!-- 拼图验证码 -->
      <Verify
          @success="success"
          :mode="'pop'"
          :captchaType="'blockPuzzle'"
          :imgSize="{ width: '330px', height: '155px' }"
          ref="verify" >
      </Verify>
    </div>
  </div>
</template>

<script>
import Verify from "./../components/verifition/Verify";
export default {
  name: "Login",
  components: {
    Verify
  },
  data() {
    return {
      //登录表单数据对象
      loginForm:{
        userName : 'admin',
        password : '123456'
      },
      //表单验证规则
      loginFormRules: {
        //验证用户名
        userName: [
          { required: true, message: "请输入用户名称", trigger: "blur"},
          { min:2, max: 20, message: "长度在2到20个字符之间", trigger: "blur"}
        ],
        //验证密码
        password: [
          { required: true, message: "请输入密码", trigger: "blur"},
          { min:6, max: 16, message: "长度在6到16个字符之间", trigger: "blur"}
        ]
      }
    }
  },
  methods:{
    success(params){
      this.login()
    },
    useVerify(){
      this.$refs.verify.show()
    },
    login(){
      this.$refs.loginFormRef.validate(async valid =>{
        if(!valid) return;
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        const { data: res} = await axios.post('sysUser/login', JSON.stringify(this.loginForm));
        if(res.code != 200) return this.$message.error(res.msg);

        this.$message.success({message: "登录成功", duration: 1000});
        console.log(res.data);
        //保存token
        window.sessionStorage.setItem("token", res.data.token);
        res.data.sysUser.sysRole = null
        window.sessionStorage.setItem("loginUser", JSON.stringify(res.data.sysUser));
        //导航跳转到首页
        this.$router.push('/welcome');
      })
    },
    registerAccount(){
      this.$router.push('/register')
    }

  }
}
</script>

<style scoped>
.login_container{
  background: url("../assets/login-background3.jpg");
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