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
        <img class="el-upload-list__item-thumbnail" :src="(picDialog?'':global.base)+file.url" alt="">
        <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-delete" @click="handleRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
        </span>
      </div>
    </el-upload>
  </div>
  <div style="width: 70%">
    <el-form :model="loginUser"  ref="editFormRef" label-width="80px">
      <el-form-item label="昵称" prop="userName">
        <el-input v-model="loginUser.userName"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="sex">
          <el-radio v-model="loginUser.sex" :label="true">男</el-radio>
          <el-radio v-model="loginUser.sex" :label="false">女</el-radio>
      </el-form-item>
      <el-form-item label="生日" prop="birthday">
        <el-date-picker
            v-model="information.birthday"
            type="date"
            placeholder="选择日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="生活状态" prop="condition">
        <el-radio v-model="information.condition" label="1">单身</el-radio>
        <el-radio v-model="information.condition" label="2">热恋中</el-radio>
        <el-radio v-model="information.condition" label="3">已婚</el-radio>
        <el-radio v-model="information.condition" label="4">为人父母</el-radio>
      </el-form-item>
      <el-form-item label="从事行业" prop="job">
        <el-cascader
            v-model="information.job"
            :options="options">
        </el-cascader>
      </el-form-item>
      <el-form-item label="兴趣爱好" prop="hobbies">
        <el-checkbox-group
            v-model="information.hobbies" >
          <el-checkbox v-for="hobby in hobbyList" :label="hobby.userHobbyId" :key="hobby.userHobbyId">{{hobby.userHobbyName}}</el-checkbox>
        </el-checkbox-group>
      </el-form-item>
      <el-form-item label="个性签名" prop="autograph">
        <el-input v-model="information.autograph"></el-input>
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
    return {
      picDialog:false,
      loginUser:{},
      pics:[],
      pictureList:[],
      picSrc:"",
      deletePicList:[],
      hobbyList:[],
      information: {
        birthday:'',
        condition:'',
        job:[],
        hobbies:[],
        autograph:''
      },
      options:[{value:1,label:'信息技术',children:[{value:11,label:'互联网'},{value:12,label:'IT'}]},
        {value:2,label: '金融保险',children: [{value:21,label:'投资股票'},{value:22,label:'保险'}]}]
    }
  },
  methods:{
    async getUser(){
      const { data : res } = await axios.get('sysUser/'+JSON.parse(window.sessionStorage.getItem('loginUser')).userId)
      this.loginUser = res.data
      this.pics.push({name:'picture',url:JSON.parse(this.loginUser.userPicture)[0]})
      console.log(this.picSrc)
      this.information = JSON.parse(this.loginUser.information)
      console.log(this.loginUser)
      console.log(this.information)
    },
    async getHobbyList(){
      const _this = this
      await axios.get('sysUserHobby').then(resp=>{
        _this.hobbyList = resp.data.data
      })
      console.log('hobbyList')
      console.log(_this.hobbyList)
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
      this.loginUser.information = JSON.stringify(this.information)
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
       this.getUser()
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
  },
  created() {
    this.getUser()
    this.getHobbyList()
  }
}
</script>

<style scoped>
.user-info-container{
  display: flex;
}
</style>