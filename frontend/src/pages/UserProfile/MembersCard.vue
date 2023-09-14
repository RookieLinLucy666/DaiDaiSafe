<template>
  <card class="card" :title="title">
    <div>
      <ul class="list-unstyled team-members">
        <li>
          <div class="row" v-for="member in members" :key="member.name">
            <div class="col-3">
              <div class="avatar">
                <img :src="member.image" alt="Circle Image" class="rounded img-fluid">
              </div>
            </div>
            <div class="col-6">
              {{member.name}}
              <br>
              <span :class="getStatusClass(member.status)">
                <small>{{member.status}}</small>
              </span>
            </div>

            <div class="col-3">
              <p-button type="success" outline icon>
                <i class="fa fa-envelope"></i>
              </p-button>
            </div>
          </div>
        </li>
      </ul>
    </div>
  </card>
</template>
<script>
export default {
  data() {
    return {
      title: "担保人",
      members: [
        {
          image: require("@/assets/img/faces/face-0.jpg"),
          name: "张三",
          status: "信用良好"
        },
        {
          image: require("@/assets/img/faces/face-1.jpg"),
          name: "李四",
          status: "信用极好"
        },
        {
          image: require("@/assets/img/faces/face-1.jpg"),
          name: "王五",
          status: "信用一般"
        }
      ]
    };
  },
  methods: {
    getStatusClass(status) {
      switch (status) {
        case "信用良好":
          return "text-muted";
        case "信用极好":
          return "text-success";
        case "信用一般":
          return "text-danger";
        default:
          return "text-success";
      }
    }
  }
};
</script>
<style>
</style>
