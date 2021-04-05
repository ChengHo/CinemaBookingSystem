<template>
  <div>
    <!--面包屑导航区域-->
    <div class="board">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>影厅管理</el-breadcrumb-item>
        <el-breadcrumb-item>影厅信息</el-breadcrumb-item>
      </el-breadcrumb>
    </div>


    <!--卡片视图-->
    <el-card class="box-card">
      <el-row :gutter="20">
        <el-col :span="4">
          <el-select v-model="selectedCinemaId" placeholder="请选择影院名称" clearable v-has>
            <el-option
                v-for="item in cinemaList"
                :key="item.cinemaId"
                :label="item.cinemaName"
                :value="item.cinemaId">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="4">
          <el-select v-model="selectedHallCategoryId" placeholder="请选择影厅分类" clearable>
            <el-option
                v-for="item in hallCategoryList"
                :key="item.hallCategoryId"
                :label="item.hallCategoryName"
                :value="item.hallCategoryId">
            </el-option>
          </el-select>
        </el-col>
        <el-col :span="4">
          <el-select v-model="selectedHallState" placeholder="请选择影厅状态" clearable>
            <el-option v-for="item in states" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-col>
        <el-col :span="1.5">
          <el-button icon="el-icon-search" @click="getHallList">搜索</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="primary" @click="addDialogVisible = true">添加影厅</el-button>
        </el-col>
        <el-col :span="2">
          <el-button type="danger" @click="multipleDelete">批量删除</el-button>
        </el-col>
      </el-row>

      <!--影厅分类列表-->
      <el-table :data="hallList" style="width: 100%" border stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="sysCinema.cinemaName" label="影院名称"></el-table-column>
        <el-table-column prop="hallName" label="影厅名称"></el-table-column>
        <el-table-column prop="sysHallCategory.hallCategoryName" label="影厅分类"></el-table-column>
        <el-table-column prop="rowStart" label="起始行"></el-table-column>
        <el-table-column prop="rowNums" label="行数"></el-table-column>
        <el-table-column prop="seatNumsRow" label="行座位数"></el-table-column>
        <el-table-column prop="hallState" label="影厅状态">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.hallState" @change="hallStateChanged(scope.row)"></el-switch>
          </template>
        </el-table-column>
        <!--是否启用-->

        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改影厅信息" placement="top" :enterable="false" :open-delay="500">
              <el-button v-if="isCinemaOwner(scope.row.cinemaId)" type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.cinemaId, scope.row.hallId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除影厅" placement="top" :enterable="false" :open-delay="500">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteHallById(scope.row.cinemaId, scope.row.hallId)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="安排座位" placement="top" :enterable="false" :open-delay="500">
              <el-button v-if="isCinemaOwner(scope.row.cinemaId)" type="warning" icon="el-icon-setting" size="mini" @click="arrangeSeat(scope.row.cinemaId, scope.row.hallId)"></el-button>
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

    <!--添加影厅对话框-->
    <el-dialog title="添加影厅" :visible.sync="addDialogVisible" width="60%" @close="addDialogClosed">
      <!--内容主题区-->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <!--prop：在addFormRules中定义校验规则， v-model：双向绑定数据-->
        <el-form-item label="影院名称" prop="cinemaId">
          <el-input v-model="curCinemaName" disabled></el-input>
        </el-form-item>
        <el-form-item label="影厅编号" prop="hallId">
          <el-input v-model="addForm.hallId"></el-input>
        </el-form-item>
        <el-form-item label="影厅名称" prop="hallName">
          <el-input v-model="addForm.hallName"></el-input>
        </el-form-item>
        <el-form-item label="影厅分类编号" prop="hallCategoryId">
          <el-input v-model="addForm.hallCategoryId"></el-input>
        </el-form-item>
        <el-form-item label="起始排" prop="rowStart">
          <el-input v-model="addForm.rowStart"></el-input>
        </el-form-item>
        <el-form-item label="排数" prop="rowNums">
          <el-input v-model="addForm.rowNums"></el-input>
        </el-form-item>
        <el-form-item label="排座位数" prop="seatNumsRow">
          <el-input v-model="addForm.seatNumsRow"></el-input>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button @click="addDialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="addHall">确 定</el-button>
      </span>
    </el-dialog>

    <!--修改影厅对话框-->
    <el-dialog title="修改影厅" :visible.sync="editDialogVisible" width="60%" @close="editDialogClosed">
      <el-form :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
        <el-form-item label="影院名称" prop="cinemaId">
          <el-input v-model="curCinemaName" disabled></el-input>
        </el-form-item>
        <el-form-item label="影厅编号" prop="hallId">
          <el-input v-model="editForm.hallId" disabled></el-input>
        </el-form-item>
        <el-form-item label="影厅名称" prop="hallName">
          <el-input v-model="editForm.hallName"></el-input>
        </el-form-item>
        <el-form-item label="影厅分类编号" prop="hallCategoryId">
          <el-input v-model="editForm.hallCategoryId"></el-input>
        </el-form-item>
        <el-form-item label="起始排" prop="rowStart">
          <el-input v-model="editForm.rowStart"></el-input>
        </el-form-item>
        <el-form-item label="排数" prop="rowNums">
          <el-input v-model="editForm.rowNums"></el-input>
        </el-form-item>
        <el-form-item label="排座位数" prop="seatNumsRow">
          <el-input v-model="editForm.seatNumsRow"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editHallInfo">确 定</el-button>
      </span>
    </el-dialog>

    <!--安排座位对话框-->
    <el-dialog title="安排座位" :visible.sync="arrangeDialogVisible" :width="arrangeDialogWidth">
      <div style="display:flex; align-content: center">
        <span style="margin-right: 50px">启用</span>
        <span class="seat" :class="isSelected[0]"></span>
        <span style="margin: 0 50px">禁用</span>
        <span class="seat" :class="isSelected[1]"></span>
      </div>
      <br/>
      <div class="row" v-for="(value, key) in seats">
        <span style="margin-right: 100px">{{key}}</span>
        <div style="display: flex; justify-content: flex-end">
          <span class="seat" :class="isSelected[seats[key][index]]" @click="pressSeat(key, index)" v-for="(item, index) in value"></span>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="arrangeDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveSeat">确 定</el-button>
      </span>
    </el-dialog>


  </div>
</template>

<script>
import global from "@/assets/css/global.css"
export default {
  name: "HallInfo",
  data() {
    return {
      queryInfo: {
        cinemaId: '',
        hallCategoryId: '',
        hallState: '',
        pageNum: 1,
        pageSize: 7
      },
      hallList: [],
      total: 0,
      url: 'http://localhost:8181/',
      //控制对话框的显示与隐藏
      addDialogVisible: false,
      //添加影厅的表单数据
      addForm: {
        cinemaId: '',
        hallId: '',
        hallName: '',
        hallCategoryId: '',
        rowStart: '1',
        rowNums: 10,
        seatNumsRow: 10,
        seatNums: 100,
        seatState: '',
        hallState: false
      },
      //验证表单规则对象
      addFormRules: {
        hallId: [
          { required: true, message: '请输入影厅编号', trigger: 'blur' }
        ],
        hallName: [
          { required: true, message: '请输入影厅名称', trigger: 'blur' }
        ],
        hallCategoryId: [
          { required: true, message: '请输入影厅分类编号', trigger: 'blur' }
        ]
      },
      editDialogVisible: false,
      editForm: {},
      editFormRules: {
        hallId: [
          { required: true, message: '请输入影厅编号', trigger: 'blur' }
        ],
        hallName: [
          { required: true, message: '请输入影厅名称', trigger: 'blur' }
        ],
        hallCategoryId: [
          { required: true, message: '请输入影厅分类编号', trigger: 'blur' }
        ]
      },
      selectedCinemaId: '',
      selectedHallCategoryId: '',
      selectedHallState: '',
      cinemaList: [],
      hallCategoryList: [],
      states: [
        {
          id: 0,
          name: '未启用'
        },
        {
          id: 1,
          name: '已启用'
        }
      ],
      multipleSelection: [],
      arrangeDialogVisible: false,
      seats: {},
      isSelected: {
        0: 'seat-default',
        1: 'seat-choose'
      },
      editSeat: {},
      arrangeDialogWidth: '',
      loginUser: JSON.parse(window.sessionStorage.getItem('loginUser')),
      curCinemaName: ''
    }
  },
  created() {
    this.getHallList()
    this.getCinemaList()
    this.getHallCategoryList()
    this.curCinemaName = this.loginUser.cinemaName
  },
  methods: {
    getHallList() {
      this.queryInfo.cinemaId = this.selectedCinemaId
      //非系统管理员只能管理自己影院的影厅
      if(window.sessionStorage.getItem("btnPermission") === 'normal'){
        this.queryInfo.cinemaId = JSON.parse(window.sessionStorage.getItem('loginUser')).cinemaId
      }
      this.queryInfo.hallCategoryId = this.selectedHallCategoryId
      this.queryInfo.hallState = this.selectedHallState
      const _this = this;
      axios.get('sysHall', {params: _this.queryInfo}).then(resp => {
        console.log(resp)
        _this.hallList = resp.data.data;
        _this.total = resp.data.total;
        _this.queryInfo.pageSize = resp.data.pageSize;
        _this.queryInfo.pageNum = resp.data.pageNum;
      })
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getHallList()
      console.log(newSize)
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getHallList()
      console.log(newPage)
    },
    // 监听添加对话框的关闭事件
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
    },
    // 监听添加按钮
    addHall(){
      let row = this.addForm.rowNums
      let col = this.addForm.seatNumsRow
      this.$set(this.addForm, 'seatNums', row * col)
      let seat = {}
      for (let i = 0; i < row; i++) {
        let arr = []
        for (let j = 0; j < col; j++) {
          arr.push(0)
        }
        seat[isNaN(parseInt(this.addForm.rowStart)) ? String.fromCharCode(i + this.addForm.rowStart.charCodeAt(0)) : i + parseInt(this.addForm.rowStart)] = arr
      }
      this.$set(this.addForm, 'seatState', JSON.stringify(seat))

      const _this = this;
      this.$refs.addFormRef.validate(async valid => {
        console.log(valid)
        if (!valid) return
        //预校验成功，发网络请求
        //设置影院id为登录用户所属影院
        _this.addForm.cinemaId = _this.loginUser.cinemaId
        axios.defaults.headers.post['Content-Type'] = 'application/json'
        const {data : res } = await axios.post('sysHall', JSON.stringify(_this.addForm))
        if(res.code !== 200) return this.$message.error("添加影厅信息失败 " + res.msg)
        //隐藏添加对话框
        this.addDialogVisible = false
        //重新加载列表
        this.getHallList()
        this.$message.success('添加影厅信息成功！')
      })
    },
    // 显示修改对话框，回显数据
    showEditDialog(id1, id2){
      const _this = this
      axios.get('sysHall/' + id1 + '/' + id2 ).then(resp => {
        console.log(resp)
        _this.editForm = resp.data.data
      })
      this.editDialogVisible = true
    },
    // 监听修改对话框的关闭事件
    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
    },
    // 修改影厅分类信息并提交
    editHallInfo(){
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
        await axios.put('sysHall', JSON.stringify(_this.editForm)).then(resp => {
          if (resp.data.code !== 200){
            this.$message.error('修改影厅信息失败！')
            success = false
          }
        })
        if (!success) return
        this.editDialogVisible = false
        this.getHallList()
        this.$message.success('修改影厅信息成功！')
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
        let item = {
          cinemaId: data.cinemaId,
          hallId: data.hallId
        }
        ids.push(item)
      })
      console.log(ids)
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      await axios.post('sysHall/delete', JSON.stringify(ids)).then(resp => {
        if (resp.data.code !== 200){
          this.$message.success('批量删除影厅分类失败！')
        }
      })
      this.getHallList()
      this.$message.success('批量删除影厅分类成功！')
    },
    //根据id删除对应的影厅分类
    async deleteHallById(id1, id2){
      let deleteInfo = [{
        cinemaId: id1,
        hallId: id2
      }]
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

      console.log(deleteInfo)
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      await axios.post('sysHall/delete', JSON.stringify(deleteInfo)).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.success('删除影厅信息失败！')
        }
      })
      this.getHallList()
      this.$message.success('删除影厅信息成功！')
    },
    getCinemaList(){
      const _this = this;
      axios.get('sysCinema').then(resp => {
        console.log(resp)
        _this.cinemaList = resp.data.data;
      })
    },
    getHallCategoryList(){
      const _this = this;
      axios.get('sysHallCategory').then(resp => {
        console.log(resp)
        _this.hallCategoryList = resp.data.data;
      })
    },
    async hallStateChanged(hallInfo){
      const _this = this
      axios.defaults.headers.put['Content-Type'] = 'application/json'
      await axios.put('/sysHall', JSON.stringify(hallInfo)).then(resp => {
        if (resp.data.code !== 200){
          _this.$message.error('更新影厅状态失败！')
        }
      })
      this.getHallList()
      this.$message.success('更新影厅状态成功！')
    },
    async arrangeSeat(id1, id2){
      const _this = this
      await axios.get('sysHall/' + id1 + '/' + id2).then(resp => {
        _this.editSeat = resp.data.data
        _this.seats = JSON.parse(resp.data.data.seatState)
        console.log(resp)
      })
      console.log(this.seats)
      this.arrangeDialogWidth = 200 + this.editSeat.seatNumsRow * 40 + 'px'
      this.arrangeDialogVisible = true
    },
    pressSeat(key, idx){
      console.log( typeof this.seats[key][idx])
      this.$set(this.seats[key], idx, (this.seats[key][idx] == 0 ? 1 : 0))
    },
    async saveSeat(){
      this.editSeat.seatState = JSON.stringify(this.seats)
      console.log(this.editSeat)
      let totalSeats = 0
      for(let key in this.seats){
        for(let j = 0; j < this.seats[key].length; j++){
          if(this.seats[key][j] == 0){
            totalSeats++
          }
        }
      }

      this.$set(this.editSeat, 'seatNums', totalSeats)
      const _this = this
      axios.defaults.headers.put['Content-Type'] = 'application/json'
      await axios.put('sysHall', JSON.stringify(_this.editSeat)).then(resp => {
        if (resp.data.code !== 200){
          this.$message.error('安排座位失败！')
        }
      })
      this.arrangeDialogVisible = false
      this.getHallList()
      this.$message.success('安排座位成功！')
    },
    isCinemaOwner(cinemaId){
      return this.loginUser.cinemaId === cinemaId
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


</style>