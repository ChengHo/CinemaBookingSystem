<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>权限管理</el-breadcrumb-item>
        <el-breadcrumb-item>角色信息管理</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!-- 卡片视图 -->
    <el-card>
      <el-row :gutter="20">
        <el-col :span="2.5">
          <el-button type="primary" @click="addDialogVisible = true">添加角色</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="isAbleMultipleDelete">批量删除</el-button>
        </el-col>
      </el-row>

      <el-table :data="roleList" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="roleId" label="角色编号" width="145"></el-table-column>
        <el-table-column prop="roleName" label="角色名称" width="180"></el-table-column>
        <el-table-column prop="roleDesc" label="角色描述" width="180"></el-table-column>
        <el-table-column label="操作" width="200">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改角色信息" placement="top" :enterable="false" :open-delay="500">
              <el-button type="primary" icon="el-icon-edit" size="mini"
                         @click="showEditDialog(scope.row.roleId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除角色" placement="top" :enterable="false" :open-delay="500">
              <el-button type="danger" icon="el-icon-delete" size="mini"
                         @click="isAbleDelete(scope.row.roleId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="分配权限" placement="top" :enterable="false" :open-delay="500">
              <el-button type="warning" icon="el-icon-setting" size="mini"
                         @click="showSetRightDialog(scope.row)"></el-button>
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

    <!--添加角色对话框-->
    <el-dialog title="添加角色" :visible.sync="addDialogVisible" width="50%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <el-form-item label="角色名称" prop="roleName">
          <el-input v-model="addForm.roleName"></el-input>
        </el-form-item>
        <el-form-item label="角色描述" prop="roleDesc">
          <el-input v-model="addForm.roleDesc"></el-input>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addRole">确 定</el-button>
      </span>
    </el-dialog>

    <!--修改角色对话框-->
    <el-dialog title="修改角色" :visible.sync="editDialogVisible" width="50%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
        <el-form-item label="角色编号" prop="roleId">
          <el-input v-model="editForm.roleId" disabled></el-input>
        </el-form-item>
        <el-form-item label="角色名称" prop="roleName">
          <el-input v-model="editForm.roleName"></el-input>
        </el-form-item>
        <el-form-item label="角色描述" prop="roleDesc">
          <el-input v-model="editForm.roleDesc"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editRole">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 分配权限对话框 -->
    <el-dialog
        title="提示"
        :visible.sync="setRightDialogVisible"
        width="50%"
        @close="setRightDialogClosed">
      <!-- 树形控件 -->
      <el-tree :data="resourceList"
               :props="treeProps"
               node-key="id"
               :default-checked-keys="defKeys"
               ref="treeRef"
               show-checkbox
               default-expand-all></el-tree>
      <span slot="footer" class="dialog-footer">
        <el-button @click="setRightDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitRights">确 定</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
import moment from "moment";
export default {
  name: "RoleInfo",
  data() {
    return {
      queryInfo: {
        query: '',
        pageNum: 1,
        pageSize: 7
      },
      roleList: [],
      resourceList: [],
      //树形控件的属性对象
      treeProps: {
        children: 'children',
        label: 'name'
      },
      //默认勾选的权限列表
      defKeys: [],
      total: 0,
      addDialogVisible: false,
      //添加角色的表单数据
      addForm: {
        roleName: '',
        roleDesc: ''
      },
      //验证表单规则对象
      addFormRules: {
        roleName: [
          {required: true, message: '请输入角色名', trigger: 'blur'}
        ],
        roleDesc: [
          {required: true, message: '请输入角色描述', trigger: 'blur'}
        ]
      },
      editDialogVisible: false,
      editForm: {
        roleId: null,
        roleName: '',
        roleDesc: ''
      },
      checkAbleId: {},
      editFormRules: {
        roleName: [
          {required: true, message: '请输入角色名', trigger: 'blur'}
        ],
        roleDesc: [
          {required: true, message: '请输入角色描述', trigger: 'blur'}
        ]
      },
      multipleSelection: [],
      //分配权限对话框的显示与隐藏
      setRightDialogVisible: false,
      //当前分配权限的id
      roleId: ''
    }
  },
  created() {
    this.getRoleList()
  },
  methods: {
    async getRoleList() {
      const {data: res} = await axios.get('sysRole', {params: this.queryInfo})
      this.roleList = res.data;
      this.total = res.total
      this.queryInfo.pageNum = res.pageNum
      this.queryInfo.pageSize = res.pageSize
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getRoleList()
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getRoleList()
    },
    // 监听添加对话框的关闭事件
    addDialogClosed() {
      this.$refs.addFormRef.resetFields()
    },
    // 监听添加按钮
    addRole() {
      const _this = this;
      this.$refs.addFormRef.validate(async valid => {
        if (!valid) return
        //预校验成功，发网络请求

        axios.defaults.headers.post['Content-Type'] = 'application/json'
        const {data: res} = await axios.post('sysRole', JSON.stringify(_this.addForm))
        if (res.code !== 200) return this.$message.error(res.msg)
        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        await this.getRoleList()
        this.$message.success('添加角色信息成功！')
      })
    },
    // 显示修改对话框，回显数据
    async showEditDialog(id) {
      const _this = this
      await axios.get('sysRole/' + id).then(resp => {
        console.log(resp)
        _this.editForm = resp.data.data
      })
      this.editDialogVisible = true
    },
    // 监听修改对话框的关闭事件
    editDialogClosed() {
      this.$refs.editFormRef.resetFields()
    },
    // 修改角色信息并提交
    editRole() {
      this.$refs.editFormRef.validate(async valid => {
        const _this = this
        if (!valid) return
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        const {data: res} = await axios.put('sysRole/', JSON.stringify(_this.editForm))
        if (res.code !== 200) return this.$message.error(res.msg)

        this.editDialogVisible = false
        await this.getRoleList()
        this.$message.success('修改角色信息成功！')
      })
    },
    // 监听多选框变化
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    // 批量删除前校验
    async isAbleMultipleDelete() {
      let ableMultipleDelete = true
      let ids = ''
      for (let i = 0; i < this.multipleSelection.length; i++) {
        this.checkAbleId.roleId = this.multipleSelection[i].roleId
        const { data : res } = await axios.get('sysUser', {params: this.checkAbleId})
        if (res.data.length !== 0) {
          ids += this.multipleSelection[i].roleId + ' '
          ableMultipleDelete = false
        }
      }
      if (ableMultipleDelete === false) {
        this.$alert('抱歉！有用户与当前要删除的角色相关联，不能删除角色信息。\n' + '导致异常的角色编号为: ' + ids, '批量删除请求异常通知', {
          confirmButtonText: '我知道了',
          callback: action => {
            this.$router.push('/role')
          }
        })
        return
      }
      await this.multipleDelete()
    },
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
        ids.push(data.roleId)
      })
      let success = true
      await axios.delete('sysRole/' + ids).then(resp => {
        if (resp.data.code !== 200) {
          success = false;
        }
      })
      if (!success) return this.$message.error('批量删除资源信息失败！')
      await this.getRoleList()
      this.$message.success('批量删除资源信息成功！')
    },
    async isAbleDelete(id) {
      this.checkAbleId.roleId = id
      await axios.get('sysUser', {params: this.checkAbleId}).then(response => {
        console.log(response.data.total)
        let users = response.data.data
        if (response.data.total === 0) {
          console.log('空的可改')
          this.deleteRoleById(id)
        } else {
          console.log('删除前判断有相关联的user')
          let ids = ''
          for (let temp of users) {
            console.log(temp)
            ids += temp.userId+' '
          }
          console.log('users is : '+ids)
          this.$alert('抱歉！有用户与当前要删除的角色相关联，不能删除角色信息。\n'+'导致异常的用户编号为: '+ids, '删除请求异常通知', {
            confirmButtonText: '我知道了',
            callback: action => {
              this.$router.push('/role')
            }
          })
        }
      })
    },
    //根据id删除对应的资源信息
    async deleteRoleById(roleId) {
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

      let success = true
      await axios.delete('sysRole/' + roleId).then(resp => {
        if (resp.data.code !== 200) {
          success = false
        }
      })
      if (!success) return _this.$message.error('删除角色信息失败！')
      await this.getRoleList()
      this.$message.success('删除角色信息成功！')
    },
    //展示分配权限对话框
    async showSetRightDialog(role) {
      this.roleId = role.roleId
      const {data: res} = await axios.get('sysResource/tree')
      this.resourceList = res.data
      console.log(role)
      await this.getLeafKeys(role, this.defKeys)
      console.log('defKeys' + this.defKeys)
      this.setRightDialogVisible = true
    },
    //获取角色对应的所有具体权限id
    getLeafKeys(node, arr) {
      if(!node) return
      if (!node.children) {
        return arr.push(node.id)
      }

      node.children.forEach(item => this.getLeafKeys(item, arr))
    },
    //关闭分配权限对话框，刷新defKeys
    setRightDialogClosed() {
      this.defKeys = []
    },
    async submitRights() {
      const keys = [
          ...this.$refs.treeRef.getCheckedKeys(true)
      ]
      const _this = this
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      const {data : res} = await axios.post('sysRole/' + _this.roleId, JSON.stringify(keys))
      if(res.code !== 200) return this.$message.error("更新权限失败！")

      this.$message.success("更新权限成功！")
      await this.getRoleList()
      this.setRightDialogVisible = false
    }
  }
}
</script>

<style scoped>

</style>
