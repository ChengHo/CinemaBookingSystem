<template>
<div class="user-info-container">
  <div style="width: 30%">
    <h1>用户头像</h1>
    <el-upload action=""
               list-type="picture-card"
               :auto-upload="false"
               :limit="1"
               :file-list="pics"
               :on-change="handleChange"
               :on-success="handleSuccess"
               :on-error="handleError"
               :on-exceed="handleExceed"
               ref="pictureRef"
               :http-request="submitFile">
      <i slot="default" class="el-icon-plus"></i>
      <div slot="file" slot-scope="{file}">
        <img class="el-upload-list__item-thumbnail" :src="(picDialog? '' : global.base)+file.url" alt="">
        <span class="el-upload-list__item-actions">
          <span class="el-upload-list__item-delete" @click="handleRemove(file)">
            <i class="el-icon-delete"></i>
          </span>
        </span>
      </div>
    </el-upload>
  </div>
  <div style="width: 70%">
    <el-form :model="loginUser"  :rules="loginUserRules" ref="editFormRef" label-width="80px">
      <el-form-item label="用户名" prop="userName">
        <el-input v-model="loginUser.userName"></el-input>
      </el-form-item>
      <el-form-item label="电子邮箱" prop="email">
        <el-input v-model="loginUser.email"></el-input>
      </el-form-item>
      <el-form-item label="手机号码" prop="phoneNumber">
        <el-input v-model="loginUser.phoneNumber"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="sex">
          <el-radio v-model="loginUser.sex" :label="true">男</el-radio>
          <el-radio v-model="loginUser.sex" :label="false">女</el-radio>
      </el-form-item>
      <el-form-item label="生日" prop="birthday">
        <el-date-picker
            v-model="loginUser.birthday"
            value-format="yyyy-MM-dd"
            type="date"
            placeholder="选择日期"></el-date-picker>
      </el-form-item>
      <el-form-item label="个性签名" prop="autograph">
        <el-input v-model="loginUser.autograph"></el-input>
      </el-form-item>
        <el-button type="primary" @click="editUser">保存</el-button>
    </el-form>
  </div>
</div>
</template>

<script>
export default {
  name: "UserInfo",
  data() {
    let checkEmail = (rule, value, cb) => {
      const regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/
      if (regEmail.test(value)){
        return cb()
      }
      cb(new Error('请输入合法的邮箱'))
    }
    let checkMobile = (rule, value, cb) => {
      const regMobile = /^(0|86|17951)?(13[0-9]|15[0123456789]|17[678]|18[0-9]|14[57])[0-9]{8}$/
      if (regMobile.test(value)){
        return cb()
      }
      cb(new Error('请输入合法的手机号码'))
    }
    return {
      picDialog:false,
      loginUser:{},
      pics:[],
      pictureList:[],
      picSrc:"",
      deletePicList:[],

      //验证表单规则对象
      loginUserRules: {
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        email: [
          { required: true, message: '请输入电子邮箱', trigger: 'blur' },
          { validator: checkEmail, trigger: 'blur'}
        ],
        phoneNumber: [
          { required: true, message: '请输入手机号码', trigger: 'blur' },
          { validator: checkMobile, trigger: 'blur'}
        ],
        sex: [
          { required: true, message: '请选择性别', trigger: 'change' }
        ],
        birthday: [
          { required: true, message: '请选择生日', trigger: 'change' }
        ]
      }
    }
  },
  created() {
    this.getUser()
  },
  methods:{
    async getUser(){
      const { data : res } = await axios.get('sysUser/'+JSON.parse(window.sessionStorage.getItem('loginUser')).userId)
      this.loginUser = res.data
      this.pics.push({name:'picture',url:JSON.parse(this.loginUser.userPicture)[0]})
    },
    async handleSuccess(response, file, fileList){
      this.pics = fileList
      console.log(this.pics)
      await this.submitFile()
      this.picSrc = this.pictureList[0]
    },
    handleError(err){
      console.log(err)
    },
    handleChange(file, filelist){
      this.pics = filelist.slice(0)
      console.log(111)
      console.log(this.pics)
      this.picDialog =true
    },
    handleRemove(file) {
      const filePath = file.url
      console.log(filePath)
      const idx = this.pics.findIndex(x => x.url === filePath)
      if(file.status === 'success'){
        this.deletePicList.push(file.url)
      }
      this.pics.splice(idx, 1)
    },
     async editUser(){
       await this.submitFile()
       this.loginUser.userPicture = JSON.stringify(this.pictureList)
       const _this = this
       let success = true
       axios.defaults.headers.put['Content-Type'] = 'application/json'
       await axios.put('sysUser',JSON.stringify(this.loginUser)).then(resp=>{
         if (resp.data.code !== 200){
           this.$message.error('修改用户信息失败！')
           success = false
         }
       })
       if(!success) return
       this.$message.success('修改用户信息成功!')
       this.pics = []
       this.pictureList = []
       await this.getUser()
       this.picDialog = false
    },
    async submitFile(){
      const _this = this
      for (let i = 0; i < this.pics.length; i++){
        let formData = new FormData()
        if (this.pics[i].status === 'success') {
          let s = this.pics[i].url
          this.pictureList.push(s.substring(s.indexOf('/images')))
          continue
        }
        let file = this.pics[i].raw
        formData.append('file', file)
        await axios.post('upload/user', formData).then(response =>{
          console.log(response)
          _this.pictureList.push(response.data.data)
        })
      }
    },
    handleExceed(){
      this.$message.error("用户头像最多上传一张！")
    },
  }
}
</script>

<style scoped>
.user-info-container{
  display: flex;
}
</style>
