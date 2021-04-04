<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>演员管理</el-breadcrumb-item>
        <el-breadcrumb-item>演员信息</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">
        <el-col :span="4">
          <el-input placeholder="请输入演员姓名" v-model="inputActorName" />
        </el-col>
        <el-col :span="2">
          <el-button icon="el-icon-search" @click="getActorList">搜索</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="primary" @click="addDialogVisible = true" v-has>添加演员</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="multipleDelete" v-has>批量删除</el-button>
        </el-col>
      </el-row>

      <!--演员分类列表-->
      <el-table :data="actorList"  border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
<!--        <el-table-column prop="actorId" label="编号"></el-table-column>-->
        <el-table-column prop="actorName" label="姓名"></el-table-column>
        <el-table-column prop="actorHeight" label="身高"></el-table-column>
        <el-table-column prop="actorAge" label="年龄"></el-table-column>
        <el-table-column prop="actorGender" label="性别">
          <template slot-scope="scope">
            <div v-if="scope.row.actorGender">男</div>
            <div v-else>女</div>
          </template>
        </el-table-column>
        <el-table-column prop="actorSchool" label="毕业院校"></el-table-column>
        <el-table-column prop="actorNation" label="民族"></el-table-column>
        <el-table-column prop="actorBloodType" label="血型"></el-table-column>
        <el-table-column prop="actorConstellation" label="星座"></el-table-column>
        <el-table-column prop="actorNationality" label="国籍"></el-table-column>
        <el-table-column prop="actorInformation" label="信息" :show-overflow-tooltip="true"></el-table-column>
        <!--是否启用-->

        <el-table-column label="操作" width="120">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改演员信息" placement="top" :enterable="false" :open-delay="500">
              <el-button v-has type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.actorId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除演员" placement="top" :enterable="false" :open-delay="500">
              <el-button v-has type="danger" icon="el-icon-delete" size="mini" @click="deleteActorById(scope.row.actorId)"></el-button>
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

    <!--添加演员对话框-->
    <el-dialog title="添加演员" :visible.sync="addDialogVisible" width="60%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="演员姓名" prop="actorName">
          <el-input v-model="addForm.actorName"></el-input>
        </el-form-item>
        <el-form-item label="演员身高" prop="actorHeight">
          <el-input v-model="addForm.actorHeight"></el-input>
        </el-form-item>
        <el-form-item label="演员年龄" prop="actorAge">
          <el-input v-model="addForm.actorAge"></el-input>
        </el-form-item>
<!--        <el-form-item label="演员性别" prop="actorGender">-->
<!--        <el-input v-model="addForm.actorGender"></el-input>-->
<!--        </el-form-item> -->
        <el-form-item label="演员性别" prop="actorGender">
          <el-select v-model="addForm.actorGender" placeholder="请选择性别" clearable>
            <el-option v-for="item in gender" :key="item.gender" :label="item.name" :value="item.gender"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="毕业院校" prop="actorSchool">
          <el-input v-model="addForm.actorSchool"></el-input>
        </el-form-item>
        <el-form-item label="民族" prop="actorNation">
          <el-input v-model="addForm.actorNation"></el-input>
        </el-form-item>
        <el-form-item label="血型" prop="actorBloodType">
          <el-input v-model="addForm.actorBloodType"></el-input>
        </el-form-item>
        <el-form-item label="星座" prop="actorConstellation">
          <el-input v-model="addForm.actorConstellation"></el-input>
        </el-form-item>
        <el-form-item label="国籍" prop="actorNationality">
          <el-input v-model="addForm.actorNationality"></el-input>
        </el-form-item>
        <el-form-item label="信息" prop="actorInformation">
          <el-input v-model="addForm.actorInformation"></el-input>
        </el-form-item>
        <el-form-item label="演员图片">
          <el-upload action="" list-type="picture-card"
                     :auto-upload="false"
                     :file-list="pics"
                     :limit="1"
                     :on-change="handleChange"
                     :on-success="handleSuccess"
                     :on-error="handleError"
                     :on-exceed="handleExceed"
                     ref="pictureRef" :http-request="submitFile">
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="file.url" alt="">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreview(file)">
                  <i class="el-icon-zoom-in"></i>
                </span>
                <span v-if="!disabled" class="el-upload-list__item-delete" @click="handleRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
          <!--放大预览-->
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addActor">确 定</el-button>
      </span>
    </el-dialog>

    <!--修改演员对话框-->
    <el-dialog title="修改演员" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
        <el-form-item label="演员编号" prop="actorId">
          <el-input v-model="editForm.actorId" disabled></el-input>
        </el-form-item>
        <el-form-item label="演员姓名" prop="actorName">
          <el-input v-model="editForm.actorName"></el-input>
        </el-form-item>
        <el-form-item label="演员身高" prop="actorHeight">
          <el-input v-model="editForm.actorHeight"></el-input>
        </el-form-item>
        <el-form-item label="演员年龄" prop="actorAge">
          <el-input v-model="editForm.actorAge"></el-input>
        </el-form-item>
        <el-form-item label="演员性别" prop="actorGender">
          <el-select v-model="editForm.actorGender" placeholder="请选择性别" clearable>
            <el-option v-for="item in gender" :key="item.gender" :label="item.name" :value="item.gender"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="毕业院校" prop="actorSchool">
          <el-input v-model="editForm.actorSchool"></el-input>
        </el-form-item>
        <el-form-item label="民族" prop="actorNation">
          <el-input v-model="editForm.actorNation"></el-input>
        </el-form-item>
        <el-form-item label="血型" prop="actorBloodType">
          <el-input v-model="editForm.actorBloodType"></el-input>
        </el-form-item>
        <el-form-item label="星座" prop="actorConstellation">
          <el-input v-model="editForm.actorConstellation"></el-input>
        </el-form-item>
        <el-form-item label="国籍" prop="actorNationality">
          <el-input v-model="editForm.actorNationality"></el-input>
        </el-form-item>
        <el-form-item label="信息" prop="actorInformation">
          <el-input v-model="editForm.actorInformation"></el-input>
        </el-form-item>
        <el-form-item label="演员图片">
          <el-upload action=""
                     list-type="picture-card"
                     :auto-upload="false"
                     :file-list="pics"
                     :limit="1"
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
                <span v-if="!disabled" class="el-upload-list__item-delete" @click="handleRemove(file)">
                  <i class="el-icon-delete"></i>
                </span>
              </span>
            </div>
          </el-upload>
          <!--放大预览-->
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editActorInfo">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import global from "@/assets/css/global.css"
export default {
  name: "ActorInfo",
  data() {
    return {
      queryInfo: {
        actorId: '',
        actorName: '',
        pageNum: 1,
        pageSize: 7
      },
      actorlist: [],
      total: 0,
      url: 'http://localhost:8181/',
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      //添加演员的表单数据
      addForm: {
        actorName: '',
        actorPhoto: '',
        actorHeight: '',
        actorAge: '',
        actorGender: '',
        actorSchool: '',
        actorNation: '',
        actorBloodType: '',
        actorConstellation: '',
        actorNationality: '',
        actorInformation: ''
      },
      //验证表单规则对象
      addFormRules: {
        actorName: [
          { required: true, message: '请输入演员姓名', trigger: 'blur' }
        ],
        actorGender: [
          { required: true, message: '请输入演员性别', trigger: 'blur'}
        ]
      },
      editDialogVisible: false,
      inputActorName: '',
      editForm: {},
      editFormRules: {},
      gender: [

        {
          gender: false,
          name: '女'
        },
        {
          gender: true,
          name: '男'
        }
      ],
      selectedActorId: '',
      actorList: [],
      multipleSelection: [],
      arrangeDialogVisible: false,
      arrangeDialogWidth: '',
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        }
      },
      dialogImageUrl: '',
      dialogVisible: false,
      disabled: false,
      //添加删除图片 动态绑定图片列表
      pics: [],
      // 发送给后端的JSON图片数组
      pictureList: [],
      picNums: 0,
    }
  },
  created() {
    this.getActorList()
  },
  methods: {
    getActorList() {
      this.queryInfo.actorName = this.inputActorName
      this.queryInfo.actorId = this.selectedActorId
      const _this = this;
      axios.get('sysActor', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.actorList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getActorList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getActorList()
      console.log(newPage)
    },
    // 监听添加对话框的关闭事件
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
      this.pictureList = []
      this.pics = []
    },
    // 监听添加按钮
    async addActor() {
      await this.submitFile()
      console.log(this.pictureList)
      this.addForm.actorPhoto = JSON.stringify(this.pictureList)

      const _this = this
      this.$refs.addFormRef.validate(async valid => {
        console.log(valid)
        if (!valid) return
        // 预校验成功，发网络请求
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        await axios.post('sysActor', JSON.stringify(_this.addForm)).then(resp => {
          console.log(resp)
          if (resp.data.code !== 200) {
            this.$message.error('添加演员信息失败！')
          }
        })

        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        this.getActorList()
        this.$message.success('添加演员信息成功！')
      })
    },
    // 显示修改对话框，回显数据
    async showEditDialog(id) {
      const _this = this
      await axios.get('sysActor/' + id).then(resp => {
        console.log(resp)
        _this.editForm = resp.data.data
      })
      for (const item of JSON.parse(this.editForm.actorPhoto)) {
        let pic = {}
        pic['name'] = ''
        pic['url'] = this.global.base + item
        this.pics.push(pic)
      }
      console.log("aaa")
      console.log(this.pics)
      this.editDialogVisible = true
    },
    // 监听修改对话框的关闭事件
    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
      this.$refs.pictureEditRef.clearFiles()
      this.pics = []
      this.pictureList = []
    },
    // 修改演员分类信息并提交
    async editActorInfo() {
      await this.submitFile()
      this.editForm.actorPhoto = JSON.stringify(this.pictureList)
      this.$refs.editFormRef.validate(async valid => {
        const _this = this
        if (!valid) return
        let success = true
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        await axios.put('/sysActor', JSON.stringify(_this.editForm)).then(resp => {
          if (resp.data.code !== 200) {
            this.$message.error('修改演员信息失败！')
            success = false
          }
        })
        if (!success) return
        this.editDialogVisible = false
        this.getActorList()
        this.$message.success('修改演员信息成功！')
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
      if (resp == 'cancel'){
        return _this.$message.info('已取消删除')
      }

      let ids = []
      this.multipleSelection.forEach(data => {
        ids.push(data.actorId)
      })
      console.log(ids)
      await axios.delete('sysActor/' + ids).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除演员失败！')
        }
      })
      this.getActorList()
      this.$message.success('批量删除演员成功！')
    },
    //根据id删除对应的演员分类
    async deleteActorById(id){
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
      if (resp == 'cancel'){
        return _this.$message.info('已取消删除')
      }

      console.log(id)
      await axios.delete('sysActor/' + id).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('删除演员信息失败！')
        }
      })
      this.getActorList()
      this.$message.success('删除演员信息成功！')
    },
    handleRemove(file) {
      const filePath = file.url
      console.log(filePath)
      const idx = this.pics.findIndex(x => x.url === filePath)
      this.pics.splice(idx, 1)
    },
    handlePictureCardPreview(file) {
      console.log(this.pics)
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    handleChange(file, filelist){
      this.pics = filelist.slice(0)
      console.log(this.pics)
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
        await axios.post('upload/actor', formData).then(response =>{
          _this.pictureList.push(response.data.data)
        })
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
.seat{
  display: inline-block;
  width: 30px;
  height: 26px;
  margin: 0 5px;
  background-position: 0 1px;
}
.seat-default {
  background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAHKSURBVEhLxZfbysIwDMezKeJUVAR9A/H9X0FQZMOLeem14sWc4AnP9muybM4557eT/mCYdLT/tknaqQgJ/ACVf7/Oz4TfbvVisYDlcgm1Wg2SRON0OoGqqtDr9bglAAoHGY1GQgqzl5zz+SyGwyF7z7wITyYTtrJD13W2HrzEuFqtspUdnU4Hbrcbew5fSa5SqfQbYbmzoCgKew5fK6disciWgyd8vV5hPB5DoVAA27bpSct6vQbLsmjFhmFwK0MpJjFNky2H3W4nZEf24rPZbMTlcmFPiPv9LgaDAXu+rNY0jS0HzG5Zh+zFRwo9bS/GuNvtgpwM+SQsVwetVosa/GDnpMhFsfUAJ3I4HMgmYRQIZl1awsbzTyYyqzHRkhK2Yj+RwklwBYMHRpDMhd0tTrXiT52jwCsxCrqPZc3RARLM7O1266V/XMrlMlQqFfYcVqsVZXa9Xo8Wzhq/cOYx/i+e8KeYZIFfgyyMxWw2o4Y8mc/nXty9jz08NqfTKTSbTapBLAt8kh6buDocGh+3xNrtNjQaDbLxRSj7/f7pNolLv98Xx+ORvVfeBla+S3VJ4K7hGO/I7S8MDht2UbjklspRokj+NRQKwB/pWISi3oSUQQAAAABJRU5ErkJggg==") no-repeat;
}
.seat-choose{
  background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAKVSURBVEhLxZXPThpRFMY/hhFBG4okbdiYxgXpxmJi0phi4sKlL+HWlSsfwMSFr+DKjSufwMSFiyakaaagQaOxW1txUUjDHwVh5vacmdtxgGEsA1N/yYHLvdzzzT33nDMhQeAFUOT3f+fFhAeGutRs4tfpKV5dXECoqpz9R8hlKxqFsrqK96mUnOzGVfhrsYh3+/tIXV8Dk5Nydkh0HW3a+21zE59WVuTkE33C5/k8PmxvW4ITE/SPkFzxQacDUOS0nR18XFiQkxZ9dzx9dARwaCOR0UQZ9kP29vAQupz6S39y8UmVMeZcOIwInfp54QAQdJDe2LkLt9tAq2Vmp294L/vhe6Zxb13YwrSMvKZRZMIoLy2hvLYG3N/7E+c9FN7f2SzK8/MQiQS0szO5aGFndfHkBJndXSAeNzc2ZmehUw3GCwUru4eBTlpbXETs6grqwwNgGBBkX7a2kF1eNv9inziWy1minFxU/NM3N2jHYr5PbJAPtdGwHpp8hiiS6YMDUPBNTOE6WfL21sxAGx7Xav5KivaIx0fy7kghGqv0QHR+6yd/GGQUcx52M0Idu+0UDn+ORxovLp24i8CEO9SrvQhM+LlL8hQWnJHcBHxYiKvDA7OOqzTobGwgWalYjZ2hjlObm0N7Zmb4kqIkipZKmLq7e6oU8ldJJqHu7YGK1kOYke3OF1xKzvLsEfa+Y34IDrcfc4q6YAsrfDcBozgy3RSeIvuRyVidinsrNfixW7WKn+m0qcXYLwlum9+Pj5G4vITO709KEDaDmrsfFPLBrtnMrkhvqDfr63gt13nBlYZhiFyhIH8Nz2dNE005dmNgcgl6Fxv8dvGJXq9DcIgHYId63LBbvqpBeJfTCHiJMoEJewP8Afy6sw903o8jAAAAAElFTkSuQmCC") no-repeat;
}
</style>