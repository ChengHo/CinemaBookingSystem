<template>
  <div>
    <!--面包屑导航品牌-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>影院管理</el-breadcrumb-item>
        <el-breadcrumb-item>影院品牌</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">
        <el-col :span="2">
          <el-button type="primary" @click="addDialogVisible = true">添加品牌</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="multipleDelete">批量删除品牌</el-button>
        </el-col>
      </el-row>

      <!--品牌分类列表-->
      <el-table :data="cinemabrandlist" style="width: 45%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="cinemaBrandId" label="品牌编号" width="145"></el-table-column>
        <el-table-column prop="cinemaBrandName" label="影院品牌" width="180"></el-table-column>
        <el-table-column label="操作" width="150">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改影院品牌" placement="top" :enterable="false" :open-delay="500">
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.cinemaBrandId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除品牌" placement="top" :enterable="false" :open-delay="500">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteCinemaBrandById(scope.row.cinemaBrandId)"></el-button>
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

    <!--添加品牌对话框-->
    <el-dialog title="添加品牌" :visible.sync="addDialogVisible" width="50%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="影院品牌" prop="cinemaBrandName">
          <el-input v-model="addForm.cinemaBrandName"></el-input>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addCinemaBrand">确 定</el-button>
      </span>
    </el-dialog>

    <!--修改品牌对话框-->
    <el-dialog title="修改品牌" :visible.sync="editDialogVisible" width="50%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
        <el-form-item label="品牌编号">
          <el-input v-model="editForm.cinemaBrandId" disabled></el-input>
        </el-form-item>
        <el-form-item label="影院品牌" prop="cinemaBrandName">
          <el-input v-model="editForm.cinemaBrandName"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editCinemaBrandInfo">确 定</el-button>
      </span>
    </el-dialog>

  </div>

</template>

<script>
export default {
  name: "CinemaBrand",
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
      cinemabrandlist: [],
      total: 0,
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      //添加品牌的表单数据
      addForm: {
        cinemaBrandName: ''
      },
      //验证表单规则对象
      addFormRules: {
        cinemaBrandName: [
          { required: true, message: '请输入影院品牌', trigger: 'blur' }
        ]
      },
      editDialogVisible: false,
      editForm: {},
      editFormRules: {
        cinemaBrandName: [
          { required: true, message: '请输入影院品牌', trigger: 'blur' }
        ]
      },
      multipleSelection: []
    }
  },
  created() {
    this.getCinemaBrandList()
  },
  methods: {
    getCinemaBrandList() {
      const _this = this;
      axios.get('sysCinemaBrand', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.cinemabrandlist = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getCinemaBrandList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getCinemaBrandList()
      console.log(newPage)
    },
    // 监听添加对话框的关闭事件
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
    },
    // 监听添加按钮
    addCinemaBrand(){
      const _this = this;
      this.$refs.addFormRef.validate(async valid => {
        console.log(valid)
        if (!valid) return
        //预校验成功，发网络请求
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        await axios.post('sysCinemaBrand', JSON.stringify(_this.addForm)).then(resp => {
          console.log(resp)
          if (resp.data.code !== 200){
            this.$message.error('添加影院品牌失败！')
          }
        })
        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        this.getCinemaBrandList()
        this.$message.success('添加影院品牌成功！')
      })
    },
    // 显示修改对话框，回显数据
    showEditDialog(id){
      const _this = this
      axios.get('sysCinemaBrand/' + id ).then(resp => {
        console.log(resp)
        _this.editForm = resp.data.data
      })
      this.editDialogVisible = true
    },
    // 监听修改对话框的关闭事件
    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
    },
    // 修改品牌分类信息并提交
    editCinemaBrandInfo(){
      this.$refs.editFormRef.validate(async valid => {
        const _this = this
        if (!valid) return
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        await axios.put('sysCinemaBrand', JSON.stringify(_this.editForm)).then(resp => {
          if (resp.data.code !== 200){
            this.$message.error('修改影院品牌失败！')
          }
        })
        this.editDialogVisible = false
        this.getCinemaBrandList()
        this.$message.success('修改影院品牌成功！')
      })
    },
    // 监听多选框变化
    handleSelectionChange(val){
      this.multipleSelection = val
    },
    async multipleDelete(){
      const _this = this
      //询问影院是否确认删除
      const resp = await this.$confirm('此操作将永久删除这些条目, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)

      // 影院确认删除, resp为字符串"confirm"
      // 影院取消删除，resp为字符串"cancel"
      if (resp == 'cancel'){
        return _this.$message.info('已取消删除')
      }

      let ids = []
      this.multipleSelection.forEach(data => {
        ids.push(data.cinemaBrandId)
      })
      await axios.delete('sysCinemaBrand/' + ids).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除影院品牌失败！')
        }
      })
      this.getCinemaBrandList()
      this.$message.success('批量删除影院品牌成功！')
    },
    //根据id删除对应的品牌分类
    async deleteCinemaBrandById(id){
      const _this = this
      //询问影院是否确认删除
      const resp = await this.$confirm('此操作将永久删除该条目, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)

      // 影院确认删除, resp为字符串"confirm"
      // 影院取消删除，resp为字符串"cancel"
      console.log(resp)
      if (resp == 'cancel'){
        return _this.$message.info('已取消删除')
      }

      await axios.delete('sysCinemaBrand/' + id).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.success('删除影院品牌失败！')
        }
      })
      this.getCinemaBrandList()
      this.$message.success('删除影院品牌成功！')
    }
  }
}
</script>

<style scoped>

</style>