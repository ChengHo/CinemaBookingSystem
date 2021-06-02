<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>场次管理</el-breadcrumb-item>
        <el-breadcrumb-item>场次信息管理</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">
        <el-col :span="4">
          <el-select v-model="selectedHallId" placeholder="请选择影厅名称" clearable>
            <el-option
                v-for="item in hallList"
                :key="item.hallId"
                :label="item.hallName"
                :value="item.hallId">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="4">
          <el-select v-model="selectedMovieId" placeholder="请选择电影名称" clearable>
            <el-option
                v-for="item in movieList"
                :key="item.movieId"
                :label="item.movieName"
                :value="item.movieId">
            </el-option>
          </el-select>
        </el-col>

        <el-col :span="5">
          <el-date-picker
              v-model="selectedDate"
              value-format="yyyy-MM-dd"
              type="date"
              placeholder="选择日期">
          </el-date-picker>
        </el-col>

        <el-col :span="2">
          <el-button icon="el-icon-search" @click="getSessionList">搜索</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="primary" @click="showAddDialog">添加场次</el-button>
        </el-col>
        <el-col :span="2">
<!--          <el-button type="danger" @click="multipleDelete">批量删除</el-button>-->
          <el-button type="danger" @click="isAbleMultipleDelete">批量删除</el-button>
        </el-col>
      </el-row>

      <!--影厅分类列表-->
      <el-table :data="sessionList" style="width: 100%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="sessionId" label="#" width="40"></el-table-column>
        <el-table-column prop="sysHall.hallName" label="影厅名称"></el-table-column>
        <el-table-column prop="sysMovie.movieName" label="电影名称"></el-table-column>
        <el-table-column prop="languageVersion" label="语言"></el-table-column>
        <el-table-column prop="sessionDate" label="场次时间" width="100"></el-table-column>
        <el-table-column prop="playTime" label="播放时间" width="110">
          <template slot-scope="scope">
            <span>{{scope.row.playTime}} - {{scope.row.endTime}}</span>
          </template>
        </el-table-column>
        <el-table-column prop="sessionPrice" label="场次价格"></el-table-column>
        <el-table-column prop="seatNums" label="总座位数"></el-table-column>
        <el-table-column prop="sallNums" label="已售"></el-table-column>
        <el-table-column prop="seatNums - sallNums" label="剩余">
          <template slot-scope="scope">
            <span>{{scope.row.seatNums - scope.row.sallNums}}</span>
          </template>
        </el-table-column>
        <el-table-column prop="sessionTips" label="提示信息"></el-table-column>

        <el-table-column label="操作" width="180" align="center">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改场次信息" placement="top" :enterable="false" :open-delay="500">
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="isAbleEdit(scope.row.sessionId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除场次" placement="top" :enterable="false" :open-delay="500">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="isAbleDelete(scope.row)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="查看座位" placement="top" :enterable="false" :open-delay="500">
              <el-button type="warning" icon="el-icon-setting" size="mini" @click="checkSeat(scope.row.sessionId)"></el-button>
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

    <!--添加场次对话框-->
    <el-dialog title="添加场次" :visible.sync="addDialogVisible" width="60%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="150px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="影厅名称" prop="hallId">
          <el-select v-model="addForm.hallId" placeholder="请选择影厅名称" clearable >
            <el-option
                v-for="item in hallList"
                :key="item.hallId"
                :label="item.hallName"
                :value="item.hallId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="语言版本" prop="languageVersion">
          <el-input v-model="addForm.languageVersion"></el-input>
        </el-form-item>
        <el-form-item label="电影名称" prop="movieId">
          <el-select v-model="addForm.movieId" placeholder="请选择电影名称" clearable >
            <el-option
                v-for="item in movieList"
                :key="item.movieId"
                :label="item.movieName"
                :value="item.movieId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="场次日期" prop="sessionDate">
          <el-date-picker
              v-model="addForm.sessionDate"
              value-format="yyyy-MM-dd"
              type="date"
              placeholder="选择日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="播放时间" prop="sessionTime">
          <el-time-picker
            v-model="addForm.playTime"
            value-format = 'HH:mm'
            placeholder="选择播放时间">
          </el-time-picker>
        </el-form-item>
        <el-form-item label="场次价格" prop="sessionPrice">
          <el-input v-model="addForm.sessionPrice"></el-input>
        </el-form-item>
        <el-form-item label="提示信息" prop="sessionTips">
          <el-input v-model="addForm.sessionTips"></el-input>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addSession">确 定</el-button>
      </span>
    </el-dialog>

    <!--修改场次对话框-->
    <el-dialog title="修改场次" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="150px">
        <el-form-item label="影厅名称" prop="hallId">
          <el-select v-model="editForm.hallId" placeholder="请选择影厅名称" clearable >
            <el-option
                v-for="item in hallList"
                :key="item.hallId"
                :label="item.hallName"
                :value="item.hallId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="语言版本" prop="languageVersion">
          <el-input v-model="editForm.languageVersion"></el-input>
        </el-form-item>
        <el-form-item label="电影名称" prop="movieId">
          <el-select v-model="editForm.movieId" placeholder="请选择电影名称" clearable >
            <el-option
                v-for="item in movieList"
                :key="item.movieId"
                :label="item.movieName"
                :value="item.movieId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="场次日期" prop="sessionDate">
          <el-date-picker
              v-model="editForm.sessionDate"
              value-format="yyyy-MM-dd"
              type="date"
              placeholder="选择日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="播放时间" prop="sessionTime">
          <el-time-picker
            v-model="editForm.playTime"
            value-format = 'HH:mm'
            placeholder="选择播放时间">
          </el-time-picker>
        </el-form-item>
        <el-form-item label="场次价格" prop="sessionPrice">
          <el-input v-model="editForm.sessionPrice"></el-input>
        </el-form-item>
        <el-form-item label="提示信息" prop="sessionTips">
          <el-input v-model="editForm.sessionTips"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editSessionInfo">确 定</el-button>
      </span>
    </el-dialog>

    <!--安排座位对话框-->
    <el-dialog title="查看座位" :visible.sync="checkDialogVisible" :width="checkDialogWidth">
      <div style="display:flex; align-content: center">
        <span style="margin-right: 10px">启用</span>
        <span class="seat" :class="isSelected[0]"></span>
        <span style="margin: 0 10px">禁用</span>
        <span class="seat" :class="isSelected[1]"></span>
        <span style="margin: 0 10px">售出</span>
        <span class="seat" :class="isSelected[2]"></span>
      </div>
      <br/>
      <div class="row" v-for="(value, key) in seats">
        <span style="margin-right: 100px">{{key}}</span>
        <div style="display: flex; justify-content: flex-end">
          <span class="seat" :class="isSelected[seats[key][index]]" v-for="(item, index) in value"></span>
        </div>
      </div>
    </el-dialog>


  </div>
</template>

<script>
import global from "@/assets/css/global.css"
import echarts from 'echarts'
import moment from 'moment'
export default {
  name: "HallInfo",
  data() {
    return {
      queryInfo: {
        hallId: '',
        movieId: '',
        sessionDate: '',
        pageNum: 1,
        pageSize: 7
      },
      sessionList: [],
      total: 0,
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      //添加影厅的表单数据
      addForm: {
        hallId: '',
        languageVersion: '',
        movieId: '',
        playTime: '',
        endTime: '',
        deadline: '',
        sessionDate: '',
        sessionPrice: '',
        sessionTips: '',
        sessionSeats: '',
        seatNums: 0
      },
      //验证表单规则对象
      addFormRules: {
        hallId: [
          { required: true, message: '请选择影厅名称', trigger: 'change' }
        ],
        languageVersion: [
          { required: true, message: '请输入电影语言', trigger: 'blur' }
        ],
        movieId: [
          { required: true, message: '请选择电影名称', trigger: 'change' }
        ],
        sessionDate: [
          { required: true, message: '请选择场次日期', trigger: 'blur' }
        ],
        playTime: [
          { required: true, message: '请选择播放时间', trigger: 'blur' }
        ],
        sessionPrice: [
          { required: true, message: '请输入场次价格', trigger: 'blur' }
        ]
      },
      editDialogVisible: false,
      editForm: {},
      checkAbleId: {},
      editFormRules: {
        hallId: [
          { required: true, message: '请选择影厅名称', trigger: 'change' }
        ],
        languageVersion: [
          { required: true, message: '请输入电影语言', trigger: 'blur' }
        ],
        movieId: [
          { required: true, message: '请选择电影名称', trigger: 'change' }
        ],
        sessionDate: [
          { required: true, message: '请选择场次日期', trigger: 'blur' }
        ],
        playTime: [
          { required: true, message: '请选择播放时间', trigger: 'blur' }
        ],
        sessionPrice: [
          { required: true, message: '请输入场次价格', trigger: 'blur' }
        ]
      },
      selectedHallId: '',
      endPlayTime: '',
      selectedMovieId: '',
      selectedDate: '',
      hallList: [],
      movieList: [],
      multipleSelection: [],
      checkDialogVisible: false,
      seats: {},
      col: '',
      isSelected: {
        0: 'seat-default',
        1: 'seat-choose',
        3: 'seat-sold'
      },
      editSeat: {},
      checkDialogWidth: '',
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        }
      },
      rowNums: '',
      colNums: '',
      rowStart: '',
      loginUser: JSON.parse(window.sessionStorage.getItem('loginUser'))
    }
  },
  created() {
    this.getSessionList()
    this.getHallList()
    this.getMovieList()
    // this.curCinemaName = this.loginUser.cinemaName
  },
  methods: {
    getSessionList() {
      this.queryInfo.hallId = this.selectedHallId
      this.queryInfo.movieId = this.selectedMovieId
      this.queryInfo.sessionDate = this.selectedDate
      console.log(String(this.selectedDate))
      const _this = this;
      axios.get('sysSession', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.sessionList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getSessionList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getSessionList()
      console.log(newPage)
    },
    showAddDialog(){
      this.addDialogVisible = true
    },
    // 监听添加对话框的关闭事件
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
    },
    // 监听添加按钮
    addSession(){
      console.log('添加场次数据处理前')
      console.log(this.addForm)
      const _this = this
      // 处理结束时间和截止时间
      this.handleEndTimeAndDeadline(_this.addForm.movieId, _this.addForm.sessionDate, _this.addForm.playTime)
      console.log('function添加场次的结束时间：' + _this.addForm.endTime)
      this.$refs.addFormRef.validate(async valid => {
        console.log(valid)
        if (!valid) return this.$message.error('添加场次信息失败')
        //验证通过，将登录用户的影院id赋值给表单

        let seats = ''
        let seatNums = 0
        //查询影厅信息，查出对应排数和排座位数，填充sessionSeats字段
        await axios.get('sysHall/' + this.addForm.hallId).then(resp => {
          _this.rowNums = resp.data.data.rowNums
          _this.colNums = resp.data.data.seatNumsRow
          _this.rowStart = resp.data.data.rowStart
          seatNums = resp.data.data.seatNums
          seats = resp.data.data.seatState
        })

        // let row = this.rowNums
        // let col = this.colNums
        // let seat = {}
        // for (let i = 0; i < row; i++) {
        //   let arr = []
        //   for (let j = 0; j < col; j++) {
        //     arr.push(0)
        //   }
        //   seat[isNaN(parseInt(_this.rowStart)) ? String.fromCharCode(i + _this.rowStart.charCodeAt(0)) : i + parseInt(_this.rowStart)] = arr
        // }
        // this.$set(this.addForm, 'sessionSeats', JSON.stringify(seat))
        //新建场次时，将影厅的座位信息赋值给场次
        this.$set(this.addForm, 'seatNums', seatNums)
        this.$set(this.addForm, 'sessionSeats', seats)
        console.log(_this.addForm.sessionSeats)

        // 预校验成功，发网络请求
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        await axios.post('sysSession', JSON.stringify(_this.addForm)).then(resp => {
          console.log(resp)
          if (resp.data.code !== 200){
            this.$message.error('添加场次信息失败！')
          }
        })

        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        this.getSessionList()
        this.$message.success('添加场次信息成功！')
      })
    },
    // 有订单就不能做任何修改
    isAbleEdit(id) {
      this.checkAbleId.sessionId = id
      axios.get('sysBill', {params: this.checkAbleId}).then(response => {
        console.log(response.data.total)
        console.log('data')
        console.log(response.data)
        console.log('data.data')
        console.log(response.data.data)
        console.log(response.data.data.length)
        let bills = response.data.data
        if (response.data.total === 0) {
          console.log('空的可改')
          this.showEditDialog(id)
        } else {
          console.log('修改前判断有场次相关')
          let billIds = ''
          for (let temp of bills) {
            billIds += temp.billId+' '
          }
          console.log('billIds is : '+billIds)
          this.$alert('抱歉！电影场次有相关订单，不能修改电影场次信息。\n'+'导致异常的订单编号为: '+billIds, '修改请求异常通知', {
            confirmButtonText: '我知道了',
            callback: action => {
              this.$router.push('/session')
            }
          })
        }
      })
    },
    // 显示修改对话框，回显数据
    async showEditDialog(id){
      const _this = this
      const { data : res} = await axios.get('sysSession/find/' + id)
      this.editForm = res.data
      this.editDialogVisible = true
    },
    // 监听修改对话框的关闭事件
    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
    },
    // 修改场次信息并提交
    editSessionInfo(){
      this.handleEndTimeAndDeadline(this.editForm.movieId, this.editForm.sessionDate, this.editForm.playTime)
      let row = this.editForm.rowNums
      let col = this.editForm.seatNumsRow
      this.$set(this.editForm, 'seatNums', row * col)
      let seat = {}
      for (let i = 0; i < row; i++) {
        let arr = []
        for (let j = 0; j < col; j++) {
          arr.push(0)
        }
        seat[isNaN(parseInt(this.editForm.rowStart)) ? String.fromCharCode(i + this.editForm.rowStart.charCodeAt(0)) : i + parseInt(this.editForm.rowStart)] = arr
      }
      this.$set(this.editForm, 'seatState', JSON.stringify(seat))

      this.$refs.editFormRef.validate(async valid => {
        const _this = this
        if (!valid) return
        let success = true
        axios.defaults.headers.put['Content-Type'] = 'application/json'
        await axios.put('sysSession', JSON.stringify(_this.editForm)).then(resp => {
          if (resp.data.code !== 200){
            this.$message.error('修改场次信息失败！')
            success = false
          }
        })
        if (!success) return
        this.editDialogVisible = false
        this.getSessionList()
        this.$message.success('修改场次信息成功！')
      })
    },
    //处理散场时间和片场截止时间（修改或删除电影、影厅信息截止时间修改或删除电影、影厅信息截止时间）
    handleEndTimeAndDeadline(movieId, sessionDate, playTime){
      this.addForm.deadline = ''
      this.editForm.deadline = ''
      this.addForm.endTime = ''
      this.editForm.endTime = ''
      let resultEndTime = ''
      //电影时长
      let movieLengthTime
      for (let item of this.movieList) {
        if (item.movieId === movieId) {
          movieLengthTime = item.movieLength
          break
        }
      }
      //临时时间，用于记录开播时间，使用moment工具
      let tempTime = new Date(sessionDate)
      //分离开播时间
      let hoursMin = playTime.split(':')
      tempTime.setHours(hoursMin[0])
      tempTime.setMinutes(hoursMin[1])
      tempTime.setSeconds(0)
      let tempEndTime = moment(tempTime).add(movieLengthTime,'m')._d
      // 片场结束时间再加20分钟
      let tempDeadline = moment(moment(tempEndTime).add(20,'m')._d).format('YYYY-MM-DD HH:mm:ss')

      // 设置deadline
      this.addForm.deadline = tempDeadline
      this.editForm.deadline = tempDeadline
      console.log('修改后时间'+tempEndTime);
      let endHours = tempEndTime.getHours()
      let endMins = tempEndTime.getMinutes()
      //时间格式化
      if (endHours < 10) {
        resultEndTime = '0'+endHours+':'
      } else {
        resultEndTime = endHours+':'
      }
      if (endMins < 10) {
        resultEndTime += '0'+endMins
      } else {
        resultEndTime += endMins
      }
      console.log('添加场次的结束时间：' + resultEndTime)
      // return resultEndTime
      this.addForm.endTime = resultEndTime
      this.editForm.endTime = resultEndTime
    },
    // 监听多选框变化
    handleSelectionChange(val){
      this.multipleSelection = val
    },
    // 批量删除前校验
    async isAbleMultipleDelete() {
      let ableMultipleDelete = true
      let ids = ''
      for (let i = 0; i < this.multipleSelection.length; i++) {
        this.checkAbleId.sessionId = this.multipleSelection[i].sessionId

        console.log('sessionid' + this.checkAbleId.sessionId)
        // 每条数据都进行时间校验
        // const { data : resp } = await axios.get('sysSession', {params: this.checkAbleId})
        const { data : resp } = await axios.get('sysSession/find/' + this.checkAbleId.sessionId)
        console.log('获取的场次信息')
        console.log(resp.data)
        let curSessionInfo = resp.data
        // 如果当前场次已完成，不操作
        if (curSessionInfo.deadline <= moment(new Date()).format('YYYY-MM-DD HH:mm:ss')) continue

        const { data : res } = await axios.get('sysBill', {params: this.checkAbleId})
        if (res.data.length !== 0) {
          ids += this.multipleSelection[i].sessionId + ' '
          ableMultipleDelete = false
        }
      }
      if (ableMultipleDelete === false) {
        // '抱歉！。\\n\'+\'导致异常的订单编号为: \''
        this.$alert('抱歉！电影场次有相关订单，不能删除电影场次信息。\n' + '导致异常的场次编号为: ' + ids, '批量删除请求异常通知', {
          confirmButtonText: '我知道了',
          callback: action => {
            this.$router.push('/session')
          }
        })
        return
      }
      await this.multipleDelete()
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
        ids.push(data.sessionId)
      })
      console.log(ids)
      await axios.delete('sysSession/' + ids).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除场次失败！')
        }
      })
      this.getSessionList()
      this.$message.success('批量删除场次成功！')
    },
    // 两层检验，第一层检验场次是否完成，完成则可删；第二层检验未完成，是否有订单，有订单不可删。不论订单支付与否
    async isAbleDelete(session) {
      if (session.deadline <= moment(new Date()).format('YYYY-MM-DD HH:mm:ss')) {
        await this.deleteSessionById(session.sessionId)
        return
      }
      this.checkAbleId.sessionId = session.sessionId
      axios.get('sysBill', {params: this.checkAbleId}).then(response => {
        console.log(response.data.total)
        let bills = response.data.data
        if (response.data.total === 0) {
          console.log('空的可改')
          this.deleteSessionById(session.sessionId)
        } else {
          console.log('删除前判断有场次相关')
          let billIds = ''
          for (let temp of bills) {
            console.log(temp)
            billIds += temp.billId+' '
          }
          console.log('billIds is : '+billIds)
          this.$alert('抱歉！电影场次有相关订单，不能删除电影场次信息。\n'+'导致异常的订单编号为: '+billIds, '删除请求异常通知', {
            confirmButtonText: '我知道了',
            callback: action => {
              this.$router.push('/session')
            }
          })
        }
      })
    },
    //根据id删除对应的影厅分类
    async deleteSessionById(id){
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

      await axios.delete('sysSession/' + id).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.success('删除场次信息失败！')
        }
      })
      this.getSessionList()
      this.$message.success('删除场次信息成功！')
    },
    getHallList(){
      const _this = this
      axios.get('sysHall').then(resp => {
        _this.hallList = resp.data.data;
      })
    },
    getMovieList(){
      const _this = this
      axios.get('sysMovie/find').then(resp => {
        _this.movieList = resp.data.data;
      })
    },
    async checkSeat(id){
      const _this = this
      await axios.get('sysSession/find/' + id).then(resp => {
        console.log(resp)
        _this.seats = JSON.parse(resp.data.data.sessionSeats)
        _this.col = resp.data.data.sysHall.seatNumsRow
      })
      console.log(this.col)
      this.checkDialogWidth = 200 + this.col * 40 + 'px'
      this.checkDialogVisible = true
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
.seat{
  display: inline-block;
  width: 30px;
  height: 26px;
  margin: 0 5px;
  background-position: 0 1px;
}
.seat-default {
  background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAHKSURBVEhLxZfbysIwDMezKeJUVAR9A/H9X0FQZMOLeem14sWc4AnP9muybM4557eT/mCYdLT/tknaqQgJ/ACVf7/Oz4TfbvVisYDlcgm1Wg2SRON0OoGqqtDr9bglAAoHGY1GQgqzl5zz+SyGwyF7z7wITyYTtrJD13W2HrzEuFqtspUdnU4Hbrcbew5fSa5SqfQbYbmzoCgKew5fK6disciWgyd8vV5hPB5DoVAA27bpSct6vQbLsmjFhmFwK0MpJjFNky2H3W4nZEf24rPZbMTlcmFPiPv9LgaDAXu+rNY0jS0HzG5Zh+zFRwo9bS/GuNvtgpwM+SQsVwetVosa/GDnpMhFsfUAJ3I4HMgmYRQIZl1awsbzTyYyqzHRkhK2Yj+RwklwBYMHRpDMhd0tTrXiT52jwCsxCrqPZc3RARLM7O1266V/XMrlMlQqFfYcVqsVZXa9Xo8Wzhq/cOYx/i+e8KeYZIFfgyyMxWw2o4Y8mc/nXty9jz08NqfTKTSbTapBLAt8kh6buDocGh+3xNrtNjQaDbLxRSj7/f7pNolLv98Xx+ORvVfeBla+S3VJ4K7hGO/I7S8MDht2UbjklspRokj+NRQKwB/pWISi3oSUQQAAAABJRU5ErkJggg==") no-repeat;
}
.seat-choose{
  background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAKVSURBVEhLxZXPThpRFMY/hhFBG4okbdiYxgXpxmJi0phi4sKlL+HWlSsfwMSFr+DKjSufwMSFiyakaaagQaOxW1txUUjDHwVh5vacmdtxgGEsA1N/yYHLvdzzzT33nDMhQeAFUOT3f+fFhAeGutRs4tfpKV5dXECoqpz9R8hlKxqFsrqK96mUnOzGVfhrsYh3+/tIXV8Dk5Nydkh0HW3a+21zE59WVuTkE33C5/k8PmxvW4ITE/SPkFzxQacDUOS0nR18XFiQkxZ9dzx9dARwaCOR0UQZ9kP29vAQupz6S39y8UmVMeZcOIwInfp54QAQdJDe2LkLt9tAq2Vmp294L/vhe6Zxb13YwrSMvKZRZMIoLy2hvLYG3N/7E+c9FN7f2SzK8/MQiQS0szO5aGFndfHkBJndXSAeNzc2ZmehUw3GCwUru4eBTlpbXETs6grqwwNgGBBkX7a2kF1eNv9inziWy1minFxU/NM3N2jHYr5PbJAPtdGwHpp8hiiS6YMDUPBNTOE6WfL21sxAGx7Xav5KivaIx0fy7kghGqv0QHR+6yd/GGQUcx52M0Idu+0UDn+ORxovLp24i8CEO9SrvQhM+LlL8hQWnJHcBHxYiKvDA7OOqzTobGwgWalYjZ2hjlObm0N7Zmb4kqIkipZKmLq7e6oU8ldJJqHu7YGK1kOYke3OF1xKzvLsEfa+Y34IDrcfc4q6YAsrfDcBozgy3RSeIvuRyVidinsrNfixW7WKn+m0qcXYLwlum9+Pj5G4vITO709KEDaDmrsfFPLBrtnMrkhvqDfr63gt13nBlYZhiFyhIH8Nz2dNE005dmNgcgl6Fxv8dvGJXq9DcIgHYId63LBbvqpBeJfTCHiJMoEJewP8Afy6sw903o8jAAAAAElFTkSuQmCC") no-repeat;
}
.seat-sold{
  background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAANwSURBVEhLxZZLTBNRFIb/mWlpjbWAYgISNBofGyMGwQdEg0sTdaciaNy40UTxmeiKuDPGxwZXsjAuDNHohmhcYARjjGJBoYSFhAUYA+EpSksfQ8dz7gwwbacj5SEfXMq9c+757z3n3DuVNALLgGx8/neWTThlqIMjgL+3Gd3B11AklzE6NzTEkKFloTT/LNZtzDJG47EUbm/twouhk+hTOpAhGYNpMkXNSX+qPO+wv6xcHzSRJNzW/hm1A3vhcgD0C2mewswUeQ6T+IUcPwqLthujOkk5bh68AycpOklwIaKMQvMdCvBqsNoYmSVJOENeiQXqxcECEYzrHRP/paplKVnGUlil3ERiVJ2W9Z4atg9Gab4xN0qfXGRWB2dWmJ598bVAURzY4T6CA9mXEUpDnO1GQ8D5nfXYlFmMICkWeSux2XEQ3ow8fPX5DUudmapuamlA3dhReKiweCTXsRVrXdvQFWyAYw5JH54ErhY/pfqQ8aCtAnuyD6Mn0IgQ/bBAjBZyxvMBZaVlwn5mx22jT4Qon1sXjQ6o3+GWssWkKE0KUAitds9jLHqtuF707/oq4HGyDy8mtZA4HexToepuGD8tbBhdOAIMSa1xCeejMBEZFvkqyTuGm7ubMEKhNIvz/xxe3qlG2bzvq8Qat34MI1NBKirDkBC+ZRW0FoGuxbmkiSY7gUTV6CSL9z+e4+dEB2r2NYrdTYvzQq4Y4b3nq8JqQ5SRLC8Baea5LmxlY8JLV/Uj/0X0Bzpxq6xRCCaGN2fFrChjVclmzNG1hXdT57+E/okuXC95hnOFtXHhTURVqShssBVOXDWL885/h/vhdmSRaHx44/hHFG2FnbJbXCbmxmF/3FWNh+2nkEmifEEk2nBzKR5xIlKhn+MwcKNpA/44+kQ1M/xmyXfuglcpIAdUfWkgQ8Gg2olhtTvO3yp1PW6X99KqbIQZNrZbtR3sJtGXWdg21DyRb635NLOoFUKYa0ilq22piSE6cwcIYYmKZAuOI0CpDHOjh4vdJshvQeyQ0BKaIseERnl+2/oSPeE3kDWnuHm4xWLpFdY0siyL4yga7dXrysWJohpIdNEIWNiKqZCmtX7yG730afn4TdOiRseClMU1qQbopf7L6KVPIDyGkJq6bpK+ZS4W7Nb6RaFje5wWgp0os2TC9gB/AXsuAMA34noyAAAAAElFTkSuQmCC") no-repeat;
}
</style>
