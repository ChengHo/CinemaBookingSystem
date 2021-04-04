<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>订单管理</el-breadcrumb-item>
        <el-breadcrumb-item>订单信息管理</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">
        <el-col :span="4">
          <el-select v-model="selectedState" placeholder="请选择订单状态" clearable>
            <el-option v-for="item in states" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-col>

        <el-col :span="5">
          <el-date-picker
              v-model="selectedDate"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="选择日期时间">
          </el-date-picker>
        </el-col>

        <el-col :span="2">
          <el-button icon="el-icon-search" @click="getBillList">搜索</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="multipleDelete" v-has>批量删除</el-button>
        </el-col>
      </el-row>

      <!--影厅分类列表-->
      <el-table :data="billList" style="width: 100%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="billState" label="订单状态">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.billState" @change="billStateChanged(scope.row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column prop="sysUser.userName" label="用户名" width="80px"></el-table-column>
        <el-table-column prop="sysSession.sysCinema.cinemaName" label="影院名称"></el-table-column>
        <el-table-column prop="sysSession.sysHall.hallName" label="影厅名称"></el-table-column>
        <el-table-column prop="sysSession.sysMovie.movieNameCn" label="电影名称"></el-table-column>
        <el-table-column prop="sysSession.sysMovieRuntime.movieRuntimeName" label="播放时段"></el-table-column>
        <el-table-column prop="sysSession.sessionDate" label="场次时间"></el-table-column>
        <el-table-column prop="seats" label="座位"></el-table-column>
        <el-table-column prop="billDate" label="订票日期"></el-table-column>
        <el-table-column label="操作" width="70px">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="删除影厅" placement="top" :enterable="false" :open-delay="500">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteBillById(scope.row.billId)" v-has></el-button>
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
  </div>
</template>

<script>
import global from "@/assets/css/global.css"
export default {
  name: "billInfo",
  data() {
    return {
      queryInfo: {
        billState: '',
        billDate: '',
        pageNum: 1,
        pageSize: 7
      },
      billList: [],
      total: 0,
      multipleSelection: [],
      selectedState: '',
      selectedDate: '',
      states: [
        {
          id: 0,
          name: '未支付'
        },
        {
          id: 1,
          name: '已完成'
        }
      ],
    }
  },
  created() {
    this.getBillList()
  },
  methods: {
    getBillList() {
      this.queryInfo.billState = this.selectedState
      this.queryInfo.billDate = this.selectedDate
      const _this = this;
      axios.get('sysBill', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.billList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getHallCategoryList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getHallCategoryList()
      console.log(newPage)
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
        ids.push(data.billId)
      })
      await axios.delete('sysBill/' + ids).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除失败！')
        }
      })
      this.getBillList()
      this.$message.success('批量删除成功！')
    },
    //根据id删除对应的影厅分类
    async deleteBillById(id){
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

      await axios.delete('sysBill/' + id).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.success('删除订单失败！')
        }
      })
      this.getBillList()
      this.$message.success('删除订单成功！')
    },
    async billStateChanged(billInfo){
      const _this = this
      axios.defaults.headers.put['Content-Type'] = 'application/json'
      await axios.put('/sysBill', JSON.stringify(billInfo)).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.error('更新订单状态失败！')
        }
      })
      this.getBillList()
      this.$message.success('更新订单状态成功！')
    }
  }
}
</script>

<style scoped>

</style>