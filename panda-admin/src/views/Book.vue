<template>
  <div>
    <table>
      <tr>
        <td>电影年代id</td>
        <td>电影年代名称</td>
      </tr>
      <tr v-for="items in movieAge">
        <td>{{items.movieAgeId}}</td>
        <td>{{items.movieAgeName}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: "Book",
  data(){
    return{
      movieAge: []
    }
  },
  created() {
    const _this = this
    axios.get('http://localhost:8181/sysMovieAge').then(function (resp){
        _this.movieAge = resp.data.data;
    })
  }
}
</script>

<style scoped>

</style>