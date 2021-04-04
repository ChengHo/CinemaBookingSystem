<template>
  <div class="search-container">
    <!-- 搜索的一名演员 -->
    <div class="search-result" v-for="item in actorList" :key="item.actorId">
      <!-- 演员照片 -->
      <div class="img-container">
        <a :href="'/actor/' + item.actorId">
          <img :src="item.actorPhoto">
        </a>
      </div>
      <!-- 演员信息 -->
      <div class="movie-info">
        <div class="movie-name">{{item.actorName}}</div>
        <div class="movie-ename">{{item.actorNameEn}}</div>
        <div>{{item.actorNationality + (item.actorSchool === null ? '' : ' | ' + item.actorSchool)}}</div>
        <span class="movie-category">代表作: {{item.movieList}}</span>
      </div>
    </div>
  </div>
</template>

<script>
import pinyin from "pinyin";

export default {
  name: "SearchActor",
  props:{
    keyword: {
      type: String,
      default: ''
    }
  },
  data() {
    return{
      actorList: [
        {
          actorNameEn:'',
          movieList:[]
        }
      ]
    }
  },
  created() {
    this.getSearchActorList()
  },
  methods:{
    async getSearchActorList(){
      let queryInfo = {
        actorName: this.keyword
      }
      const { data : res } = await axios.get('sysActor', {params : queryInfo})
      if(res.code !== 200) return this.$message.error('获取信息失败')
      this.actorList = res.data
      for(let actor of this.actorList){
        const { data : resp } = await axios.get('sysActor/find/' + actor.actorId)
        actor.movieList = resp.data.movieList.map((obj, index) => {
          return obj.movieNameCn
        })
        actor.movieList = actor.movieList.slice(0, Math.min(3, actor.movieList.length))
        for(let idx in actor.movieList){
          actor.movieList[idx] = '《' + actor.movieList[idx] + '》'
        }
        actor.movieList = actor.movieList.join(' ')
        //生成英文名
        actor.actorNameEn = pinyin(actor.actorName, {
          heteronym: true,	//打开多音字
          style: pinyin.STYLE_NORMAL	//注音不加声调
        })
        let nameEn = ''
        for(let words of actor.actorNameEn){
          for(let word of words){
            nameEn = nameEn.concat(word.substring(0,1).toUpperCase() + word.substring(1) + ' ')
          }
        }
        actor.actorNameEn = nameEn.substring(0, nameEn.length - 1)
      }
      //处理数据
      for(let actor of this.actorList){
        actor.actorPhoto = this.global.base + JSON.parse(actor.actorPhoto)[0]
      }
    }
  },
  watch:{
    '$route'(){
      this.getSearchActorList()
    }
  }
}
</script>

<style scoped>
.search-container{
  width: 980px;
  margin: 0px auto;
  margin-bottom: 20px;
  display: flex;
  flex-wrap: wrap;
}

.search-result{
  width: 460px;
  margin: 30px 0 0 30px;
  display: flex;
}

.img-container{
  width: 160px;
  height: 220px;
  margin-right: 20px;
}

.img-container img{
  width: 100%;
  height: 100%;
}

a{
  text-decoration: none;
  cursor:pointer;
}

.movie-info{
  display: flex;
  flex-direction: column;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  margin-top: 5px;
  font-size: 16px;
  width: 280px;
  border-bottom: solid #eee 1px;
}

.movie-name{
  font-size: 26px;
  margin-top: 27px;
}

.movie-ename{
  font-size: 14px;
  color: #999;
  margin-top: 3px;
}

.movie-category{
  color: #333;
  white-space: normal;
  margin-top: 20px;
}
</style>