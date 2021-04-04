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
          <el-select v-model="selectedMovieArea" placeholder="请选择电影地区" clearable>
            <el-option
                v-for="item in movieAreaList"
                :key="item.movieAreaId"
                :label="item.movieAreaName"
                :value="item.movieAreaId">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="5">
          <el-select v-model="selectedMovieAge" placeholder="请选择电影年代" clearable>
            <el-option
                v-for="item in movieAgeList"
                :key="item.movieAgeId"
                :label="item.movieAgeName"
                :value="item.movieAgeId">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="5">
          <el-date-picker
              :unlink-panels="true"
              v-model="selectedDate"
              type="datetimerange"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期">
          </el-date-picker>
        </el-col>

      </el-row>
      <el-row :gutter="20" class="row2">
        <el-col :span="5">
          <el-input v-model="selectedMovieNameCn" placeholder="请输入电影中文名称" clearable></el-input>
        </el-col>
        <el-col :span="5">
          <el-input v-model="selectedMovieNameEn" placeholder="请输入电影英文名称" clearable></el-input>
        </el-col>
        <el-col :span="4">
          <el-button icon="el-icon-search" @click="getMovieList">搜索</el-button>
        </el-col>
        <el-col :span="4">
          <el-button type="primary" @click="addDialogVisible = true">添加电影</el-button>
        </el-col>
        <el-col :span="4">
          <el-button type="danger" @click="multipleDelete">批量删除</el-button>
        </el-col>
      </el-row>

<!--    电影分类列表-->
    <el-table :data="movieList" style="width: 100%" border stripe @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="movieNameCn" label="电影中文名称"></el-table-column>
      <el-table-column prop="movieNameEn" label="电影英文名称"></el-table-column>
      <el-table-column prop="sysMovieArea.movieAreaName" label="电影区域"></el-table-column>
      <el-table-column prop="sysMovieAge.movieAgeName" label="电影年代id"></el-table-column>
      <el-table-column prop="releaseDate" label="上映时间"></el-table-column>
<!--      操作按钮-->
      <el-table-column label="操作" width="180">
        <template slot-scope="scope">
          <el-tooltip effect="dark" content="修改电影信息" placement="top" :enterable="false" :open-delay="500">
            <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.movieId)"></el-button>
          </el-tooltip>
          <el-tooltip effect="dark" content="删除电影" placement="top" :enterable="false" :open-delay="500">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteMovieById(scope.row.movieId)"></el-button>
          </el-tooltip>
          <el-tooltip effect="dark" content="演员&影片分类" placement="top" :enterable="false" :open-delay="500">
            <el-button type="warning" icon="el-icon-setting" size="mini" @click="showEditActorDialog(scope.row.movieId)"></el-button>
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
        <el-form-item label="电影中文名称" prop="movieNameCn">
          <el-input v-model="addForm.movieNameCn"></el-input>
        </el-form-item>
        <el-form-item label="电影英文名称" prop="movieNameEn">
          <el-input v-model="addForm.movieNameEn"></el-input>
        </el-form-item>
        <el-form-item label="电影区域id" prop="movieAreaId">
          <el-input v-model="addForm.movieAreaId"></el-input>
        </el-form-item>
        <el-form-item label="电影年代id" prop="movieAgeId">
          <el-input v-model="addForm.movieAgeId"></el-input>
        </el-form-item>
        <el-form-item label="电影时长/分" prop="movieLength">
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
          <el-upload action="" list-type="picture-card"   :auto-upload="false" :limit="1"
                     :file-list="poster" :on-exceed="handleExceed" :on-change="handleChangeP" :on-success="handleSuccessP" :on-error="handleError" ref="posterRef" :http-request="submitFileP">
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
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
        <!--        修改图集-->
        <el-form-item label="电影图集">
          <el-upload action="" list-type="picture-card" :auto-upload="false"
                     :file-list="pics" :on-change="handleChange" :on-success="handleSuccess" :on-error="handleError" ref="pictureRef" :http-request="submitFile">
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
      <el-button type="primary" @click="addMovie">确 定</el-button>
      </span>
    </el-dialog>


    <!-- 修改电影信息对话框 -->
    <el-dialog title="修改电影信息" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
        <el-form-item label="电影中文名称" prop="movieNameCn">
          <el-input v-model="editForm.movieNameCn"></el-input>
        </el-form-item>
        <el-form-item label="电影英文名称" prop="movieNameEn">
          <el-input v-model="editForm.movieNameEn"></el-input>
        </el-form-item>
        <el-form-item label="电影区域id" prop="movieAreaId">
          <el-input v-model="editForm.movieAreaId"></el-input>
        </el-form-item>
        <el-form-item label="电影年代id" prop="movieAgeId">
          <el-input v-model="editForm.movieAgeId"></el-input>
        </el-form-item>
        <el-form-item label="电影时长/分" prop="movieLength">
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
          <el-upload action="" list-type="picture-card"   :auto-upload="false" :limit="1"
                     :file-list="poster" :on-exceed="handleExceed" :on-change="handleChangeP" :on-success="handleSuccessP" :on-error="handleError" ref="posterEditRef" :http-request="submitFileP">
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
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </el-form-item>
<!--        修改图集-->
        <el-form-item label="电影图集">
          <el-upload action="" list-type="picture-card" :auto-upload="false"
                     :file-list="pics" :on-change="handleChange" :on-success="handleSuccess" :on-error="handleError" ref="pictureEditRef" :http-request="submitFile">
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
        <el-button type="primary" @click="editHallInfo">确 定</el-button>
      </span>
    </el-dialog>

<!--    演员管理界面-->
    <el-dialog title="电影类型&演员信息 管理" :visible.sync="editActorVisible" width="60%" @close="editActorDialogClosed">
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
      <el-form   ref="editActorFormRef" label-width="100px">
        <el-form-item label="演员属性" prop="movieActor">
          <el-select v-model="selectedMovieActor" placeholder="请选择演员姓名" clearable>
            <el-option
                v-for="item in actorList"
                :key="item.actorId"
                :label="item.actorName"
                :value="item.actorId">
            </el-option>
          </el-select>
          <el-select v-model="selectedMovieRole" placeholder="请选择角色名称" clearable>
            <el-option
                v-for="item in roleList"
                :key="item.actorRoleId"
                :label="item.actorRoleName"
                :value="item.actorRoleId">
            </el-option>
          </el-select>
          <el-button type="primary" @click="addActor">保存</el-button>
          <el-table :data="editActorForm" style="width: 100%" border stripe>
            <el-table-column type="expand">
              <template slot-scope="scope">
                <el-tag
                    v-for="tag in scope.row.actorList"
                    :key="tag.actorName"
                    closable
                    @close="deleteActor(scope.row.actorRoleId,tag.actorId)">
                  {{tag.actorName}}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column
                label="职务名称"
                prop="actorRoleName">
            </el-table-column>
          </el-table>
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
        movieAreaId: '',
        movieAgeId: '',
        movieNameCn: '',
        movieNameEn: '',
        pageNum: 1,
        pageSize: 7,
        startDate: '',
        endDate: ''
      },
      total: 0,
      url: 'http://localhost:8181/',
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      selectedMovieCategory:[],
      selectedMovieArea: '',
      selectedMovieAge: '',
      selectedMovieActor:'',
      selectedMovieRole:'',
      selectedDate: [],
      selectedMovieNameCn: '',
      selectedMovieNameEn: '',
      categoryList:[],
      movieList: [],
      movieAreaList: [],
      movieAgeList: [],
      actorList: [],
      roleList: [],
      editForm: {},
      editActorForm:null,
      editCategoryForm:[],
      actorMovieId:'',
      editDialogVisible: false,
      editActorVisible: false,
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
        movieNameCn: '',
        movieNameEn: '',
        movieAreaId: '',
        movieAgeId: '',
        movieLength: 0,
        releaseDate: '',
        movieScore: '',
        movieBoxOffice: '',
        movieRateNum: 0,
        movieIntroduction: '',
        moviePictures: '',
        moviePoster:'',
      },
      //添加验证表单规则对象
      addFormRules: {
        movieNameCn: [
          {required: true, message: '请输入电影中文名', trigger: 'blur'}
        ],
        movieNameEn: [
          {required: true, message: '请输入电影英文名', trigger: 'blur'}
        ],
        movieAreaId: [
          {required: true, message: '请输入电影区域id', trigger: 'blur'}
        ],
        movieAgeId: [
          {required: true, message: '请输入电影年代id', trigger: 'blur'}
        ]
      },
      //修改验证表单规则对象
      editFormRules: {
        movieNameCn: [
          {required: true, message: '请输入电影中文名', trigger: 'blur'}
        ],
        movieNameEn: [
          {required: true, message: '请输入电影英文名', trigger: 'blur'}
        ],
        movieAreaId: [
          {required: true, message: '请输入电影区域id', trigger: 'blur'}
        ],
        movieAgeId: [
          {required: true, message: '请输入电影年代id', trigger: 'blur'}
        ]
      }
    }
  },
  created() {
    this.getMovieList();
    this.getMovieAgeList();
    this.getMovieAreaList();
    this.getactorList();
    this.getroleList();
    this.getCategoryList();
  },
  methods: {
    getMovieList() {
      this.queryInfo.movieNameCn = this.selectedMovieNameCn
      this.queryInfo.movieNameEn = this.selectedMovieNameEn
      this.queryInfo.movieAgeId = this.selectedMovieAge
      this.queryInfo.movieAreaId = this.selectedMovieArea
      if (!this.selectedDate) {
        this.queryInfo.startDate = this.selectedDate[0]
        this.queryInfo.endDate = this.selectedDate[1]
      }
      const _this = this;
      axios.get('sysMovie', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.movieList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    getCategoryList() {
      const _this = this
      axios.get('sysMovieCategory').then(resp=>{
        _this.categoryList = resp.data.data;
        console.log(_this.categoryList)
      })
    },
    getMovieAreaList() {
      const _this = this;
      axios.get('sysMovieArea').then(resp => {
        console.log(resp)
        _this.movieAreaList = resp.data.data;
      })
    },
    getMovieAgeList() {
      const _this = this;
      axios.get('sysMovieAge').then(resp => {
        console.log(resp)
        _this.movieAgeList = resp.data.data;
      })
    },
    getactorList(){
      const _this = this;
      axios.get('sysActor').then(resp =>{
        console.log(resp.data.data)
        _this.actorList = resp.data.data;
      })
    },
    getroleList(){
      const _this = this;
      axios.get('sysActorRole').then(resp =>{
        console.log(resp.data.data)
        _this.roleList = resp.data.data;
      })
    },
    ifShow(id){
      let i = 0
      let l = true
      for(i=0;i<this.editCategoryForm.length;i++){
        if(id==this.editCategoryForm[i].movieCategoryId){
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
      const _this = this;
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
    //监听修改演员对话框的关闭事件
    editActorDialogClosed(){
      this.selectedMovieCategory = ''
      this.selectedMovieActor = ''
      this.selectedMovieRole = ''
      this.$refs.editActorFormRef.resetFields()
    },
    //修改演员对话框
    // async editActorInfo() {
    //   this.$refs.editActorFormRef.validate(async valid => {
    //     const _this = this
    //     if(!valid) return
    //     let success = true
    //     axios.defaults.headers.put['Content-Type'] = 'application/json'
    //     await axios.post('sysActorMovie',JSON.stringify(_this.editActorForm)).then(resp =>{
    //       if(resp.data.code !== 200){
    //         this.$message.error('修改演员信息失败!')
    //         success = false
    //       }
    //     })
    //     if(!success) return
    //     this.editActorVisible = false
    //     this.$message.success('修改演员信息成功!')
    //   })
    // },

    // 修改电影信息对话框
    async editHallInfo() {
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
    // 显示修改对话框，回显数据
    async showEditDialog(id1) {
      const _this = this
      await axios.get('sysMovie/' + id1).then(resp => {
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
    //显示修改演员对话框,回显数据
    async showEditActorDialog(id1){
      const _this = this
      _this.actorMovieId = id1
      await axios.get('sysMovie/find/'+id1).then(response=>{
        console.log('电影演员列表')
          console.log(response.data.data)
        _this.editActorForm = response.data.data.actorRoleList
        _this.editCategoryForm = response.data.data.movieCategoryList
        })
      this.editActorVisible = true
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
      if (resp == 'cancel') {
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
    // 单个删除电影
    async deleteMovieById(id1) {
      let deleteInfo = id1
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
      if (resp == 'cancel') {
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
    async deleteActor(rid,aid){
      console.log('aid:'+aid)
      for(let i = 0;i < this.editActorForm.length;i++){
        if(rid == this.editActorForm[i].actorRoleId){
          console.log('this.editForm.actorList:'+this.editActorForm[i].actorList)
          for(let j = 0;j < this.editActorForm[i].actorList.length;j++){
            if(aid == this.editActorForm[i].actorList[j].actorId){
              this.editActorForm[i].actorList.splice(j,1)
              if(this.editActorForm[i].actorList.length==0){
                this.editActorForm.splice(i,1)
              }
              break
            }
          }
        }
      }
      const _this = this
      console.log(111)
      await axios.delete('sysActorMovie/'+_this.actorMovieId+'/'+aid+'/'+rid).then(resp =>{
        if(resp.data.code!== 200){
          _this.$message.success('删除演员信息失败!')
        }
      })
      this.$message.success('删除演员信息成功')
    },
    async addActor(){
      if(this.selectedMovieRole&&this.selectedMovieActor){
      let obj = {
        movieId :this.actorMovieId,
        actorId:this.selectedMovieActor,
        actorRoleId:this.selectedMovieRole
      }
      const _this = this
        let success = true
      await axios.post('sysActorMovie',obj).then(resp=>{
        if(resp.data.code!== 200){
          _this.$message.error('添加演员信息失败!')
          success = false;
        }
      })
        if(!success) return
        await axios.get('sysMovie/find/'+_this.actorMovieId).then(response=>{
          console.log('电影演员列表')
          console.log(response.data.data)
          _this.editActorForm = response.data.data.actorRoleList
        })
      this.$message.success('添加演员信息成功')
      }
    },
    async deleteCategory(categoryId){
      console.log('类型id')
      console.log(categoryId)
      const _this = this
      await axios.delete('sysMovieToCategory/'+this.actorMovieId+'/'+categoryId).then(resp=>{
        console.log(resp)
        _this.$message.success('删除类型成功')
      })
      await axios.get('sysMovie/find/'+this.actorMovieId).then(response=>{
        _this.editCategoryForm = response.data.data.movieCategoryList
      })
    },
    handleExceed(){
      this.$message.error('电影封面不能超过一张!')
    },
    async addCategory(){
      const _this = this
      await axios.post('sysMovieToCategory/'+this.actorMovieId+'/'+this.selectedMovieCategory).then(resp=>{
        console.log(resp)

      })
      axios.get('sysMovie/find/'+this.actorMovieId).then(response=>{
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
</style>