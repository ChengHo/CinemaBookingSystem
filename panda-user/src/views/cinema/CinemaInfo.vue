<template>
  <div>
    <div class="header">
      <div class="header-inner clearfix">
        <div class="movie-info-left">
          <div class="avatar-shadow">
            <el-image class="avatar" :src="cinemaInfo.cinemaPicture[0]" :preview-src-list="cinemaInfo.cinemaPicture"></el-image>
          </div>
        </div>
        <div class="movie-info-right">
          <div class="movie-info-msg">
            <h1 class="movie-name">{{cinemaInfo.cinemaName}}</h1>
            <div class="phone-number">{{cinemaInfo.cinemaAddress}}</div>
            <div class="phone-number">电话: {{cinemaInfo.user.phoneNumber}}</div>
            <div class="phone-number">{{cinemaInfo.sysCinemaArea.cinemaAreaName}} | {{cinemaInfo.sysCinemaBrand.cinemaBrandName}} | {{cinemaInfo.entryDate}} 入驻</div>
            <div style="margin: 25px 0;">影院服务 ————————————————————</div>
            <div class="service" v-if="cinemaInfo.isTicketChanged"><span class="service-tag">改签</span>未取票用户放映前60分钟可改签</div>
            <div class="service" v-if="cinemaInfo.isRefunded"><span class="service-tag">退票</span>未取票用户放映前60分钟可退票</div>
          </div>
        </div>
      </div>
    </div>

    <div class="movie-info-detail-container">
      <div class="movie-info-detail clearfix">
        <div class="main-content">
          <div class="crumbs-nav-container">
            <a href="/welcome">狗眼电影</a> &gt; <a href="/cinema">影院</a> &gt; {{cinemaInfo.cinemaName}}
          </div>
          <!-- 当前影院上映的所有电影 -->
          <div class="movie-list-container" v-if="cinemaInfo.sysMovieList !== null && cinemaInfo.sysMovieList.length !== 0">
            <span class="scroll-prev scroll-btn" @click="prevPage"></span>
            <span class="scroll-next scroll-btn" @click="nextPage"></span>
            <div class="movie-list" ref="movieListRef" :style="'left:' + left + 'px'">
              <div class="movie" v-for="item in cinemaInfo.sysMovieList" :key="item.movieId" :class="{active: item.movieId === activeMovie}" @click="activeMovie = item.movieId">
                <img :src="global.base + JSON.parse(item.moviePoster)[0]">
              </div>
            </div>
          </div>

          <!-- 当前选中电影信息 -->
          <div class="show-list" v-if="cinemaInfo.sysMovieList !== null && cinemaInfo.sysMovieList.length !== 0">
            <div class="show-movie-info">
              <div>
                <h2 class="show-movie-name">{{movieDict[activeMovie].movieNameCn}}</h2>
                <span class="show-movie-score sc">
                  {{ (movieDict[activeMovie].movieScore).toFixed(1)}}
                </span>
              </div>
              <!-- 电影描述 -->
              <div class="show-movie-desc">
                <div>
                  <span class="key">时长 : </span>
                  <span>{{movieDict[activeMovie].movieLength}}分钟</span>
                </div>
                <div>
                  <span class="key">类型 : </span>
                  <span>{{movieDict[activeMovie].movieCategoryList.join(' / ')}}</span>
                </div>
                <div>
                  <span class="key">主演 : </span>
                  <span>{{movieDict[activeMovie].majorActorNameList.join(' / ')}}</span>
                </div>
              </div>
            </div>
            <!-- 展示场次的日期 -->
            <div class="show-date" v-if="sessions !== null && sessions.length !== 0">
              <span>观影时间 :</span>
              <span class="date-item" :class="{active: activeDate === key}" @click="activeDate = key" v-for="(item, key) in sessionDict" :key="key">{{calculateDate(key)}}</span>
            </div>
            <div class="session-info">
              <el-table
                  :data="sessionDict[activeDate]"
                  stripe
                  style="width: 100%">
                <el-table-column
                    label="放映时间">
                  <template slot-scope="scope">
                    <span class="begin-time">{{scope.row.sysMovieRuntime.beginTime}}</span>
                    <br>
                    <span class="end-time">{{scope.row.sysMovieRuntime.endTime}}散场</span>
                  </template>
                </el-table-column>
                <el-table-column
                    prop="languageVersion"
                    label="语言版本">
                </el-table-column>
                <el-table-column
                    label="放映厅">
                  <template slot-scope="scope">
                    {{scope.row.sysHall.hallName + (scope.row.sessionTips === null ? '' : scope.row.sessionTips)}}
                  </template>
                </el-table-column>
                <el-table-column
                    label="售价">
                  <template slot-scope="scope">
                    <span class="sell-price"><span class="stonefont">{{scope.row.sessionPrice}}</span></span>
                  </template>
                </el-table-column>
                <el-table-column
                    label="选座购票">
                  <template slot-scope="scope">
                    <el-button type="primary" round @click="toChooseSeat(scope.row.sessionId)">选座购票</el-button>
                  </template>
                </el-table-column>
              </el-table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
export default {
  name: "CinemaInfo",
  data() {
    return {
      cinemaId: this.$route.params.cinemaId,
      cinemaInfo: {
        user: {},
        sysCinemaArea: {},
        sysCinemaBrand: {},
        cinemaPicture: [],
        sysMovieList: []
      },
      //用于获取指定id的电影信息
      movieDict: {0:{
          actorRoleList: [],
          majorActorNameList: [],
          movieAgeId: 0,
          movieAreaId: 0,
          movieBoxOffice: 0,
          movieCategoryList: [],
          movieCommentList: [],
          movieId: 0,
          movieIntroduction: '',
          movieLength: 0,
          movieNameCn: '',
          movieNameEn: '',
          moviePictures: '',
          moviePoster: '',
          movieRateNum: 0,
          movieScore: 0,
          releaseDate: '',
          sysMovieAge: null,
          sysMovieArea: null
        }},
      sessionDict:{},
      sessions: [],
      activeMovie: 0,
      activeDate: '',
      left: 0,
      movieListWidth: 0
    }
  },
  watch:{
    'activeMovie'(){
      this.getNewSessionList()
    }
  },
  created() {
    this.getCinemaMovieList()
  },
  methods:{
    async getCinemaMovieList(){
      const { data : res} = await axios.get('sysCinema/find/' + this.cinemaId)
      this.cinemaInfo = res.data.cinema
      this.sessions = res.data.sessions
      //解析图片
      this.cinemaInfo.cinemaPicture = (JSON.parse(this.cinemaInfo.cinemaPicture)).map((obj, index) => {
        return this.global.base + obj
      })
      if(this.sessions !== null)
        this.activeMovie = this.sessions[0].movieId
      if(this.sessions === null){
        this.sessions = []
      }

      for(let movie of this.cinemaInfo.sysMovieList) {
        movie.movieCategoryList = movie.movieCategoryList.map((obj, index) => {
          return obj.movieCategoryName
        })
        movie.majorActorNameList = movie.majorActorNameList.slice(0, Math.min(3, movie.majorActorNameList.length))
        this.movieDict[movie.movieId] = movie
      }

      //处理场次数据，按日期分组
      for(let session of this.sessions){
        if(this.sessionDict[session.sessionDate] === undefined)
          this.sessionDict[session.sessionDate] = []
        this.sessionDict[session.sessionDate].push(session)
      }
      this.activeDate = this.sessions.length === 0 ? '': this.sessions[0].sessionDate
    },
    async getNewSessionList(){
      const { data : res} = await axios.get('sysCinema/find/' + this.cinemaId + '/' + this.activeMovie)
      if(res.code !== 200) return this.$message.error('获取信息失败')
      this.sessions = res.data.sessions
      //处理场次数据，按日期分组
      this.sessionDict = {}
      for(let session of this.sessions){
        if(this.sessionDict[session.sessionDate] === undefined)
          this.sessionDict[session.sessionDate] = []
        this.sessionDict[session.sessionDate].push(session)
      }
      this.activeDate = this.sessions.length === 0 ? '': this.sessions[0].sessionDate
    },
    prevPage(){
      let tmp = window.getComputedStyle(this.$refs.movieListRef).width
      this.movieListWidth = Number.parseInt(tmp.substring(0, tmp.length - 2))
      if(this.left < 0)
      this.left += 1200
    },
    nextPage(){
      let tmp = window.getComputedStyle(this.$refs.movieListRef).width
      this.movieListWidth = Number.parseInt(tmp.substring(0, tmp.length - 2))
      if(this.movieListWidth + this.left - 1200 > 0) {
        this.left -= 1200
      }
    },
    toChooseSeat(sessionId){
      this.$router.push('/ChooseSeat/' + sessionId)
    },
    calculateDate(date){
      return moment(date).format('YYYY年MM月DD日')
    }
  }
}
</script>

<style scoped>
a{
  text-decoration: none;
  cursor:pointer;
}

.header{
  padding: 0;
  width: 100%;
  min-width: 1200px;
  background: url('../../assets/movie-info-background.jpg')
}

.header-inner{
  width: 1200px;
  margin: 0 auto;
  position: relative;
}

.clearfix::before, .clearfix::after{
  content: " ";
  display: table;
}

.clearfix::after{
  clear: both;
}

.movie-info-left{
  width: 360px;
  float: left;
  position: relative;
  top: 49px;
  overflow: hidden;
  z-index: 9;
}

.movie-info-left .avatar-shadow {
  width: 300px;
  height: 300px;
  background-size: 300px 50px;
  position: relative;
}

.avatar-shadow{
  position: relative;
  margin: 0 30px;
  width: 240px;
  height: 330px;
  padding-bottom: 40px;
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPAAAAAyAgMAAAAfG76+AAAADFBMVEUAAAAAAAAAAAAAAAA16TeWAAAABHRSTlMOAgoGQ0SIeAAAADpJREFUSMdjGAWjYBRgAasoAAwdFACKbB7VPEI076YAUGbzfwrAqOYRormcAjCANodSAEY1j2oexJoBlx1+yE7RXIIAAAAASUVORK5CYII=) no-repeat bottom;
}

.avatar{
  border: 4px solid #fff;
  height: 300px;
  width: 300px;
}

.movie-info-msg{
  position: absolute;
  color: #fff;
  font-size: 14px;
  z-index: 1;
}

.movie-name{
  width: 900px;
  margin-top: 0;
  font-size: 26px;
  line-height: 32px;
  font-weight: 700;
  margin-bottom: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  max-height: 64px;
}

.phone-number{
  font-size: 14px;
  width: 340px;
  line-height: 1.3;
  margin: 5px 0;
}

.movie-info-msg .phone-number:last-child{
  margin-bottom: 14px;
}

ul{
  width: 250px;
  list-style: none;
  padding-left: 0;
  margin-bottom: 20px;
}

ul li{
  margin: 12px 0;
  line-height: 100%;
}

.movie-info-right{
  height: 300px;
  position: relative;
  margin-right: 30px;
  margin-left: 380px;
  margin-top: 40px;
}

.service{
  font-size: 12px;
  margin-bottom: 5px;
}

.service-tag{
  padding: 0 10px;
  margin:0 20px;
  border: 1px solid #EEEEEE;
}

.movie-info-detail-container{
  width:1200px;
  margin: 0 auto;
}

.movie-info-detail{
  margin-top: 80px;
  display: flex;
}

.main-content {
  width: 1200px;
  margin: 20px auto;
}

.crumbs-nav-container {
  margin-bottom: 25px;
  color: #333;
}

.crumbs-nav-container a{
  color: inherit;
}

.movie-list-container {
  height: 280px;
  padding: 22px 5px;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  overflow: hidden;
  -webkit-box-shadow: inset 0 0 100px 80px #ededed;
  box-shadow: inset 0 0 100px 80px #ededed;
  position: relative;
}

.movie-list-container .movie-list {
  white-space: nowrap;
  position: relative;
  display: table;
  left: 0;
  -webkit-transition: left .2s ease;
  transition: left .2s ease;
}

.movie-list-container .movie {
  width: 162px;
  height: 227px;
  border: 4px solid #fff;
  -webkit-box-shadow: 0 1px 3px 0 hsla(0,0%,66%,.5);
  box-shadow: 0 1px 3px 0 hsla(0,0%,66%,.5);
  display: inline-block;
  -webkit-transform-origin: 50%;
  -ms-transform-origin: 50%;
  transform-origin: 50%;
  -webkit-transform: scale(.82);
  -ms-transform: scale(.82);
  transform: scale(.82);
  -webkit-transition: -webkit-transform .1s;
  transition: -webkit-transform .1s;
  transition: transform .1s;
  transition: transform .1s,-webkit-transform .1s;
  word-spacing: 0;
}

.movie-list-container .movie.active {
  -webkit-transform: scale(1);
  -ms-transform: scale(1);
  transform: scale(1);
  border-color: #f24030;
}

.movie-list-container .movie img {
  width: 100%;
  height: 100%;
}

.movie-list-container .scroll-prev {
  z-index: 10;
  left: 0;
  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAxCAYAAADNyhlBAAAAAXNSR0IArs4c6QAAArhJREFUWAnF2M9rE0EUB3CjVkNRrJqoLSr+uHj0fxAUFYuIWERERPBi/7J6yCFgSEIOCQmBxCSaoLRGWtRjaav57Uqyft/aKWs2k4nZ1+fAsNOd3fn0bXZ33k7gwP6UgGtY1bZ39znbw64DuJoEUT3oqoQNUPuoVGzq5CwKPYRBj6DORiKRa71eL2Lb9uZgMFjr9/uv0FZXgcVWUc5gtGOop2Ox2A1gW4CGyzKLiEEUSlESGopGozeBbg+Lu3/XOWAPikhvAd3RoLR7xy/sQROJxB2g38eg1LXiB/agyWTyLtAfBvQb+hemhT1oKpW6B7RhQL+i/ypQOv+fiwdNp9OLQJsG9AseqyvQfKPHMUgok8ncB9oyoBvdbvcyG5rNZh8AbRvQdaCX2NBcLvcQaMeAfgZ6kQsN5/P5RxOg9U6nc4ENLRQKS0C7hkjXgJ5nQ4vF4mOAJnS13W7Tc8py94ZLpdIToD1DpB+BzrOh5XL56QToh1ardY4NrVQqz4D+NERaA3qWDa1Wq88BWgb0fbPZPMOG1mq1FxOg7xqNRogNRaQvgf4yRFpG/6lpUZzn3PaU9DmZA717J0Df4piTflCCKeE7ijqHOo8ZhCIZVwropGOnek5x3l4hOIhKl20Bb6VxM43l54W/J6Kh0luV99qWZX1yHzDUngkGgyuI+AT2+46YBvgvvzHBFDmlpjS5h6XualjOZfsLl3iOCaYyKvJ9f3P9oUfgEu9qLS4xO2lxiflYi0tkIFpcIufS4hJZpg4PSeTVWlziS0KLS3w7jcKd5EHia1GLS3wfa3GJFQEtHo/HbyOLMa2BvFYD+Nm6ZzXnN5dY9VH/sAeXWOcaxkVX9kbhs9g5h7XM60iZ3yBBpN+9jrXMZWwDdIm4C42pLj2lU1RVFkurt9TmXUXFgKq4A1JtAqk429/9SruXxl7sIQAAAABJRU5ErkJggg==);
}

.movie-list-container .scroll-btn {
  z-index: 8;
  display: inline-block;
  position: absolute;
  width: 30px;
  height: 100%;
  top: 0;
  background-repeat: no-repeat;
  background-position: 50%;
}

.movie-list-container .scroll-next {
  right: 0;
  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAxCAYAAADNyhlBAAAAAXNSR0IArs4c6QAAAqVJREFUWAnFmF1rE0EUhjvxoyKKta0fLSpWb3rpfxAUEUVEFBEREbzRX6YXXgQMIeQiISGQmEQTFL+wVC9FW5NNNkaS+BzMtFvYdaA7u3vgZU522Xl2NzvnnDlqZtvU1NXjZPvUjNf3HN69u9cDE+AelELijz3CtQtPTSYTNRqNnjB+QN8Hg8ELbBXQQbQfyc3Ijeg3gWvBgD1FO2w8Hv/IZDIXmX4BHUL7kH4TuBYM4ucd1OkP4D/T6fQlEItI4PL09uBwNvzAcgz4Bk9+ORI48z8PAk/hm9ls9op1OJMvo28G+K9cLnfVNlwBPY++GuCdfD5/zTqcZXQO8LoB3i0UCtetw13XXQG8ZoA7xWLxxhR+mNHK166AnwX8xQDvlUqlm1HAzwD2Xd/6hlhq/XK5fMs6vN/vnwbySYP8RoFXKpXbwI8he68d+CmAEsMDDbhbrVbvWIf3ej1Z5+8Dyf9OuLVa7W4U8CXmf2eAD+r1+j3rcMdxTgJ+a4I3Go37UcBPAG4b4L+bzeYD6/But3sc8BsDfNhqtR5ah3c6nUXAr03wdrv9yDoc6DxqGOB/ePLHUcCPAn5lgntiu1QyUmCGrt8kpc6h6v/gZL4GsCU0h2aRlFChTSeWYRCc6OZAWUbz6ABK6boaf1cmT3yEK58hqUR9bTgcfuSEbAqkVg+9ORBo7P+xQGP/qlUS61glEbkUiSL2WC3Q2LOTohiIPR8LNPYKRCVRcwk09ipTYm/sdbUO+LHuJAS6QihcQ4EmmcaTX0MX8YqcKVvV9UAiJ4Ba3S1KwI9/fww0mY4A4MR6IIl1fXz3wXxIkfe5EuvsSS9T4LIJ32RZvaSXeYGiTEpR6WfabycyqS6sZRQFdW+lMgxdHTLHlmmwHNC+Hr0gr791cRjnL3/vu4SC/ROyAAAAAElFTkSuQmCC);
}

.show-movie-info{
  margin-top: 20px;
  border-bottom: 1px solid #e5e5e5;
}

.show-movie-info .show-movie-name{
  display: inline-block;
  margin: 0 20px 20px 0;
  font-size: 26px;
  font-weight: 400;
  color: #333;
}

.show-movie-score{
  display: inline-block;
  font-size: 24px;
  color: #faaf00;
}

.show-movie-info .sc::after{
  content: "\5206";
  font-size: 12px;
}

.show-movie-desc>div{
  display: inline-block;
  font-size: 14px;
  color: #151515;
  margin-bottom: 20px;
  margin-right: 40px;
}

.show-movie-desc .key{
  color: #999;
}

.show-list .show-date{
  padding: 30px 0;
  font-size: 14px;
  color: #999;
}

.show-list .show-date .date-item {
  display: inline-block;
  background-color: transparent;
  border-radius: 100px;
  color: #333;
  padding: 2px 10px;
  margin-left: 12px;
  cursor: default;
}

.show-list .show-date .date-item.active {
  color: #fff;
  background-color: #409EFF;
}

.sell-price{
  font-size: 18px;
  color: #f03d37;
  font-weight: 700;
}

.sell-price:before {
  content: "\FFE5";
  font-size: 12px;
}

.show-list .begin-time {
  font-size: 18px;
  color: #333;
  font-weight: 700;
}

.show-list .end-time{
  font-size: 12px;
  color: #999;
}

.session-info>>>tr{
  height: 82px;
}

.session-info>>>td{
  text-align: center;
  width: 20%;
}
</style>