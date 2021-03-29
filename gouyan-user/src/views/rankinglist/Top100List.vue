<template>
  <div>
    <div class="main">
      <div class="board" v-for="(item, index) in top100List">
        <div class="left">
          <i class="board-index">{{ index+1 + frontNum}}</i>
        </div>
        <div class="middle1">
          <a :href="'/movieInfo/' + item.movieId">
            <img :src="global.base + JSON.parse(item.moviePoster)[0]" :alt="item.movieNameCn">
          </a>
        </div>
        <div class="middle2">
          <a :href="'/movieInfo/' + item.movieId"><p class="name">{{ item.movieNameCn }}</p></a>
          <p class="star">主演：{{ subArr(item.majorActorNameList) }}</p>
          <p class="releaseTime">上映时间：{{ item.releaseDate.split(" ")[0] }}</p>
        </div>
        <div class="right">
          <p>{{ item.movieScore.toFixed(1) }}</p>
        </div>
      </div>
    </div>
    <div class="pageHelper">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryInfo.pageNum"
          :page-size="queryInfo.pageSize"
          background
          layout="prev, pager, next"
          :page-count="10"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  name: "Top100List",
  data(){
    return{
      queryInfo:{
        pageNum: 1,
        pageSize: 10,
      },
      top100List: [],
      total: 0,
      frontNum: 0
    }
  },
  created() {
    this.getTop100List()
    this.frontNum = (this.queryInfo.pageNum - 1) * this.queryInfo.pageSize
  },
  methods:{
    async getTop100List(){
      const {data: resp} = await axios.get('sysMovie/rankingList/4', {params: this.queryInfo})
      console.log(resp)
      if(resp.code != 200) return this.$message.error(resp.msg)
      this.top100List = resp.data
      this.total = resp.total
      this.queryInfo.pageSize = resp.pageSize
      this.queryInfo.pageNum = resp.pageNum
      this.frontNum = (this.queryInfo.pageNum - 1) * this.queryInfo.pageSize
    },
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize
      this.getTop100List()
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pageNum = newPage
      this.getTop100List()
    },
    subArr(item){
      let len = item.length
      return item.slice(0, Math.min(3, len)).join()
    }
  }
}
</script>

<style scoped>

.main{
  width: 950px;
  margin: 0 auto;
  margin-top: 70px;
}

.board{
  display: flex;
  margin: 25px 0;
}

.left{
  display: flex;
  align-items: center;
  margin-right: 25px;
}

.middle1{
  display: flex;
  align-items: center;
}

.middle2{
  display: flex;
  /*align-items: center;*/
  flex-direction: column;
  justify-content: center;
  margin-left: 25px;
  width: 300px;
}

.middle2 > a {
  color: #373d41;
  font-size: 26px;
  text-decoration: none;
}

.name, .star, .releaseTime{
  margin-top: 8px;
  margin-bottom: 8px;
}

.releaseTime{
  color: #999999;
}

.right{
  display: flex;
  font-size: 40px;
  font-weight: 700;
  font-style: italic;
  color: #ffb400;
  margin-left: 320px;
  align-items: center;
}

.board-index{
  background: #ffb400;
  color: #fff;
  display: inline-block;
  width: 50px;
  height: 50px;
  line-height: 50px;
  text-align: center;
  font-size: 18px;
  font-weight: 700;
  align-items: center;
}

img{
  width: 160px;
  height: 220px;
}

.pageHelper{
  display: flex;
  justify-content: center;
  margin: 40px 0px;
}

</style>