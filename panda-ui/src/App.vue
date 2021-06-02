<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import global from "./assets/css/global.css"
export default {
  name: 'App',
  data() {
    return {

    }
  }
};
</script>

<style>

#nprogress .bar{
  position: absolute !important;
  top: 60px !important;
  height: 3px !important;
}

</style>
