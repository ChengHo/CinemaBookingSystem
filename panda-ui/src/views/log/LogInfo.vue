<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>日志管理</el-breadcrumb-item>
        <el-breadcrumb-item>查看日志</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">

        <el-col :span="4">
          <el-input placeholder="请输入用户名"  clearable />
<!--          v-model="inputUserName"-->
        </el-col>
        <el-col :span="2">
          <el-button type="el-icon-search" @click="getLogList">搜索</el-button>
        </el-col>
      </el-row>

      <el-table :data="loglist" style="width: 100%" border stripe >
        <el-table-column prop="userName" label="操作人"></el-table-column>
        <el-table-column prop="description" label="操作描述"></el-table-column>
        <el-table-column prop="params" label="参数"></el-table-column>
        <el-table-column prop="startTime" label="操作时间"></el-table-column>
        <el-table-column prop="spendTime" label="执行耗时（ms）"></el-table-column>
        <el-table-column prop="basePath" label="根路径"></el-table-column>
        <el-table-column prop="reqUri" label="请求路径"></el-table-column>
        <el-table-column prop="method" label="请求方法"></el-table-column>
        <el-table-column prop="reqType" label="请求类型"></el-table-column>
        <el-table-column prop="userAgent" label="用户标识"></el-table-column>
        <el-table-column prop="ip" label="服务器ip"></el-table-column>
        <el-table-column prop="result" label="是否成功"></el-table-column>
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

  </div>


</template>

<script>

export default {
  name: "LogInfo",

  data() {


    return {
      queryInfo: {
        userName: '',
        pageNum: 1,
        pageSize: 7
      },
      loglist: [],
      total: 0,
    }
  },
  created() {
    this.getLogList()
  },
  methods: {
    getLogList() {
      const _this = this;
      axios.get('sysLog', {params: _this.queryInfo}).then(resp => {
        console.log(resp);
        _this.loglist = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getLogList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getLogList()
      console.log(newPage)
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
