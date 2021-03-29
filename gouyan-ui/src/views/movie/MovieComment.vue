<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>电影管理</el-breadcrumb-item>
        <el-breadcrumb-item>电影评论</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">
        <el-col :span="2">
          <el-button type="primary" @click="addDialogVisible = true">添加影评</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="multipleDelete" v-has>批量删除</el-button>
        </el-col>
      </el-row>

      <!--电影评论列表-->
      <el-table :data="moviecommentlist" style="width: 100%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="movieId" label="电影编号" width="145"></el-table-column>
        <el-table-column prop="userId" label="用户编号" width="145"></el-table-column>
        <el-table-column prop="commentTime" label="评论时间" width="160"></el-table-column>
        <el-table-column prop="content" label="评论内容" width="160" :show-overflow-tooltip="true"></el-table-column>
        <el-table-column prop="score" label="评分" width="145"></el-table-column>
        <el-table-column label="操作" width="100">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="删除影评" placement="top" :enterable="false" :open-delay="500">
              <el-button v-has type="danger" icon="el-icon-delete" size="mini" @click="deleteMovieComment(scope.row.movieId,scope.row.userId,scope.row.commentTime,scope.row.content,scope.row.score)"></el-button>
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

    <!--添加影评对话框-->
    <el-dialog title="添加影评" :visible.sync="addDialogVisible" width="50%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <el-form-item label="电影" prop="movieId">
          <el-select v-model="addForm.movieId" placeholder="请选择影片" clearable >
            <el-option
                v-for="item in movieList"
                :key="item.movieId"
                :label="item.movieNameCn"
                :value="item.movieId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="评分" prop="score">
          <el-input v-model="addForm.score"></el-input>
        </el-form-item>
        <el-form-item label="评论" prop="content">
          <el-input v-model="addForm.content" type="textarea" :rows="5"></el-input>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addMovieComment">确 定</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
import global from "@/assets/css/global.css"
import moment from 'moment'
export default {
  name: "movieComment",
  // this.$message和this.$confirm都属于原型挂载, 在element.js中配置
  // Vue.prototype.$message = Message
  // Vue.prototype.$confirm = MessageBox.confirm
  data() {
    return {
      queryInfo: {
        query: '',
        pageNum: 1,
        pageSize: 7
      },
      moviecommentlist: [],
      movieList: [],
      total: 0,
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      addForm:{
        movieId:'',
        userId:'',
        commentTime:'',
        content:'',
        score:''
      },
      addFormRules:{
        content:[
          { required: true, message: '请输入评论内容', trigger: 'blur' }
        ],
        score:[
          { required:true, message:'请输入评分信息', trigger:'blur' },
          { min:0, max:10, message: '评分应在0~10之间', trigger: 'blur' }
        ]
      },
      multipleSelection: []
    }
  },
  created() {
    this.getMovieCommentList()
    this.getMovieList()
  },
  methods: {
    getMovieCommentList() {
      const _this = this;
      axios.get('sysMovieComment', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.moviecommentlist = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    async getMovieList(){
      const { data : res } = await axios.get('sysMovie')
      if(res.code !== 200) return this.$message.error('获取信息失败')
      this.movieList = res.data
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getMovieCommentList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getMovieCommentList()
      console.log(newPage)
    },
    // 监听添加对话框的关闭事件
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
    },
    //监听添加按钮
    addMovieComment(){
      const _this = this;
      this.$refs.addFormRef.validate(async valid => {
        if (!valid) return
        //预校验成功，发网络请求
        this.addForm.commentTime = moment().format('YYYY-MM-DD HH:MM:SS')
        this.addForm.userId = JSON.parse(window.sessionStorage.getItem('loginUser')).sysUser.userId
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        const { data : res } = await axios.post('sysMovieComment', JSON.stringify(_this.addForm))
        if(res.code !== 200) return this.$message.error('添加影评失败')
        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        this.getMovieCommentList()
        this.$message.success('添加电影评论成功！')
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
        ids.push(data.movieId)
      })
      await axios.delete('sysMovieComment/' + ids).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除电影评论失败！')
        }
      })
      this.getMovieCommentList()
      this.$message.success('批量删除电影评论成功！')
    },
    //根据id删除对应的电影评论
    async deleteMovieComment(id1,id2,time,c,s){
      let deleteInfo = [{
        movieId : id1,
        userId : id2,
        commentTime : time,
        content : c,
        score : s
      }]
      console.log(deleteInfo);
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
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      await axios.post('sysMovieComment/delete', JSON.stringify(deleteInfo)).then(resp => {
        console.log(resp);
        console.log(deleteInfo)
        if (resp.data.code !== 200){
          _this.$message.success('删除电影评论失败！')
        }
      })
      this.getMovieCommentList()
      this.$message.success('删除电影评论成功！')
    }
  }
}
</script>

<style scoped>

</style>