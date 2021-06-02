<template>
  <div>
    <div class="movie-list">
      <movie-item :movieItem="item" v-for="item in movieList" :key="item.movieId"></movie-item>
    </div>

    <div class="no-cinema" v-if="sorry">
      <p>抱歉，没有找到相关结果，请尝试用其他条件筛选。</p>
    </div>

    <div class="pageHelper">
      <el-pagination
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-size="pageSize"
          background
          layout="prev, pager, next"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import movieItem from '../../components/movie/movie-item'
import moment from 'moment'
export default {
  name: "MovieOngoing",
  components: {
    movieItem
  },
  props: {
    movieCategoryId: Number,
    orderByColumn: String
  },
  data() {
    return {
      total: 0,
      pageSize: 30,
      pageNum: 1,
      startDate: moment().subtract(30, "days").format("YYYY-MM-DD"),
      endDate: moment().format('YYYY-MM-DD'),
      movieList: [],
      sorry: false
    }
  },
  computed: {
    listenChange() {
      const {movieCategoryId, orderByColumn} = this
      return {movieCategoryId, orderByColumn}
    }
  },
  created() {
    this.getMovieList()
  },
  watch: {
    listenChange() {
      this.getMovieList()
    }
  },
  methods: {
    async getMovieList(){
      let queryInfo = {
        movieCategoryId: this.movieCategoryId,
        orderByColumn: this.orderByColumn,
        pageSize: this.pageSize,
        pageNum: this.pageNum,
        startDate: this.startDate,
        endDate: this.endDate,
        isAsc: 'desc'
      }
      const { data : res } = await axios.get('sysMovie/find', {params: queryInfo})
      this.movieList = res.data
      this.total = res.total
      this.sorry = this.movieList.length === 0;
    },
    handleCurrentChange(newPage) {
      this.pageNum = newPage
      this.getMovieList()
    }
  }
}
</script>

<style scoped>
.movie-list{
  display: flex;
  flex-wrap: wrap;
}

.pageHelper{
  display: flex;
  justify-content: center;
  margin: 40px 0px;
}

.no-cinema{
  display: flex;
  justify-content: center;
  margin-top: 40px;
  margin-bottom: 40px;
  font-size: 16px;
  color: #333;
}
</style>
