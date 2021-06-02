<template>
  <div>
    <div class="main">
      <div class="board" v-for="(item, index) in domesticBoxOfficeList">
        <div class="left">
          <i class="board-index">{{index+1}}</i>
        </div>
        <div class="middle1">
          <a :href="'/movieInfo/' + item.movieId">
            <img :src="global.base + JSON.parse(item.moviePoster)[0]" :alt="item.movieName">
          </a>
        </div>
        <div class="middle2">
          <a :href="'/movieInfo/' + item.movieId"><p class="name">{{ item.movieName }}</p></a>
          <p class="releaseTime">上映时间：{{ item.releaseDate.split(" ")[0] }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "DomesticBoxOfficeList",
  data(){
    return{
      queryInfo:{
        pageNum: 1,
        pageSize: 10,

      },
      domesticBoxOfficeList: []
    }
  },
  created() {
    this.getDomesticBoxOfficeList()
  },
  methods:{
    async getDomesticBoxOfficeList(){
      const {data: resp} = await axios.get('sysMovie/find/rankingList/2', {params: this.queryInfo})
      console.log(resp)
      if(resp.code !== 200) return this.$message.error(resp.msg)
      this.domesticBoxOfficeList = resp.data
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

</style>
