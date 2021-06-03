<template>
  <div>
    <!--面包屑导航区-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>电影管理</el-breadcrumb-item>
        <el-breadcrumb-item>电影信息</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <el-card class="box-card">
      <el-row :addDialogVisible="20">
        <el-col :span="5">
          <el-input v-model="inputMovieName" placeholder="请输入电影名称" clearable></el-input>
        </el-col>
        <el-col :span="5">
          <el-select class="el-select-search" v-model="selectedMovieArea" placeholder="请选择电影地区" clearable>
            <el-option
                v-for="item in movieAreaList"
                :key="item"
                :label="item"
                :value="item">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="4">
          <el-button class="el-button-search" icon="el-icon-search" @click="getMovieList">搜索</el-button>
        </el-col>
      </el-row>
      <el-row :gutter="20" class="row2">
        <el-col :span="10">
            <el-date-picker
                    :unlink-panels="true"
                    v-model="selectedDate"
                    type="datetimerange"
                    range-separator="至"
                    start-placeholder="开始日期"
                    end-placeholder="结束日期">
            </el-date-picker>
        </el-col>

        <el-col :span="4">
          <el-button type="primary" @click="addDialogVisible = true">添加电影</el-button>
        </el-col>
        <el-col :span="4">
          <el-button type="danger" @click="isAbleMultipleDelete">批量删除</el-button>
        </el-col>
      </el-row>

<!--    电影信息列表-->
    <el-table :data="movieList" style="width: 100%" border stripe @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="movieId" label="#" width="40"></el-table-column>
      <el-table-column prop="movieName" label="电影名称"></el-table-column>
      <el-table-column prop="movieArea" label="电影区域"></el-table-column>
      <el-table-column prop="movieLength" label="电影时长（分钟）"></el-table-column>
      <el-table-column prop="releaseDate" label="上映时间"></el-table-column>
      <el-table-column prop="movieBoxOffice" label="票房"></el-table-column>
<!--      操作按钮-->
      <el-table-column label="操作" width="240">
        <template slot-scope="scope">
          <el-tooltip effect="dark" content="查看电影信息详细" placement="top" :enterable="false" :open-delay="500">
            <el-button type="success" icon="el-icon-view" size="mini" @click="toMovieInfo(scope.row.movieId)"></el-button>
          </el-tooltip>
          <el-tooltip effect="dark" content="修改电影信息" placement="top" :enterable="false" :open-delay="500">
            <el-button type="primary" icon="el-icon-edit" size="mini" @click="isAbleEdit(scope.row.movieId)"></el-button>
          </el-tooltip>
          <el-tooltip effect="dark" content="删除电影" placement="top" :enterable="false" :open-delay="500">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="isAbleDelete(scope.row.movieId)"></el-button>
          </el-tooltip>
          <el-tooltip effect="dark" content="影片类别管理" placement="top" :enterable="false" :open-delay="500">
            <el-button type="warning" icon="el-icon-setting" size="mini" @click="showEditCategoryDialog(scope.row.movieId)"></el-button>
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

    <!--添加电影对话框-->
    <el-dialog title="添加电影" :visible.sync="addDialogVisible" width="60%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="电影名称" prop="movieName">
          <el-input v-model="addForm.movieName"></el-input>
        </el-form-item>
        <el-form-item label="电影区域" prop="movieArea">
          <el-select v-model="addForm.movieArea" placeholder="请选择电影区域" clearable >
            <el-option
                    v-for="item in movieAreaList"
                    :key="item"
                    :label="item"
                    :value="item">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="电影时长/分钟" prop="movieLength">
          <el-input v-model="addForm.movieLength"></el-input>
        </el-form-item>
        <el-form-item label="上映时间" prop="releaseDate">
          <el-date-picker
              v-model="addForm.releaseDate"
              value-format="yyyy-MM-dd HH:mm:ss"
              type="datetime"
              placeholder="选择日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="电影简介" prop="movieIntroduction">
          <el-input v-model="addForm.movieIntroduction"></el-input>
        </el-form-item>
        <el-form-item label="电影封面">
          <el-upload action="" list-type="picture-card"
                     :auto-upload="false" :limit="1"
                     :file-list="poster" :on-exceed="handleExceed"
                     :on-change="handleChangeP"
                     :on-success="handleSuccessP"
                     :on-error="handleError" ref="posterRef"
                     :http-request="submitFileP">
            <i slot="default" class="el-icon-plus" ></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="file.url" alt="">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreviewP(file)">
                  <i class="el-icon-zoom-in"></i>
                </span>
                <span v-if="!disabled" class="el-upload-list__item-delete" @click="handleRemoveP(file)">
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
        <!--        修改图集-->
        <el-form-item label="电影图集">
          <el-upload action="" list-type="picture-card" :auto-upload="false"
                     :file-list="pics" :on-change="handleChange"
                     :on-success="handleSuccess" :on-error="handleError"
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
          <el-dialog :visible.sync="dialogVisible" append-to-body>
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addMovie">确 定</el-button>
      </span>
    </el-dialog>


    <!-- 修改电影信息对话框 -->
    <el-dialog title="修改电影信息" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
        <el-form-item label="电影名称" prop="movieName">
          <el-input v-model="editForm.movieName" disabled></el-input>
        </el-form-item>

        <el-form-item label="电影区域" prop="movieArea">
          <el-select v-model="editForm.movieArea" placeholder="请选择电影区域" clearable >
            <el-option
              v-for="item in movieAreaList"
              :key="item"
              :label="item"
              :value="item">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="电影时长/分钟" prop="movieLength">
          <el-input v-model="editForm.movieLength"></el-input>
        </el-form-item>
        <el-form-item label="上映时间" prop="releaseDate">
          <el-date-picker
              v-model="editForm.releaseDate"
              value-format="yyyy-MM-dd HH:mm:ss"
              type="datetime"
              placeholder="选择日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="电影简介" prop="movieIntroduction">
          <el-input v-model="editForm.movieIntroduction"></el-input>
        </el-form-item>
<!--        修改封面-->
        <el-form-item label="电影封面">
          <el-upload action="" list-type="picture-card"
                     :auto-upload="false" :limit="1"
                     :file-list="poster" :on-exceed="handleExceed"
                     :on-change="handleChangeP"
                     :on-success="handleSuccessP"
                     :on-error="handleError" ref="posterEditRef"
                     :http-request="submitFileP">
            <i slot="default" class="el-icon-plus" ></i>
            <div slot="file" slot-scope="{file}">
              <img class="el-upload-list__item-thumbnail" :src="file.url" alt="">
              <span class="el-upload-list__item-actions">
                <span class="el-upload-list__item-preview" @click="handlePictureCardPreviewP(file)">
                  <i class="el-icon-zoom-in"></i>
                </span>
                <span v-if="!disabled" class="el-upload-list__item-delete" @click="handleRemoveP(file)">
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
<!--        修改图集-->
        <el-form-item label="电影图集">
          <el-upload action="" list-type="picture-card" :auto-upload="false"
                     :file-list="pics" :on-change="handleChange"
                     :on-success="handleSuccess"
                     :on-error="handleError" ref="pictureEditRef"
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
          <el-dialog :visible.sync="dialogVisible" append-to-body>
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editMovieInfo">确 定</el-button>
      </span>
    </el-dialog>

<!--    电影类型管理界面-->
    <el-dialog title="电影类型管理" :visible.sync="editCategoryVisible" width="60%" @close="editCategoryDialogClosed">
<!--      <template>-->
<!--        <el-checkbox-group-->
<!--            v-model="selectedMovieCategory">-->
<!--          <el-checkbox v-for="category in movieCategoryList" :label="category.movieCategoryName" :key="category.movieCategoryId">{{category.movieCategoryName}}</el-checkbox>-->
<!--        </el-checkbox-group>-->
<!--      </template>-->
      <el-form label-width="100px">
        <el-form-item label="电影类型" prop="movieActor">
          <el-select v-model="selectedMovieCategory" placeholder="请选择类型名称" clearable>
            <el-option
                v-for="item in categoryList"
                :key="item.movieCategoryId"
                :label="item.movieCategoryName"
                :value="item.movieCategoryId"
                v-if="ifShow(item.movieCategoryId)">
            </el-option>
          </el-select>
        <el-button type="primary" @click="addCategory()">添加</el-button>
        </el-form-item>
        <el-form-item>
              <el-tag
                  v-for="tag in editCategoryForm"
                  :key="tag.movieCategoryName"
                  closable
                  @close="deleteCategory(tag.movieCategoryId)">
                {{tag.movieCategoryName}}
              </el-tag>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "MovieInfo",
  data() {
    return {
      queryInfo: {
        movieId: '',
        movieArea: '',
        movieName: '',
        startDate: '',
        endDate: '',
        pageNum: 1,
        pageSize: 7
      },
      total: 0,
      url: 'http://localhost:8181/',
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      selectedMovieCategory:[],
      selectedMovieArea: '',
      selectedDate: [],
      inputMovieName: '',
      categoryList:[],
      movieList: [],
      movieAreaList: ["中国大陆", "美国", "韩国", "日本", "中国香港", "中国台湾", "泰国", "印度",
        "法国", "英国", "俄罗斯", "意大利", "西班牙", "德国", "波兰", "澳大利亚", "伊朗", "其他"],
      editForm: {},
      checkAbleId: {},
      editCategoryForm:[],
      movieId:'',
      editDialogVisible: false,
      editCategoryVisible: false,
      multipleSelection: [],
      dialogVisible: false,
      dialogImageUrl: '',
      disabled:false,
      //电影封面增删变量
      poster: [],
      //发送给后端的JSON图片
      posterL: [],
      deletePostList:[],
      //添加删除图片集 动态绑定图片列表
      pics: [],
      // 发送给后端的JSON图片数组
      pictureList: [],
      picNums:0,
      deletePicList:[],
      //添加电影表单数据
      addForm: {
        movieId: '',
        movieName: '',
        movieArea: '',
        movieLength: 0,
        releaseDate: '',
        movieBoxOffice: '',
        movieIntroduction: '',
        moviePictures: '',
        moviePoster:''
      },
      //添加验证表单规则对象
      addFormRules: {
        movieName: [
          {required: true, message: '请输入电影名称', trigger: 'blur'}
        ],
        movieArea: [
          {required: true, message: '请选择电影区域', trigger: 'blur'}
        ]
      },
      //修改验证表单规则对象
      editFormRules: {
        movieName: [
          {required: true, message: '请输入电影名称', trigger: 'blur'}
        ],
        movieArea: [
          {required: true, message: '请选择电影区域', trigger: 'blur'}
        ]
      }
    }
  },
  created() {
    this.getMovieList()
    this.getCategoryList()
  },
  methods: {
    getMovieList() {
      this.queryInfo.movieName = this.inputMovieName
      this.queryInfo.movieArea = this.selectedMovieArea
      if (!this.selectedDate) {
        this.queryInfo.startDate = this.selectedDate[0]
        this.queryInfo.endDate = this.selectedDate[1]
      }
      const _this = this;
      axios.get('sysMovie/find', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.movieList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    getCategoryList() {
      const _this = this
      axios.get('sysMovieCategory/find').then(resp=>{
        _this.categoryList = resp.data.data;
        console.log(_this.categoryList)
      })
    },
    ifShow(id) {
      let l = true
      for (let i = 0; i < this.editCategoryForm.length; i++) {
        if (id === this.editCategoryForm[i].movieCategoryId) {
          l =false
        }
      }
      return l
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getMovieList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getMovieList()
      console.log(newPage)
    },
    async submitFile() {
      const _this = this
      for (let i = 0; i < this.pics.length; i++) {
        let formData = new FormData()
        if (this.pics[i].status === 'success') {
          let s = this.pics[i].url
          this.pictureList.push(s.substring(s.indexOf('/images')))
          continue
        }
        let file = this.pics[i].raw
        formData.append('file', file)
        await axios.post('upload/movie', formData).then(response => {
          _this.pictureList.push(response.data.data)
        })
      }
    },
    async submitFileP() {
      const _this = this
      for (let i = 0; i < this.poster.length; i++) {
        let formData = new FormData()
        if (this.poster[i].status === 'success') {
          let s = this.poster[i].url
          this.posterL.push(s.substring(s.indexOf('/images')))
          continue
        }
        let file = this.poster[i].raw
        formData.append('file', file)
        await axios.post('upload/movie', formData).then(response => {
          _this.posterL.push(response.data.data)
        })
      }
    },
    // 监听添加对话框的关闭事件
    addDialogClosed() {
      this.$refs.addFormRef.resetFields()
      this.$refs.pictureRef.clearFiles()
      this.$refs.posterRef.clearFiles()
      this.poster = []
      this.posterL=[]
      this.pics = []
      this.pictureList = []
    },
    // 监听添加按钮
    async addMovie() {
      await this.submitFile()
      await this.submitFileP()
      this.addForm.moviePictures = JSON.stringify(this.pictureList)
      this.addForm.moviePoster = JSON.stringify(this.posterL)
      const _this = this
      this.$refs.addFormRef.validate(async valid => {
        console.log(valid)
        if (!valid) return
        //预校验成功，发网络请求
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        await axios.post('sysMovie', JSON.stringify(_this.addForm)).then(resp => {
          console.log(resp)
          if (resp.data.code !== 200) {
            this.$message.error('添加电影信息失败！')
          }
        })
        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        this.getMovieList()
        this.$message.success('添加电影信息成功！')
      })
    },
    // 监听修改对话框的关闭事件
    editDialogClosed() {
      this.$refs.editFormRef.resetFields()
      this.$refs.pictureEditRef.clearFiles()
      this.$refs.posterEditRef.clearFiles()
      this.pics = []
      this.pictureList = []
      this.posterL = []
      this.poster = []
    },
    //监听修改类别对话框的关闭事件
    editCategoryDialogClosed(){
      this.selectedMovieCategory = ''
    },
    // 修改电影信息对话框
    async editMovieInfo() {
      await this.submitFile()
      this.editForm.moviePictures = JSON.stringify(this.pictureList)
      await this.submitFileP()
      this.editForm.moviePoster = JSON.stringify(this.posterL)
      this.$refs.editFormRef.validate(async valid => {
        const _this = this
        if (!valid) return
        let success = true
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        await axios.put('sysMovie', JSON.stringify(_this.editForm)).then(resp => {
          if (resp.data.code !== 200) {
            this.$message.error('修改电影信息失败！')
            success = false
          }
        })
        if (!success) return
        for(let s of this.deletePicList){
          await axios.get('/upload/delete?filePath=' + s.substring(s.indexOf('/images')))
        }
        for(let s of this.deletePostList){
          await axios.get('/upload/delete?filePath=' + s.substring(s.indexOf('/images')))
        }
        this.editDialogVisible = false
        this.getMovieList()
        this.$message.success('修改电影信息成功！')
      })
    },
    handleChange(file, filelist) {
      this.pics = filelist.slice(0)
      console.log(this.pics)
    },
    handleChangeP(file, filelist) {
      this.poster = filelist
      console.log(this.poster)
    },
    handleSuccess(response) {
      this.pictureList.push(response.data)
      this.addForm = JSON.stringify(this.pictureList)
      this.editForm = JSON.stringify(this.pictureList)
    },
    handleSuccessP(response) {
      this.posterL.push(response.data)
      this.addForm = JSON.stringify(this.posterL)
      this.editForm = JSON.stringify(this.posterL)
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    handlePictureCardPreviewP(file) {
      this.dialogImageUrl = file.url;
      this.dialogVisible = true;
    },
    handleRemove(file,filelist) {
      const filePath = file.url
      console.log(filePath)
      const idx = this.pics.findIndex(x => x.url === filePath)
      if(file.status === 'success'){
        this.deletePicList.push(file.url)
      }
      this.pics.splice(idx, 1)
    },
    handleRemoveP(file) {
      const filePath = file.url
      console.log(filePath)
      const idx = this.poster.findIndex(x=> x.url === filePath)
      if(file.status === 'success'){
        this.deletePostList.push(file.url)
      }
      this.poster.splice(idx,1)
    },
    handleError(err) {
      console.log(err)
    },
    toMovieInfo(id) {
      window.open('http://localhost:8081/movieInfo/' + id)
    },
    isAbleEdit(id) {
      this.checkAbleId.movieId = id
      axios.get('sysSession/isAbleEdit', {params: this.checkAbleId}).then(response => {
        console.log(response.data.total)
        let sessions = response.data.data
        if (response.data.total === 0) {
          console.log('空的可改')
          this.showEditDialog(id)
        } else {
          console.log('修改前判断有未完成session')
          let sessionIds = ''
          for (let temp of sessions) {
            console.log(temp)
            sessionIds += temp.sessionId+' '
          }
          console.log('sessionIds is : '+sessionIds)
          this.$alert('抱歉！有未完成电影场次，不能修改电影信息。\n'+'导致异常的场次编号为: '+sessionIds, '修改请求异常通知', {
            confirmButtonText: '我知道了',
            callback: action => {
              this.$router.push('/movie')
            }
          })
        }
      })
    },
    // 显示修改对话框，回显数据
    async showEditDialog(id) {
      const _this = this
      await axios.get('sysMovie/find/' + id).then(resp => {
        console.log(resp)
        _this.editForm = resp.data.data
      })
      for (const item of JSON.parse(this.editForm.moviePictures)) {
        let pic = {}
        pic['name'] = ''
        pic['url'] = this.global.base + item
        this.pics.push(pic)
      }
      for (const item of JSON.parse(this.editForm.moviePoster)) {
        let pic = {}
        pic['name'] = ''
        pic['url'] = this.global.base + item
        this.poster.push(pic)
      }
      this.editDialogVisible = true
    },
    //显示修改类别对话框,回显数据
    async showEditCategoryDialog(id){
      const _this = this
      _this.movieId = id
      await axios.get('sysMovie/find/'+id).then(response=>{
        _this.editCategoryForm = response.data.data.movieCategoryList
        })
      this.editCategoryVisible = true
    },
    //取消修改
    cancelEdit(){
      this.editDialogVisible = false
      this.deletePicList.splice(0,this.deletePicList.length)
      this.deletePostList.splice(0,this.deletePostList.length)
    },
    // 监听多选框变化
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    // 批量删除前校验
    async isAbleMultipleDelete() {
      let ableDelete = true
      let ids = ''
      for (let i = 0; i < this.multipleSelection.length; i++) {
        this.checkAbleId.movieId = this.multipleSelection[i].movieId
        const { data : res } = await axios.get('sysSession/isAbleEdit', {params: this.checkAbleId})
        if (res.data.length !== 0) {
          ids += this.multipleSelection[i].movieId + ' '
          ableDelete = false
        }
      }
      if (ableDelete === false) {
        this.$alert('抱歉！有未完成电影场次，不能批量删除电影信息。\n' + '导致异常的电影编号为: ' + ids, '批量删除请求异常通知', {
          confirmButtonText: '我知道了',
          callback: action => {
            this.$router.push('/movie')
          }
        })
        return
      }
      await this.multipleDelete()
    },
    // 批量删除电影
    async multipleDelete() {
      const _this = this
      //询问用户是否确认删除
      const resp = await this.$confirm('此操作将永久删除这些条目, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)

      // 用户确认删除, resp为字符串"confirm"
      // 用户取消删除，resp为字符串"cancel"
      if (resp === 'cancel') {
        return _this.$message.info('已取消删除')
      }

      let ids = []
      this.multipleSelection.forEach(data => {
        let item = data.movieId
        ids.push(item)
      })
      console.log(ids)
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      await axios.delete('sysMovie/' + ids, JSON.stringify(ids)).then(resp => {
        console.log(123)
        if (resp.data.code !== 200) {
          this.$message.success('批量删除电影失败！')
        }
      })
      this.getMovieList()
      this.$message.success('批量删除电影成功！')
    },
    async isAbleDelete(id) {
      this.checkAbleId.movieId = id
      await axios.get('sysSession/isAbleEdit', {params: this.checkAbleId}).then(response => {
        console.log(response.data.total)
        let sessions = response.data.data
        if (response.data.total === 0) {
          this.deleteMovieById(id)
        } else {
          console.log('删除前判断有未完成session')
          let sessionIds = ''
          for (let temp of sessions) {
            console.log(temp)
            sessionIds += temp.sessionId+' '
          }
          console.log('sessionIds is : '+sessionIds)
          this.$alert('抱歉！有未完成电影场次，不能删除电影信息。\n'+'导致异常的场次编号为: '+sessionIds, '删除请求异常通知', {
            confirmButtonText: '我知道了',
            callback: action => {
              this.$router.push('/movie')
            }
          })
        }
      })
    },
    // 单个删除电影
    async deleteMovieById(id) {
      let deleteInfo = id
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
      if (resp === 'cancel') {
        return _this.$message.info('已取消删除')
      }

      console.log(deleteInfo)
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      await axios.delete('sysMovie/' + deleteInfo, JSON.stringify(deleteInfo)).then(resp => {
        if (resp.data.code !== 200) {
          _this.$message.success('删除电影信息失败！')
        }
      })
      this.getMovieList()
      this.$message.success('删除电影信息成功！')
    },
    async deleteCategory(categoryId){
      console.log('类型id')
      console.log(categoryId)
      const _this = this
      await axios.delete('sysMovieToCategory/'+this.movieId+'/'+categoryId).then(resp=>{
        console.log(resp)
        _this.$message.success('删除类型成功')
      })
      await axios.get('sysMovie/find/'+this.movieId).then(response=>{
        _this.editCategoryForm = response.data.data.movieCategoryList
      })
    },
    handleExceed(){
      this.$message.error('电影封面不能超过一张!')
    },
    async addCategory(){
      const _this = this
      await axios.post('sysMovieToCategory/'+this.movieId+'/'+this.selectedMovieCategory).then(resp=>{
        console.log(resp)
        if (resp.data.code !==200) return this.$alert('添加电影类别失败', '添加电影类别异常通知', {
          confirmButtonText: '我知道了'
        })
        this.$message.success("添加电影类别成功")
      })
      axios.get('sysMovie/find/'+this.movieId).then(response=>{
        _this.editCategoryForm = response.data.data.movieCategoryList
      })
    }
  }
}
</script>

<style scoped>
.row2{
  margin-top: 20px;
}
.el-tag{
    margin: 0 10px 10px 0;
}
.el-button-search{
  margin: 0px 0px 0px 10px;
}
.el-select-search{
  margin: 0 0px 0px 20px;
}
</style>
