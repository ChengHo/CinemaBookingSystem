<template>
  <div class="movie-container">
    <div class="header">
      <div class="header-inner clearfix">
        <div class="movie-info-left">
          <div class="avatar-shadow">
            <img class="avatar" :src="movieInfo.moviePoster">
          </div>
        </div>
        <div class="movie-info-right">
          <div class="movie-info-msg">
            <h1 class="movie-name">{{movieInfo.movieNameCn}}</h1>
            <div class="movie-ename">{{movieInfo.movieNameEn}}</div>
            <ul>
              <li>{{movieInfo.movieCategoryList}}</li>
              <li>{{movieInfo.sysMovieArea.movieAreaName}} / {{movieInfo.movieLength}}分钟</li>
              <li>{{movieInfo.releaseDate}} {{movieInfo.sysMovieArea.movieAreaName}}上映</li>
            </ul>
          </div>
          <div class="movie-info-btn">
            <el-button class="buy-btn" type="primary" @click="toCinema">特惠购票</el-button>
          </div>
          <div class="movie-info-score">
            <div class="movie-index">
              <span class="movie-index-title">狗眼口碑</span>
              <div style="display: flex">
                <span class="movie-score-num">{{movieInfo.movieScore}}</span>
                <div class="score-container">
                  <el-rate
                      :value="movieInfo.movieScore/2"
                      allow-half
                      disabled
                      text-color="#ff9900">
                  </el-rate>
                  <span>{{movieInfo.movieRateNum}}人评分</span>
                </div>
              </div>
            </div>
            <div class="movie-index box-office-container">
              <span class="movie-index-title">累计票房</span>
              <div style="display: flex;align-items: flex-end;">
                <span class="box-office">{{movieInfo.movieBoxOffice}}</span>
                <span class="unit">元</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="movie-info-detail-container">
      <div class="movie-info-detail clearfix">
        <div class="main-content">
          <div class="crumbs-nav-container">
            <a href="/welcome">狗眼电影</a> &gt; <a href="/movie">电影</a> &gt; {{movieInfo.movieNameCn}}
          </div>
          <el-tabs v-model="activeName">
            <el-tab-pane label="介绍" name="introduction">
              <div class="tab-body">
                <!-- 剧情简介 -->
                <div class="module">
                  <div class="mod-title">
                    <h2>剧情简介</h2>
                  </div>
                  <div class="mod-content">
                    <span class="dra">
                      {{movieInfo.movieIntroduction}}
                    </span>
                  </div>
                </div>
                <!-- 演职人员 -->
                <div class="module">
                  <div class="mod-title">
                    <h2>演职人员</h2>
                    <a class="more" @click="showActors">全部</a>
                  </div>
                  <div class="mod-content">
                    <div class="actors-container">
                      <div class="actors-group" v-for="item in movieInfo.actorRoleList">
                        <div class="actors-type">
                          {{item.actorRoleName}}
                        </div>
                        <div class="actors-list clearfix">
                          <div class="actor" v-for="actor in item.actorList">
                            <a @click="toActor(actor.actorId)" target="_blank" class="portrait">
                              <img class="default-img" :alt="actor.actorName" :src="httpURL + JSON.parse(actor.actorPhoto)[0]">
                            </a>
                            <div class="info">
                              <a @click="toActor(actor.actorId)" target="_blank" class="actor-name">
                                {{actor.actorName}}
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 图集 -->
                <div class="module">
                  <div class="mod-title">
                    <h2>图集</h2>
                    <a class="more" @click="showPictures">全部</a>
                  </div>
                  <div class="mod-content">
                    <div class="pictures-list">
                      <div v-if="movieInfo.moviePictures.length == 0">
                        暂无图片资源
                      </div>
                      <el-image
                          class="default-img"
                          :src="movieInfo.moviePictures[0]"
                          :preview-src-list="movieInfo.moviePictures"
                          v-if="movieInfo.moviePictures.length > 0">
                      </el-image>
                      <div class="little-pictures">
                        <el-image
                            class="default-img"
                            v-for="(item,index) in movieInfo.moviePictures.slice(1)"
                            :key="index"
                            :src="item"
                            :preview-src-list="movieInfo.moviePictures">
                        </el-image>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 热门短评 -->
                <div class="module">
                  <div class="mod-title">
                    <h2>热门短评</h2>
                    <el-button @click="writeCommentDialogVisible = true" style="float: right" type="primary" size="medium" plain round>写短评</el-button>
                  </div>
                  <div class="mod-content">
                    <div class="comment-container" v-for="item in movieInfo.movieCommentList">
                      <div>
                        <!-- 头像 -->
                        <el-avatar :src="item.sysUser.userPicture"
                                   class="user-avatar">
                        </el-avatar>
                      </div>
                      <!-- 用户名、评分、评论内容 -->
                      <div class="comment-main">
                        <div class="main-header">
                          <div class="user-name">{{item.sysUser.userName}}</div>
                          <div class="comment-date">
                            {{item.commentTime}}
                            <el-rate style="margin-left: 10px;" :value="item.score/2" allow-half disabled></el-rate>
                          </div>
                        </div>
                        <div class="comment-content">
                          {{item.content}}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </el-tab-pane>
            <el-tab-pane label="演职人员" name="actors">
              <div class="tab-body">
                <div class="actors-container">
                  <div class="actors-group" v-for="item in movieInfo.actorRoleList">
                    <div class="actors-type">
                      {{item.actorRoleName}}
                    </div>
                    <div class="actors-list clearfix">
                      <div class="actor" v-for="actor in item.actorList">
                        <a @click="toActor(actor.actorId)" target="_blank" class="portrait">
                          <img class="default-img" :alt="actor.actorName" :src="httpURL + JSON.parse(actor.actorPhoto)[0]">
                        </a>
                        <div class="info">
                          <a @click="toActor(actor.actorId)" target="_blank" class="actor-name">
                            {{actor.actorName}}
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </el-tab-pane>
            <el-tab-pane label="图集" name="pictures">
              <div class="tab-body">
                <div class="pictures-list">
                  <div class="little-pictures">
                    <div v-if="movieInfo.moviePictures.length == 0">
                      暂无图片资源
                    </div>
                    <el-image
                        fit="cover"
                        class="default-img"
                        v-for="(item,index) in movieInfo.moviePictures"
                        :key="index"
                        :src="item"
                        :preview-src-list="movieInfo.moviePictures">
                    </el-image>
                  </div>
                </div>
              </div>
            </el-tab-pane>
          </el-tabs>
        </div>
      </div>
    </div>

    <!--写影评对话框-->
    <el-dialog :visible.sync="writeCommentDialogVisible" width="40%" @close="writeCommentDialogClosed">
      <!--内容主题区-->
      <el-form class="write-comment-dialog" :model="commentForm" :rules="commentFormRules" ref="commentFormRef" label-width="0">
        <el-form-item class="comment-score-container" prop="score">
          <span class="movie-score-num">{{ (commentForm.score * 2).toFixed(1)}}</span>
        </el-form-item>
        <el-form-item prop="score">
          <el-rate :colors="colors" v-model="commentForm.score" allow-half></el-rate>
        </el-form-item>
        <el-form-item style="width: 80%" prop="content">
          <el-input type="textarea" :rows="5" style="font-size: 16px;" placeholder="快来说说你的想法吧" v-model="commentForm.content"></el-input>
        </el-form-item>
      </el-form>
      <!--底部区域-->
      <span slot="footer" class="dialog-footer">
      <el-button type="primary" @click="submitComment">提交</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import movieItem from './../../components/movie/movie-item';
import moment from 'moment'
export default {
  name: "MovieInfo",
  components:{
    movieItem
  },
  data() {
    return {
      movieInfo: {
        sysMovieArea:{},
        sysMovieAge:{},
        moviePictures: [],
        movieCommentList: [],
        actorRoleList: []
      },
      movieId: this.$route.params.movieId,
      activeName: 'introduction',
      writeCommentDialogVisible: false,
      commentForm: {
        score: 0,
        content: '',
        userId: 0,
        movieId: 0,
        commentTime: null
      },
      commentFormRules:{
        content:[
          { required: true, message: '请输入评论内容', trigger: 'blur' }
        ]
      },
      colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
      httpURL: this.global.base
    }
  },
  created(){
    this.getMovieInfo()
  },
  methods:{
    async getMovieInfo(){
      const _this = this
      const {data : res} = await axios.get('sysMovie/find/' + this.movieId)
      if(res.code !== 200) return this.$message.error('数据查询失败')
      this.movieInfo = res.data
      this.movieInfo.moviePoster = this.httpURL + JSON.parse(res.data.moviePoster)[0]
      this.movieInfo.moviePictures = JSON.parse(this.movieInfo.moviePictures).map((obj, index) => {
        return this.httpURL + obj
      })
      this.movieInfo.movieCategoryList = this.movieInfo.movieCategoryList.map((obj,index) => {
        return obj.movieCategoryName;
      }).join(" ")
      this.movieInfo.movieCommentList = this.movieInfo.movieCommentList.slice(0, Math.min(10, this.movieInfo.movieCommentList.length))
      this.movieInfo.movieCommentList = this.movieInfo.movieCommentList.map((obj, index) => {
        obj.sysUser.userPicture = this.httpURL + JSON.parse(obj.sysUser.userPicture)[0]
        return obj
      })
    },
    showActors(){
      this.activeName = 'actors'
    },
    showPictures(){
      this.activeName = 'pictures'
    },
    writeCommentDialogClosed(){
      this.$refs.commentFormRef.resetFields()
    },
    //提交影评
    async submitComment(){
      this.writeCommentDialogVisible = false
      this.commentForm.score = this.commentForm.score * 2
      this.commentForm.movieId = this.movieId
      this.commentForm.commentTime = moment().format('YYYY-MM-DD HH:mm:ss')
      this.commentForm.userId = JSON.parse(window.sessionStorage.getItem('loginUser')).userId
      axios.defaults.headers.post['Content-Type'] = 'application/json'
      const { data : res } = await axios.post('sysMovieComment', JSON.stringify(this.commentForm))
      if(res.code !== 200) return this.$message.error('发布短评失败')
      this.$message.success('评论发布成功')
      await this.getMovieInfo()
    },
    //转到购票页面
    toCinema(){
      this.$router.push('/cinema')
    },
    //转到演员详细信息页面
    toActor(actorId){
      this.$router.push('/actor/' + actorId)
    }
  }
}
</script>

<style scoped>
.movie-container{

}

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

.movie-info-btn{
  position: absolute;
  bottom: 20px;
}

.buy-btn{
  margin-top: 10px;
  width: 250px;
  height: 40px;
  font-size: 16px;
  text-align: center;
}

.movie-info-score{
  position: absolute;
  top: 145px;
  left: 342px;
}

.movie-index {
  margin-bottom: 16px;
  color: #fff;
}

.box-office-container{
  display: flex;
  flex-direction: column;
}

.movie-index-title{
  font-size: 12px;
  margin-bottom: 8px;
}

.movie-score-num{
  font-size: 30px;
  color: #ffc600;
  height: 30px;
  line-height: 30px;
  margin-right: 10px;
}

.score-container{
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 12px;
}

.box-office{
  font-size: 30px;
}

.unit{
  font-size: 12px;
  padding-left: 1px;
  line-height: 24px;
}

.movie-info-right{
  height: 300px;
  position: relative;
  margin-right: 30px;
  margin-left: 300px;
  margin-top: 70px;
}

.movie-info-detail-container{
  width:1200px;
  margin: 0 auto;
}

.movie-info-detail{
  margin-top: 80px;
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

.el-tabs >>> .el-tabs__item{
  font-size: 20px;
}

.tab-body{
  margin-top: 40px;
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

.more{
  float: right;
  cursor: pointer;
  font-size: 14px;
  color: #999;
  padding-right: 14px;
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAOCAYAAAASVl2WAAAABmJLR0QA/wD/AP+gvaeTAAAAv0lEQVQY013RTUpDQRAE4G8eghcR8ScgKCIugpJFjuIjqAvBc7jxj0muEnCjiIQQJOImB3GnbnpkfL1qpqqrunpSzvkDPxjhGdq2VarBF3q4wRHknP8RzvCEQzzguCalaHZwiwHecY6XogCf8TjFHh7Rh9Tx3AylIZa4TgWpSBuY4BSrYlFXKsr4bjrTW5HkJJa9SBW4jbtukmKxG5MDLOKqfzEPcB9LzQN8LSdfwxj7eMMlZvV/NFiPzFddEH4Bt5Y1mf3fnDwAAAAASUVORK5CYII=) no-repeat 100%;
}

.actors-container{
  font-size: 16px;
  color: #333;
  display: flex;
  justify-content: flex-start;
}

#pane-actors .actors-container{
  flex-direction: column;
}

#pane-actors .actors-container .actors-group{
  margin-left: 0;
  margin-bottom: 40px;
}

#pane-actors .actors-container .actors-group .actors-list{
  flex-wrap: wrap;
}

#pane-actors .actors-container .actors-group .actors-list .actor{
  margin-bottom: 20px;
}

.actors-group:first-child{
  margin-left: 0;
}

.actors-group {
  float: left;
  margin-left: 20px;
}

.actors-type{
  margin-bottom: 16px;
}

.actors-list{
  display: flex;
  margin-left: -20px;
  padding: 0;
}

.actor{
  float: left;
  width: 128px;
  margin-left: 20px;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.portrait{
  margin-bottom: 6px;
  width: 128px;
  height: 170px;
  overflow: hidden;
}

.portrait .default-img{
  width: 128px;
  height: 170px;
}

.actor-name{
  margin-top: 8px;
  line-height: 1.2;
  color: #333;
  display: inline-block;
  width: 128px;
  text-align: center;
  padding-bottom: 1px;
  margin-bottom: -1px;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}

.pictures-list{
  display: flex;
}

.pictures-list>.el-image:first-child{
  width: 465px;
  height: 258px;
}

.pictures-list .default-img{
  border-style: none;
  cursor: pointer;
  width: 126px;
  height: 126px;
}

.little-pictures{
  width: 262px;
  height: 262px;
  display: flex;
  flex-wrap: wrap;
  margin-left: 10px;
  justify-content: space-between;
}

#pane-pictures .little-pictures{
  width: 100%;
  justify-content: flex-start;
  margin-left: 0;
}

#pane-pictures .default-img{
  margin-top: 10px;
  margin-left: 10px;
}

.comment-container{
  display: flex;
  margin-top: 20px;
}

.user-avatar{
  width: 50px;
  height: 50px;
  margin-right: 20px;
}

.comment-main{
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.main-header{
  font-size: 16px;
}

.user-name{
  margin-top: 2px;
}

.comment-date{
  margin-top: 4px;
  color: #999;
  display: flex;
}

.comment-content{
  margin-top: 20px;
  padding-bottom: 30px;
  border-bottom: 1px solid #e5e5e5;
  color: #666;
  line-height: 26px;
  font-size: 14px;
}

.write-comment-dialog{
  display: flex;
  flex-direction: column;
  align-items: center;
}

.write-comment-dialog >>> i{
  font-size: 30px;
}

.comment-score-container{
  margin-bottom: 10px;
}
</style>