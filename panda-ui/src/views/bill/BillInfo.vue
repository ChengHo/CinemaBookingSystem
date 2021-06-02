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
        <el-col :span="5">
          <el-input v-model="inputUserName" placeholder="请输入用户名" clearable></el-input>
        </el-col>
        <el-col :span="4">
          <el-select v-model="selectedState" placeholder="请选择订单状态" clearable>
            <el-option v-for="item in payStates" :key="item.id" :label="item.name" :value="item.id"></el-option>
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
          <el-button type="danger" @click="multipleDelete">批量删除</el-button>
        </el-col>
      </el-row>

      <!--订单列表-->
      <el-table :data="billList" style="width: 100%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="billId" label="#" width="40"></el-table-column>
        <el-table-column prop="sysUser.userName" label="用户名" width="80px"></el-table-column>
        <el-table-column prop="sysSession.sysMovie.movieName" label="电影名称"></el-table-column>
        <el-table-column prop="sysSession.sysHall.hallName" label="影厅名称"></el-table-column>
        <el-table-column prop="sysSession.sessionDate" label="场次日期"></el-table-column>
        <el-table-column prop="sysSession.playTime, sysSession.endTime" label="播放时间">
          <template slot-scope="scope"> {{scope.row.sysSession.playTime}}-{{scope.row.sysSession.endTime}} </template>
        </el-table-column>
        <el-table-column prop="seats" label="座位"></el-table-column>
        <el-table-column prop="createTime" label="订票时间"></el-table-column>
        <el-table-column prop="payState" label="订单状态" width="80">
          <template slot-scope="scope">
            <span v-if="scope.row.payState === true" style="color: #13ce66">已完成</span>
            <span v-if="scope.row.payState !== true && scope.row.cancelState !== true " style="color: #145ddc">未支付</span>
            <span v-if="scope.row.cancelState === true && scope.row.cancelTime ===null" style="color: #e6a23c">超时取消</span>
            <span v-if="scope.row.cancelState === true && scope.row.cancelTime !==null" style="color: crimson">用户取消</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改订单信息" placement="top" :enterable="false" :open-delay="500">
              <el-button type="primary" icon="el-icon-edit" size="mini"
                         @click="showEditDialog(scope.row.billId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除订单" placement="top" :enterable="false" :open-delay="500">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteBillById(scope.row.billId)"></el-button>
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



    <!--修改影厅对话框-->
    <el-dialog title="修改订单" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" ref="editFormRef" label-width="100px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="订单编号" prop="billId">
          <el-input v-model="editForm.billId" disabled></el-input>
        </el-form-item>
        <el-form-item label="用户名" prop="sysUser.userName">
          <el-input v-model="editForm.sysUser.userName" disabled></el-input>
        </el-form-item>
        <el-form-item label="电影名称" prop="sysSession.sysMovie.movieName">
          <el-input v-model="editForm.sysSession.sysMovie.movieName" disabled></el-input>
        </el-form-item>
        <el-form-item label="影厅名称" prop="sysSession.sysHall.hallName">
          <el-input v-model="editForm.sysSession.sysHall.hallName" disabled></el-input>
        </el-form-item>
        <el-form-item label="座位" prop="sysSession.sysHall.hallName">
          <el-input v-model="editForm.seats" disabled></el-input>
        </el-form-item>
        <el-form-item label="场次日期" prop="sysSession.sessionDate">
          <el-input v-model="editForm.sysSession.sessionDate" disabled></el-input>
        </el-form-item>
        <el-form-item label="播放时间" prop="sysSession.sessionDate">
          <el-input v-model="editForm.sysSession.playTime" disabled></el-input>
        </el-form-item>
        <el-form-item label="散场时间" prop="sysSession.sessionDate">
          <el-input v-model="editForm.sysSession.endTime" disabled></el-input>
        </el-form-item>
        <el-form-item label="订单时间" prop="sysSession.sessionDate">
          <el-input v-model="editForm.createTime" disabled></el-input>
        </el-form-item>
        <el-form-item label="支付状态" prop="payState" v-if="!editForm.cancelState">
          <el-select v-model="editForm.payState" placeholder="请选择支付状态" clearable >
            <el-option
              v-for="item in payStates"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="取消状态" prop="cancelState" v-if="!editForm.payState">
          <el-select v-model="editForm.cancelState" placeholder="请选择取消状态" clearable >
            <el-option
              v-for="item in cancelStates"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editBillInfo">确 定</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
import global from "@/assets/css/global.css"
import moment from 'moment'
export default {
  name: "billInfo",
  data() {
    return {
      queryInfo: {
        queryByUserName: '',
        payState: '',
        createTime: '',
        pageNum: 1,
        pageSize: 7
      },
      billList: [],
      total: 0,
      multipleSelection: [],
      inputUserName: '',
      selectedState: '',
      selectedDate: '',
      editDialogVisible: false,
      editForm: {
        sysUser: {
          userName: ''
        },
        sysSession: {
          sysMovie: {},
          sysHall: {}
        }
      },
      payStates: [
        {
          id: 0,
          name: '未支付'
        },
        {
          id: 1,
          name: '已完成'
        }
      ],
      cancelStates: [
        {
          id: 0,
          name: '未取消'
        },
        {
          id: 1,
          name: '已取消'
        }
      ],
    }
  },
  created() {
    this.getBillList()
  },
  methods: {
    async getBillList() {
      // this.userName = this.inputUserName
      this.queryInfo.payState = this.selectedState
      this.queryInfo.createTime = this.selectedDate
      console.log('quaryInfo'+this.inputUserName)
      this.queryInfo.queryByUserName = this.inputUserName
      console.log('sysUser.userName')
      console.log(this.queryInfo.queryByUserName)
      const _this = this;
      await axios.get('sysBill', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.billList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getBillList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getBillList()
      console.log(newPage)
    },
    // 监听多选框变化
    handleSelectionChange(val){
      this.multipleSelection = val
    },
    // 显示修改对话框，回显数据
    async showEditDialog(id) {
      let isAbleEdit = true
      await axios.get('sysBill/' + id ).then(resp => {
        console.log(resp)
        this.editForm = resp.data.data
        this.editForm.sysUser = resp.data.data.sysUser
        console.log('this.editForm')
        console.log(this.editForm)

        if (this.editForm.payState === true || this.editForm.cancelState === true) {
          isAbleEdit = false
          this.$alert('抱歉！订单已完成或已取消，不能修改。', '修改请求异常通知', {
            confirmButtonText: '我知道了',
            callback: action => {
              this.$router.push('/bill')
            }
          })
        }
      })
      if (isAbleEdit) {
        this.editForm.payState = 0
        this.editForm.cancelState = 0
        this.editDialogVisible = true
      }
    },
    // 监听修改对话框的关闭事件
    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
    },
    // 修改影厅分类信息并提交
    async editBillInfo() {
      const _this = this
      if (_this.editForm.cancelState && _this.editForm.payState) {
        this.$alert('抱歉，修改失败！取消状态和支付状态不能同时为真。', '修改订单信息异常', {
          confirmButtonText: '我知道了',
          callback: action => {
            this.$router.push('/bill')
          }
        })
        this.editDialogVisible = false
        return
      }
      if (_this.editForm.payState) {
        const { data: res} = await axios.put('sysBill', JSON.stringify(_this.editForm))
        if(res.code !== 200) return this.$message.error('支付失败')
        this.$message.success('支付订单成功')
        this.editDialogVisible = false
        this.getBillList()
        return
      } else if (_this.editForm.cancelState) {
        _this.editForm.cancelState = true
        _this.editForm.cancelTime = moment(new Date()).format('YYYY-MM-DD HH:mm:ss')
        // 获取场次座位信息
        const { data : curSession } = await axios.get('sysSession/find/' + _this.editForm.sessionId)
        let sessionSeats = JSON.parse(curSession.data.sessionSeats)
        // 解析出订单选择的座位，更新座位信息
        for(let seat of JSON.parse(_this.editForm.sests)){
          let row = seat.substring(0, seat.indexOf('排'))
          let col = Number.parseInt(seat.substring(seat.indexOf('排') + 1, seat.length - 1))
          sessionSeats[row][col - 1] = 0
        }
        // 更新订单信息和场次座位信息
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        const { data: resp } = await axios.put('sysBill/cancel',JSON.stringify({sysBill: _this.editForm, sessionSeats: JSON.stringify(sessionSeats)}))
        if(resp.code !== 200) return this.$message.error('取消失败')
        this.getBillList()
        this.editDialogVisible = false
        this.$message.success('取消订单成功')
      }
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
      if (resp === 'cancel'){
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
      if (resp === 'cancel'){
        return _this.$message.info('已取消删除')
      }

      await axios.delete('sysBill/' + id).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.success('删除订单失败！')
        }
      })
      this.getBillList()
      this.$message.success('删除订单成功！')
    }
  }
}
</script>

<style scoped>

</style>
