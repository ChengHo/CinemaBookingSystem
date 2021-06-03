<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>影院管理</el-breadcrumb-item>
        <el-breadcrumb-item>影院信息管理</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <!--卡片视图-->
    <el-card class="box-card">
      <!--表格显示影院信息-->
      <el-form :model="cinemaInfo" label-width="150px">
        <el-form-item label="影院名称: " prop="cinemaName">
          <el-input class="el-input-show" v-model="cinemaInfo.cinemaName" disabled></el-input>
        </el-form-item>
        <el-form-item label="影院地址: " prop="cinemaAddress">
          <el-input class="el-input-show" v-model="cinemaInfo.cinemaAddress" disabled></el-input>
        </el-form-item>
        <el-form-item label="影院电话: " prop="cinemaPhone">
          <el-input class="el-input-show" v-model="cinemaInfo.cinemaPhone" disabled></el-input>
        </el-form-item>
        <el-form-item label="营业时间: " prop="cinemaPhone">
          <el-input class="el-input-show-time" v-model="cinemaInfo.workStartTime" disabled></el-input>
          至
          <el-input class="el-input-show-time" v-model="cinemaInfo.workEndTime" disabled></el-input>
        </el-form-item>
        <el-form-item label="拥有影厅类型: " prop="hallCategory">
          <el-tag v-for="hall in halls" >{{hall}}</el-tag>
        </el-form-item>
        <el-form-item label="影院图片: ">
          <span v-for="item in pics">
            <el-popover placement="left" trigger="click" width="300">
              <img :src="item.url" width="200%"/>
              <img slot="reference" :src="item.url" :alt="item"
                   style="max-height: 300px;max-width: 300px;padding: 10px"/>
            </el-popover>
          </span>
        </el-form-item>
        <el-form-item label="" prop="cinemaName">
          <el-button type="primary" @click="showEditDialog">修改影院信息</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!--修改影院对话框-->
    <el-dialog title="修改影院" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="150px">
        <el-form-item label="影院名称" prop="cinemaName">
          <el-input v-model="editForm.cinemaName"></el-input>
        </el-form-item>
        <el-form-item label="影院地址" prop="cinemaAddress">
          <el-input v-model="editForm.cinemaAddress"></el-input>
        </el-form-item>
        <el-form-item label="影院电话" prop="cinemaPhone">
          <el-input v-model="editForm.cinemaPhone"></el-input>
        </el-form-item>
        <el-form-item label="开始营业时间" prop="workStartTime">
          <el-time-picker
            v-model="editForm.workStartTime"
            value-format="HH:mm"
            placeholder="选择开始营业时间">
          </el-time-picker>
        </el-form-item>
        <el-form-item label="结束营业时间" prop="workEndTime">
          <el-time-picker
            v-model="editForm.workEndTime"
            value-format="HH:mm"
            placeholder="选择结束营业时间">
          </el-time-picker>
        </el-form-item>
        <el-form-item label="拥有影厅类型" prop="hallCategoryList">
          <el-input class="el-input-hall" placeholder="请输入添加影厅类别名称" v-model="inputHall" clearable></el-input>
          <el-button type="primary" @click="addHallCategory()">添加</el-button>
        </el-form-item>
        <el-form-item >
          <el-tag
            v-for="(item, index) in halls"
            :key="index"
            closable
            @close="deleteHallCategory(index)">
            {{item}}
          </el-tag>
        </el-form-item>

        <el-form-item label="影院图片">
          <el-upload action="" list-type="picture-card"
                     :auto-upload="false"
                     :file-list="pics"
                     :on-change="handleChange"
                     :on-success="handleSuccess"
                     :on-error="handleError"
                     ref="pictureEditRef"
                     :http-request="submitFile">
            <i slot="default" class="el-icon-plus"></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail"
                   :src="file.url" alt="">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview"
                      @click="handlePictureCardPreview(file)">
                  <i class="el-icon-zoom-in"></i>
                </span>
                <span class="el-upload-list__item-delete"
                      @click="handleRemove(file)">
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
        <el-button type="primary" @click="editCinemaInfo">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  import global from "../../assets/css/global.css"
  export default {
    data() {
      return {
        //控制对话框的显示与隐藏
        editDialogVisible: false,
        editForm: {},
        cinemaInfo: {},
        editFormRules: {
          cinemaName: [
            { required: true, message: '请输入影院名称', trigger: 'change' }
          ],
          cinemaAddress: [
            { required: true, message: '请输入影院地址', trigger: 'change' }
          ],
          cinemaPhone: [
            { required: true, message: '请输入影院电话', trigger: 'change' }
          ]
        },
        inputHall: '',

        dialogImageUrl: '',
        dialogVisible: false,
        hideUpload: false,
        //添加删除图片 动态绑定图片列表
        pics: [],
        //添加删除影厅类别 动态绑定影厅列表
        halls: [],
        // 发送给后端的JSON图片数组
        pictureList: [],
        picNums: 0,
        deletePicList: []
      }
    },
    created() {
      this.getCinemaInfo()
    },
    methods: {
      async getCinemaInfo() {
        const _this = this
        await axios.get('sysCinema').then(resp => {
          _this.cinemaInfo = resp.data.data
        })
        _this.pics = []
        _this.halls = []

        for (const item of JSON.parse(this.cinemaInfo.cinemaPicture)) {
          let pic = {}
          pic['name'] = ''
          pic['url'] = this.global.base + item
          this.pics.push(pic)
        }
        for (const item of JSON.parse(this.cinemaInfo.hallCategoryList)) {
          this.halls.push(item)
        }
      },
      // 显示修改对话框，回显数据
      async showEditDialog() {
        this.editForm = this.cinemaInfo
        this.editDialogVisible = true
      },
      // 监听修改对话框的关闭事件
      editDialogClosed() {
        this.$refs.editFormRef.resetFields()
        this.$refs.pictureEditRef.clearFiles()
        this.pics = []
        this.pictureList = []
        this.halls = []
        this.getCinemaInfo()
      },
      // 取消修改
      cancelEdit() {
        this.editDialogVisible = false
        this.deletePicList.splice(0, this.deletePicList.length)
      },
      async editCinemaInfo() {
        await this.submitFile()
        this.editForm.cinemaPicture = JSON.stringify(this.pictureList)
        this.editForm.hallCategoryList = JSON.stringify(this.halls)
        this.$refs.editFormRef.validate(async valid => {
          const _this = this
          if (!valid) return
          let success = true
          axios.defaults.headers.put['Content-Type'] = 'application/json'
          await axios.put('sysCinema/update', JSON.stringify(_this.editForm)).then(resp => {
            if (resp.data.code !== 200){
              this.$message.error('修改影院信息失败！')
              success = false
            }
          })
          if (!success) return
          this.editDialogVisible = false
          await this.getCinemaInfo()
          this.$message.success('修改影院信息成功！')
          for(let item of this.deletePicList) {
            await axios.get('/upload/delete?filePath=' + item.substring(item.indexOf('/images')))
          }
        })
      },
      addHallCategory() {
        if (this.inputHall === '' || this.inputHall === null) {
          this.$alert('影厅类别添加失败！原因：所添加的影厅类别不能为空。', '影厅类别添加异常', {
            confirmButtonText: '我知道了'
          })
          return
        } else if (!this.halls.includes(this.inputHall)) {
          this.halls.push(this.inputHall)
        } else {
          console.log('已存在')
          this.$alert('影厅类别添加失败！原因：所添加的影厅类别已存在。', '影厅类别添加异常', {
            confirmButtonText: '我知道了'
          })
        }
        this.inputHall = ''
      },
      deleteHallCategory(index) {
        this.halls.splice(index, 1)
        console.log(this.halls)
      },
      handleRemove(file, fileList) {
        const filePath = file.url
        console.log(filePath)
        const idx = this.pics.findIndex(x => x.url === filePath)
        if (file.status === 'success') {
          this.deletePicList.push(file.url)
        }
        this.pics.splice(idx, 1)
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url
        this.dialogVisible = true
      },
      handleChange(file, filelist){
        this.pics = filelist.slice(0)
      },
      handleSuccess(response){
        this.pictureList.push(response.data)
        this.editForm = JSON.stringify(this.pictureList)
      },
      handleError(err){
        console.log(err)
      },
      async submitFile() {
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
          await axios.post('upload/cinema', formData).then(response =>{
            _this.pictureList.push(response.data.data)
          })
        }
      }
    }
  }
</script>

<style scoped>
.el-tag{
  margin: 0 10px 10px 0;
}
.row{
  white-space: nowrap;
  margin-top: 10px;
  padding: 0 10px;
  text-align: center;
  display: flex;
  justify-content: space-between;
}

.row2{
  margin-top: 20px;
}
.el-input-show{
  width: 420px;
}
.el-input-show-time{
  width: 100px;
}
.el-input-hall {
  width: 240px;
  margin: 0 20px 0px 0;
}
</style>
