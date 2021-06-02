<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>用户管理</el-breadcrumb-item>
        <el-breadcrumb-item>用户信息管理</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">

        <el-col :span="4">
          <el-input placeholder="请输入用户名" v-model="inputUserName" clearable />
        </el-col>
        <el-col :span="4">
          <el-input placeholder="请输入邮箱" v-model="inputEmail" clearable />
        </el-col>
        <el-col :span="4">
          <el-input placeholder="请输入手机号" v-model="inputPhoneNumber" clearable />
        </el-col>
        <el-col :span="4">
          <el-select v-model="selectedSex" placeholder="请选择性别" clearable>
            <el-option v-for="item in gender" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-col>
        <el-col :span="2">
          <el-button icon="el-icon-search" @click="getUserList">搜索</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="primary" @click="showAddDialog">添加用户</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="multipleDelete">批量删除</el-button>
        </el-col>
      </el-row>

      <el-table :data="userList" style="width: 80%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="40"></el-table-column>
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column prop="userName" label="用户名" width="120px"></el-table-column>
        <el-table-column prop="email" label="电子邮箱"></el-table-column>
        <el-table-column prop="phoneNumber" label="手机号码"></el-table-column>
        <el-table-column prop="sex" label="性别" :formatter="sexFormat" width="100px"></el-table-column>
        <el-table-column prop="sysRole.roleName" label="角色" width="120px"></el-table-column>

        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改用户信息" placement="top" :enterable="false" :open-delay="500">
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.userId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除用户" placement="top" :enterable="false" :open-delay="500">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteUserById(scope.row.userId)"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <!--分页区域-->
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryInfo.pageNum"
          :page-sizes="[5, 7, 9]"
          :page-size="queryInfo.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>

    </el-card>

    <!--添加用户对话框-->
    <el-dialog title="添加用户" :visible.sync="addDialogVisible" width="60%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="150px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="addForm.userName"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="addForm.password" type="password" show-password></el-input>
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="addForm.email"></el-input>
        </el-form-item>
        <el-form-item label="手机号码" prop="phoneNumber">
          <el-input v-model="addForm.phoneNumber"></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-select v-model="addForm.sex" placeholder="请选择性别" clearable >
            <el-option
                v-for="item in gender"
                :key="item.id"
                :label="item.name"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="权限" prop="roleId">
          <el-select v-model="addForm.roleId" placeholder="请选择权限" clearable >
            <el-option
                v-for="item in roleList"
                :key="item.roleId"
                :label="item.roleName"
                :value="item.roleId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="头像">
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
              <img class="el-upload-list__item-thumbnail" :src="file.url" alt="">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                  <i class="el-icon-zoom-in"></i>
                </span>
                <span class="el-upload-list__item-delete" @click="handleRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
          <!--放大预览-->
          <el-dialog :visible.sync="dialogVisible" append-to-body>
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addUser">确 定</el-button>
      </span>
    </el-dialog>

    <!--修改用户对话框-->
    <el-dialog title="修改用户信息" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="150px">
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="editForm.userName"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="editForm.password" type="password" show-password></el-input>
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="editForm.email"></el-input>
        </el-form-item>
        <el-form-item label="手机号码" prop="phoneNumber">
          <el-input v-model="editForm.phoneNumber"></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="sex">
          <el-select v-model="editForm.sex" placeholder="请选择性别" clearable >
            <el-option
                v-for="item in gender"
                :key="item.id"
                :label="item.name"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="权限" prop="roleId">
          <el-select v-model="editForm.roleId" placeholder="请选择权限" clearable >
            <el-option
                v-for="item in roleList"
                :key="item.roleId"
                :label="item.roleName"
                :value="item.roleId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="头像">
          <el-upload action=""
                     list-type="picture-card"
                     :auto-upload="false"
                     :limit="1"
                     :file-list="pics"
                     :on-change="handleChange"
                     :on-success="handleSuccess"
                     :on-error="handleError"
                     :on-exceed="handleExceed"
                     ref="pictureEditRef"
                     :http-request="submitFile">
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="file.url" alt="">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                  <i class="el-icon-zoom-in"></i>
                </span>
                <span class="el-upload-list__item-delete" @click="handleRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
          <!--放大预览-->
          <el-dialog :visible.sync="dialogVisible" append-to-body>
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelEdit">取 消</el-button>
        <el-button type="primary" @click="editUserInfo">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import global from "../../assets/css/global.css"
export default {
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
      queryInfo: {
        userName: '',
        phoneNumber: '',
        email: '',
        sex: '',
        pageNum: 1,
        pageSize: 7
      },
      total: 0,
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      //添加影院的表单数据
      addForm: {
        userId: '',
        userName: '',
        password: '',
        email: '',
        phoneNumber: '',
        sex: '',
        userPicture: ''
      },
      //验证表单规则对象
      addFormRules: {
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
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
        ]
      },
      editDialogVisible: false,
      editForm: {},
      editFormRules: {
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
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
        ]
      },
      inputUserName: '',
      inputEmail: '',
      inputPhoneNumber: '',
      selectedSex: '',
      userList: [],
      gender: [
        {
          id: false,
          name: '女'
        },
        {
          id: true,
          name: '男'
        }
      ],
      multipleSelection: [],
      dialogImageUrl: '',
      dialogVisible: false,
      //添加删除图片 动态绑定图片列表
      pics: [],
      // 发送给后端的JSON图片数组
      pictureList: [],
      picNums: 0,
      deletePicList: [],
      roleList: []
    }
  },
  created() {
    this.getUserList()
    this.getRoleList()
  },
  methods: {
    getUserList() {
      this.queryInfo.userName = this.inputUserName
      this.queryInfo.email = this.inputEmail
      this.queryInfo.phoneNumber = this.inputPhoneNumber
      this.queryInfo.sex = this.selectedSex
      const _this = this;
      axios.get('sysUser', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.userList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    getRoleList(){
      const _this = this
      axios.get('sysRole').then(resp => {
        _this.roleList = resp.data.data
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getUserList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getUserList()
      console.log(newPage)
    },
    showAddDialog(){
      this.addDialogVisible = true
    },
    // 监听添加对话框的关闭事件
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
      this.$refs.pictureRef.clearFiles()
      this.pics = []
      this.pictureList = []
    },
    // 监听添加按钮
    async addUser(){
      await this.submitFile()
      console.log(this.pictureList)
      this.addForm.userPicture = JSON.stringify(this.pictureList)
      let success = true
      const _this = this
      this.$refs.addFormRef.validate(async valid => {
        console.log(valid)
        if (!valid) return
        // 预校验成功，发网络请求
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        await axios.post('sysUser', JSON.stringify(_this.addForm)).then(resp => {
          console.log(resp)
          if (resp.data.code !== 200){
            this.$message.error('添加用户失败！')
            success = false
          }
        })
        this.getUserList()
        if (!success) return
        //隐藏添加对话框
        this.addDialogVisible = false
        this.$message.success('添加用户成功！')
      })
    },
    // 显示修改对话框，回显数据
    async showEditDialog(id){
      const _this = this
      await axios.get('sysUser/' + id).then(resp => {
        _this.editForm = resp.data.data
      })
      for (const item of JSON.parse(this.editForm.userPicture)) {
        let pic = {}
        pic['name'] = ''
        pic['url'] = this.global.base + item
        this.pics.push(pic)
      }
      this.editDialogVisible = true
    },
    // 监听修改对话框的关闭事件
    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
      this.$refs.pictureEditRef.clearFiles()
      this.pics = []
      this.pictureList = []
    },
    // 取消修改
    cancelEdit(){
      this.editDialogVisible = false
      this.deletePicList.splice(0, this.deletePicList.length)
    },
    async editUserInfo(){
      await this.submitFile()
      this.editForm.userPicture = JSON.stringify(this.pictureList)
      this.$refs.editFormRef.validate(async valid => {
        const _this = this
        if (!valid) return
        let success = true
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        await axios.put('sysUser', JSON.stringify(_this.editForm)).then(resp => {
          if (resp.data.code !== 200){
            this.$message.error('修改用户信息失败！')
            success = false
          }
        })
        if (!success) return
        this.editDialogVisible = false
        this.getUserList()
        this.$message.success('修改用户信息成功！')
        for(let s of this.deletePicList){
          await axios.get('/upload/delete?filePath=' + s.substring(s.indexOf('/images')))
        }
      })
    },
    // 监听多选框变化
    handleSelectionChange(val){
      this.multipleSelection = val
    },
    async multipleDelete(){
      const _this = this
      //询问用户是否确认删除
      const resp = await this.$confirm('此操作将永久删除这些条目, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)

      // 用户确认删除, resp为字符串"confirm"
      // 用户取消删除，resp为字符串"cancel"
      if (resp === 'cancel'){
        return _this.$message.info('已取消删除')
      }

      let ids = []
      this.multipleSelection.forEach(data => {
        ids.push(data.userId)
      })
      console.log(ids)
      await axios.delete('sysUser/' + ids).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除用户失败！')
        }
      })
      this.getUserList()
      this.$message.success('批量删除用户成功！')
    },
    //根据id删除对应的影厅分类
    async deleteUserById(id){
      const _this = this
      //询问用户是否确认删除
      const resp = await this.$confirm('此操作将永久删除该条目, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)

      // 用户确认删除, resp为字符串"confirm"
      // 用户取消删除，resp为字符串"cancel"
      console.log(resp)
      if (resp === 'cancel'){
        return _this.$message.info('已取消删除')
      }

      await axios.delete('sysUser/' + id).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.success('删除用户失败！')
        }
      })
      this.getUserList()
      this.$message.success('删除用户成功！')
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
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    handleChange(file, filelist){
      this.pics = filelist.slice(0)
    },
    handleSuccess(response){
      this.pictureList.push(response.data)
      this.addForm = JSON.stringify(this.pictureList)
      this.editForm = JSON.stringify(this.pictureList)
    },
    handleError(err){
      console.log(err)
    },
    handleExceed(){
      this.$message.error("用户头像最多上传一张！")
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
          _this.pictureList.push(response.data.data)
        })
      }
    },
    sexFormat(row){
      if (row.sex === true){
        return '男'
      }else {
        return '女'
      }
    }
  }
}
</script>

<style scoped>
.row{
  white-space: nowrap;
  margin-top: 10px;
  padding: 0 10px;
  text-align: center;
  display: flex;
  justify-content: space-between;
}


</style>
