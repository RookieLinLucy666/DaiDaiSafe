<!--
 * @Author: RookieLinLucy666 18810911883@163.com
 * @Date: 2023-09-05 15:25:34
 * @LastEditors: RookieLinLucy666 18810911883@163.com
 * @LastEditTime: 2023-09-14 15:54:38
 * @FilePath: /frontend/src/layout/dashboard/DashboardLayout.vue
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
<template>
  <div class="wrapper">
    <side-bar>
      <template slot="links">
        <sidebar-link to="/overview" name="农户贷款信息概览" icon="ti-panel"/>
        <sidebar-link to="/query" name="农户贷款申请还款" icon="ti-user"/>
        <sidebar-link to="/circulate" name="农户资产评估流转" icon="ti-view-list-alt"/>
        <sidebar-link to="/price" name="农户贷前风险定价" icon="ti-text"/>
        <sidebar-link to="/incentive" name="农户信息上链激励" icon="ti-pencil-alt2"/>
        <sidebar-link to="/forgot" name="农户贷款数据遗忘" icon="ti-map"/>
        <sidebar-link to="/policy" name="乡村振兴政策公告" icon="ti-bell"/>
      </template>
      <mobile-menu>
        <li class="nav-item">
          <a class="nav-link">
            <i class="ti-panel"></i>
            <p>角色：银行</p>
          </a>
        </li>
        <drop-down class="nav-item"
                   title="4 最新活动与项目"
                   title-classes="nav-link"
                   icon="ti-bell">
          <a class="dropdown-item">三农电商平台</a>
          <a class="dropdown-item">农保智能平台</a>
          <a class="dropdown-item">农业三资平台</a>
          <a class="dropdown-item">远程金融咨询</a>
        </drop-down>
        <li class="nav-item">
          <a class="nav-link">
            <i class="ti-settings"></i>
            <p>系统设置</p>
          </a>
        </li>
        <li class="divider"></li>
      </mobile-menu>
    </side-bar>
    <div class="main-panel">
      <top-navbar></top-navbar>

      <dashboard-content @click.native="toggleSidebar">

      </dashboard-content>

      <content-footer></content-footer>
    </div>
  </div>
</template>
<style lang="scss">
</style>
<script>
import TopNavbar from "./TopNavbar.vue";
import ContentFooter from "./ContentFooter.vue";
import DashboardContent from "./Content.vue";
import MobileMenu from "./MobileMenu";
export default {
  components: {
    TopNavbar,
    ContentFooter,
    DashboardContent,
    MobileMenu
  },
  methods: {
    toggleSidebar() {
      if (this.$sidebar.showSidebar) {
        this.$sidebar.displaySidebar(false);
      }
    }
  }
};
</script>
