<template>
  <card class="card-user">
    <div>
      <div class="author">
        <img class="avatar border-white" src="@/assets/img/faces/face-4.jpg" alt="...">
        <h6 class="title">小林小林</h6>
      </div>
    </div>
    <hr>
    <div class="text-center">
      <div class="row">
        <div v-for="(info, index) in details" :key="index" :class="getClasses(index)">
          <h6>{{info.title}}
            <br>
            <small>{{info.subTitle}}</small>
          </h6>
        </div>
      </div>
    </div>
  </card>
</template>
<script>
export default {
  data() {
    return {
      details: [
        {
          title: "10",
          subTitle: "欠款（万）"
        },
        {
          title: "无",
          subTitle: "资产抵押"
        },
        {
          title: "100%",
          subTitle: "还款率"
        },
      ]
    };
  },
  methods: {
    getClasses(index) {
      var remainder = index % 3;
      if (remainder === 0) {
        return "col-lg-3 offset-lg-1";
      } else if (remainder === 2) {
        return "col-lg-4";
      } else {
        return "col-lg-3";
      }
    }
  }
};
</script>
<style>
</style>
