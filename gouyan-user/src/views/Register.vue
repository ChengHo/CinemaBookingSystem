<template>
  <div class="register-container">
    <div class="header" @click="toWelcome">
      <img src="../assets/registerLogo.jpg" style="width: 230px; height: 54px;">
    </div>
    <div class="register-body">
      <el-form class="register-form" ref="registerFormRef" :model="registerForm" :rules="registerFormRules" label-width="80px">
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="registerForm.userName"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="registerForm.password" type="password"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="registerForm.confirmPassword" type="password"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-radio v-model="gender" label="0">女</el-radio>
          <el-radio v-model="gender" label="1">男</el-radio>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="register">同意以下协议并注册</el-button>
        </el-form-item>
        <el-form-item id="protocal">
          <el-link type="primary" style="line-height: 14px;">《假装有协议》</el-link>
          <el-link type="primary" style="line-height: 14px;">《这里无协议》</el-link>
        </el-form-item>
      </el-form>
      <img src="../assets/register.png">
    </div>
    <div class="footer-mini"></div>
    <div class="footer">
      <img style="width: 357px; height: 50px" src="../assets/register-footer.png">
    </div>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    var validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'))
        // password 是表单上绑定的字段
      } else if (value !== this.registerForm.password) {
        callback(new Error('两次输入密码不一致!'))
      } else {
        callback()
      }
    }
    return {
      gender: '0',
      registerForm: {
        userName: '',
        password: '',
        confirmPassword: '',
        sex: '',
      },
      registerFormRules: {
        userName: [
          { required: true, message: "请输入用户名称", trigger: "blur"},
          { min: 2, max: 20, message: "长度在2到20个字符之间", trigger: "blur"}
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur"},
          { min:6, max: 16, message: "长度在6到16个字符之间", trigger: "blur"}
        ],
        confirmPassword: [
          { required: true, validator: validatePass, message: "两次密码输入不一致", trigger: "blur"},
        ]
      }
    }
  },
  methods:{
    register(){
      this.$refs.registerFormRef.validate(async valid =>{
        if(!valid) return
        this.registerForm.sex = this.gender === '1'
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        const { data: res} = await axios.post('sysUser', JSON.stringify(this.registerForm));
        if(res.code != 200) return this.$message.error(res.msg);

        this.$message.success("注册完成！");
        this.$router.push('/login')
        this.$refs.registerFormRef.resetFields()
      })
    },
    toWelcome(){
      this.$router.push('/welcome')
    }
  }
}
</script>

<style scoped>
.register-container{
  width: 100%;
  height: 100%;
}

.header{
  height: 60px;
  border-bottom: deepskyblue solid 2px;
  padding-top: 6px;
  padding-left: 500px;
  padding-bottom: 0;
  cursor: pointer;
}

.register-body{
  display: flex;
  padding-top: 50px;
}

.register-form{
  width: 20%;
  margin-left: 25%;
  margin-right: 5%;
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
</style>