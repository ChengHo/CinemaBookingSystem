

<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>电影管理</el-breadcrumb-item>
        <el-breadcrumb-item>播放时段</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">
        <el-col :span="3">
          <el-button type="primary" @click="addDialogVisible = true" v-has>添加播放时段</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="multipleDelete" v-has>批量删除</el-button>
        </el-col>
      </el-row>

      <!--播放时段列表-->
      <el-table :data="movieruntimelist" style="width: 100%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="movieRuntimeId" label="播放时段编号" width="120"></el-table-column>
        <el-table-column prop="movieRuntimeName" label="播放时段" width="120"></el-table-column>
        <el-table-column prop="beginTime" label="开始时间" width="120"></el-table-column>
        <el-table-column prop="endTime" label="结束时间" width="120"></el-table-column>
        <el-table-column label="操作" width="150">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改播放时段信息" placement="top" :enterable="false" :open-delay="500">
              <el-button v-has type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.movieRuntimeId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除播放时段" placement="top" :enterable="false" :open-delay="500">
              <el-button v-has type="danger" icon="el-icon-delete" size="mini" @click="deleteMovieRuntimeById(scope.row.movieRuntimeId)"></el-button>
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

    <!--添加播放时段对话框-->
    <el-dialog title="添加播放时段" :visible.sync="addDialogVisible" width="50%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="播放时段" prop="movieRuntimeName">
          <el-input v-model="addForm.movieRuntimeName"></el-input>
        </el-form-item>
        <el-form-item label="开始时间" prop="beginTime">
          <el-input v-model="addForm.beginTime"></el-input>
        </el-form-item>
        <el-form-item label="结束时间" prop="endTime">
          <el-input v-model="addForm.endTime"></el-input>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addMovieRuntime">确 定</el-button>
      </span>
    </el-dialog>

    <!--修改播放时段对话框-->
    <el-dialog title="修改播放时段" :visible.sync="editDialogVisible" width="50%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
        <el-form-item label="播放时段编号">
          <el-input v-model="editForm.movieRuntimeId" disabled></el-input>
        </el-form-item>
        <el-form-item label="播放时段" prop="movieRuntimeName">
          <el-input v-model="editForm.movieRuntimeName"></el-input>
        </el-form-item>
        <el-form-item label="开始时间" prop="beginTime">
          <el-input v-model="editForm.beginTime"></el-input>
        </el-form-item>
        <el-form-item label="结束时间" prop="endTime">
          <el-input v-model="editForm.endTime"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editMovieRuntimeInfo">确 定</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
import global from "@/assets/css/global.css"
export default {
  name: "movieRuntime",
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
      movieruntimelist: [],
      total: 0,
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      //添加播放时段的表单数据
      addForm: {
        movieRuntimeName: '',
        beginTime: '',
        endTime: '',
      },
      //验证表单规则对象
      addFormRules: {
        movieRuntimeName: [
          { required: true, message: '请输入播放时段名', trigger: 'blur' }
        ],
        beginTime: [
          {required: true, message: '请输入开始时间', trigger: 'blur'}
        ],
        endTime: [
          {required: true, message: '请输入结束时间', trigger: 'blur'}
        ]
      },
      editDialogVisible: false,
      editForm: {},
      editFormRules: {
        movieRuntimeName: [
          { required: true, message: '请输入播放时段名', trigger: 'blur' }
        ],
        beginTime: [
          {required: true, message: '请输入开始时间', trigger: 'blur'}
        ],
        endTime: [
          {required: true, message: '请输入结束时间', trigger: 'blur'}
        ]
      },
      multipleSelection: []
    }
  },
  created() {
    this.getMovieRuntimeList()
  },
  methods: {
    getMovieRuntimeList() {
      const _this = this;
      axios.get('sysMovieRuntime', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.movieruntimelist = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getMovieRuntimeList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getMovieRuntimeList()
      console.log(newPage)
    },
    // 监听添加对话框的关闭事件
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
    },
    // 监听添加按钮
    addMovieRuntime(){
      const _this = this;
      this.$refs.addFormRef.validate(async valid => {
        console.log(valid)
        if (!valid) return
        //预校验成功，发网络请求
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        await axios.post('sysMovieRuntime', JSON.stringify(_this.addForm)).then(resp => {
          console.log(resp)
          if (resp.data.code !== 200){
            this.$message.error('添加播放时段分类失败！')
            return
          }
        })
        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        this.getMovieRuntimeList()
        this.$message.success('添加播放时段分类成功！')
      })
    },
    // 显示修改对话框，回显数据
    showEditDialog(id){
      const _this = this
      axios.get('sysMovieRuntime/' + id ).then(resp => {
        console.log(resp)
        _this.editForm = resp.data.data
      })
      this.editDialogVisible = true
    },
    // 监听修改对话框的关闭事件
    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
    },
    // 修改播放时段分类信息并提交
    editMovieRuntimeInfo(){
      this.$refs.editFormRef.validate(async valid => {
        const _this = this
        if (!valid) return
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        await axios.put('/sysMovieRuntime', JSON.stringify(_this.editForm)).then(resp => {
          if (resp.data.code !== 200){
            this.$message.error('修改播放时段分类失败！')
          }
        })
        this.editDialogVisible = false
        this.getMovieRuntimeList()
        this.$message.success('修改播放时段分类成功！')
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
        ids.push(data.movieRuntimeId)
      })
      await axios.delete('sysMovieRuntime/' + ids).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除播放时段分类失败！')
        }
      })
      this.getMovieRuntimeList()
      this.$message.success('批量删除播放时段分类成功！')
    },
    //根据id删除对应的播放时段分类
    async deleteMovieRuntimeById(id){
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

      await axios.delete('sysMovieRuntime/' + id).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.success('删除播放时段分类失败！')
        }
      })
      this.getMovieRuntimeList()
      this.$message.success('删除播放时段分类成功！')
    }
  }
}
</script>

<style scoped>

</style>