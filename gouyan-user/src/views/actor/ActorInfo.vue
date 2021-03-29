<template>
  <div class="actor-container">
    <div class="header">
      <div class="header-inner clearfix">
        <div class="movie-info-left">
          <div class="avatar-shadow">
            <img class="avatar" :src="actorInfo.actorPhoto">
          </div>
        </div>
        <div class="movie-info-right">
          <div class="movie-info-msg">
            <h1 class="movie-name">{{actorInfo.actorName}}</h1>
            <div class="movie-ename">{{actorInfo.actorNameEn}}</div>
            <ul>
              <li>{{actorInfo.actorRoleList.join(' | ') + (actorInfo.actorAge ? ' | ' + actorInfo.actorAge + '岁' : '') + (actorInfo.actorHeight ? ' | ' + actorInfo.actorHeight.toFixed(0) + 'cm' : '')}}</li>
            </ul>
          </div>
          <div class="major-movie">
            <div>代表作</div>
            <div class="major-movie-list">
              <img :src="global.base + item.moviePoster" v-for="item in actorInfo.movieList.slice(0, Math.min(3, actorInfo.movieList.length))" :key="item.movieId">
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="movie-info-detail-container">
      <div class="movie-info-detail clearfix">
        <div class="main-content">
          <div class="crumbs-nav-container">
            <a href="/welcome">狗眼电影</a> &gt; <a href="/movie">电影</a> &gt; {{actorInfo.actorName}}
          </div>
          <div class="module">
            <div class="mod-title">
              <h2>介绍</h2>
            </div>
            <div class="mod-content">
              <span class="dra">
                {{actorInfo.actorInformation}}
              </span>
            </div>
            <!-- 详细信息 -->
            <div class="actorInfo-list">
              <dl class="dl-left">
                <dt class="basicInfo-item name">别&nbsp;&nbsp;&nbsp;&nbsp;名</dt>
                <dd class="basicInfo-item value">{{actorInfo.actorNameEn}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorAge">年&nbsp;&nbsp;&nbsp;&nbsp;龄</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorAge">{{actorInfo.actorAge}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorNationality">出生地</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorNationality">{{actorInfo.actorNationality}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorRoleList">身&nbsp;&nbsp;&nbsp;&nbsp;份</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorRoleList">{{actorInfo.actorRoleList.join(' | ')}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorGender">性&nbsp;&nbsp;&nbsp;&nbsp;别</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorGender">{{actorInfo.actorGender? '男' : '女'}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorNationality">国&nbsp;&nbsp;&nbsp;&nbsp;籍</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorNationality">{{actorInfo.actorNationality}}</dd>
              </dl>
              <dl class="dl-right">
                <dt class="basicInfo-item name" v-if="actorInfo.actionNation">民&nbsp;&nbsp;&nbsp;&nbsp;族</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actionNation">{{actorInfo.actorNation}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorBloodType">血&nbsp;&nbsp;&nbsp;&nbsp;型</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorBloodType">{{actorInfo.actorBloodType}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorHeight">身&nbsp;&nbsp;&nbsp;&nbsp;高</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorHeight">{{actorInfo.actorHeight ? actorInfo.actorHeight + 'cm': ''}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorConstellation">星&nbsp;&nbsp;&nbsp;&nbsp;座</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorConstellation">{{actorInfo.actorConstellation}}</dd>
                <dt class="basicInfo-item name" v-if="actorInfo.actorSchool">毕业学校</dt>
                <dd class="basicInfo-item value" v-if="actorInfo.actorSchool">{{actorInfo.actorSchool}}</dd>
              </dl>
            </div>
          </div>

          <div class="module">
            <div class="mod-title">
              <h2>作品</h2>
            </div>
            <div class="mod-content">
              <movie-item v-for="item in actorInfo.movieList" :movieItem="item" :key="item.movieId" class="movie-item-style"></movie-item>
            </div>
          </div>
        </div>

        <!-- 相关影人 -->
        <div class="aside">
          <div class="relationship">
            <div class="module">
              <div class="mod-title">
                <h2>相关影人</h2>
              </div>
              <div class="mod-content relational-actors">
                <div class="relational-actor" v-for="item in relationshipList" :key="item.actorId">
                  <a @click="toRelationalActor(item.actorId)">
                    <el-image :src="item.actorPhoto" class="relational-actor-photo">
                    </el-image>
                  </a>
                  <a @click="toRelationalActor(item.actorId)">
                    <span>{{item.actorName}}</span>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import pinyin from 'pinyin'
import movieItem from '../../components/movie/movie-item'
export default {
  name: "ActorInfo",
  components:{
    movieItem
  },
  data() {
    return {
      actorId: this.$route.params.actorId,
      actorInfo: {
        actorNameEn: '',
        movieList: [],
        actorRoleList: []
      },
      majorMovieList:[],
      relationshipList: []
    }
  },
  created() {
    this.getActorInfo()
    this.getRelationship()
  },
  watch:{
    '$route'(){
      this.actorId = this.$route.params.actorId
    },
    'actorId'(){
      this.getActorInfo()
      this.getRelationship()
    }
  },
  methods:{
    async getActorInfo(){
      const { data: res} = await axios.get('sysActor/find/' + this.actorId)
      this.actorInfo = res.data
      this.actorInfo.actorRoleList = []
      //将演员的角色信息添加到角色列表里
      for(let movie of this.actorInfo.movieList){
        this.actorInfo.actorRoleList.push(movie.actorRoleList[0].actorRoleName)
      }
      //去重
      this.actorInfo.actorRoleList = Array.from(new Set(this.actorInfo.actorRoleList))
      //处理演员照片
      this.actorInfo.actorPhoto = this.global.base + JSON.parse(this.actorInfo.actorPhoto)[0]
      this.actorInfo.actorNameEn = pinyin(this.actorInfo.actorName, {
        heteronym: true,	//打开多音字
        style: pinyin.STYLE_NORMAL	//注音不加声调
      })
      let nameEn = ''
      for(let words of this.actorInfo.actorNameEn){
        for(let word of words){
          nameEn = nameEn.concat(word.substring(0,1).toUpperCase() + word.substring(1) + ' ')
        }
      }
      this.actorInfo.actorNameEn = nameEn.substring(0, nameEn.length - 1)
    },
    async getRelationship() {
      let queryInfo = {
        pageSize: 9,
        pageNum: 1
      }
      const {data: res} = await axios.get('sysActor', {params: queryInfo})
      this.relationshipList = res.data
      //取出图片路径
      for(let actor of this.relationshipList){
        actor.actorPhoto = this.global.base + JSON.parse(actor.actorPhoto)[0]
      }
    },
    toRelationalActor(actorId) {
      this.$router.push('/actor/' + actorId)
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
  width: 300px;
  height: 370px;
  float: left;
  position: relative;
  top: 70px;
  overflow: hidden;
  z-index: 9;
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
  height: 322px;
  width: 232px;
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

.movie-ename{
  width: 340px;
  font-size: 18px;
  line-height: 1.3;
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
  margin-left: 300px;
  margin-top: 70px;
}

.major-movie{
  color: #FFFFFF;
  position: absolute;
  bottom: 20px;
}

.major-movie-list{
  display: flex;
  margin-top: 10px;
}

.major-movie-list img{
  width: 100px;
  height: 138px;
  margin-right: 10px;
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
  width: 730px;
  float: left;
  margin-bottom: 20px;
}

.crumbs-nav-container {
  margin-bottom: 25px;
  color: #333;
}

.crumbs-nav-container a{
  color: inherit;
}

.module{
  position: relative;
  margin-bottom: 60px;
}

.mod-title h2{
  display: inline-block;
  margin: 0;
  padding: 0;
  font-weight: 400;
  font-size: 18px;
  color: #333;
  line-height: 18px;
}

.mod-title h2:before {
  float: left;
  content: "";
  display: inline-block;
  width: 4px;
  height: 18px;
  margin-right: 6px;
  background-color: #409EFF;
}

.mod-content{
  margin-top: 20px;
  color: #333;
}

.mod-content .dra{
  font-size: 14px;
  line-height: 26px;
}

.actorInfo-list{
  margin-top: 20px;
  overflow: hidden;
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAiAQMAAABCyuoWAAAABlBMVEUAAAAAAAClZ7nPAAAAAnRSTlMAGovxNEIAAAAMSURBVAjXY6AcHAAAAQQAwWwcvxcAAAAASUVORK5CYII=) repeat;
}

.actorInfo-list dl{
  margin: 0;
  padding: 0;
  width: 50%;
  display: inline-block;
  float: left;
  margin-bottom: -1px;
}

.basicInfo-item{
  line-height: 34px;
  font-size: 14px;
}

.basicInfo-item.name {
  float: left;
  width: 96px;
  color: #999;
}

.basicInfo-item.value {
  margin-left: 90px;
}

.movie-item-style{
  margin-left: 0;
  margin-right:20px;
}

.aside{
  margin-left: 100px;
  width: 360px;
}

.relational-actors{
  display: flex;
  flex-wrap: wrap;
}

.relational-actor{
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-right: 30px;
  margin-top: 10px;
}

.relational-actor-photo{
  width: 80px;
  border-radius: 10px;
}
</style>