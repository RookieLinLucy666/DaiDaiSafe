/*
 * @Author: RookieLinLucy666 18810911883@163.com
 * @Date: 2023-09-05 15:25:34
 * @LastEditors: RookieLinLucy666 18810911883@163.com
 * @LastEditTime: 2023-09-14 15:56:01
 * @FilePath: /frontend/src/router/routes.js
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import DashboardLayout from "@/layout/dashboard/DashboardLayout.vue";
// GeneralViews
import NotFound from "@/pages/NotFoundPage.vue";

// Admin pages
import Dashboard from "@/pages/Dashboard.vue";
import UserProfile from "@/pages/UserProfile.vue";
import Notifications from "@/pages/Notifications.vue";
import Icons from "@/pages/Icons.vue";
import Maps from "@/pages/Maps.vue";
import Typography from "@/pages/Typography.vue";
import TableList from "@/pages/TableList.vue";

const routes = [
  {
    path: "/",
    component: DashboardLayout,
    redirect: "/overview",
    children: [
      {
        path: "overview",
        name: "整体概览",
        component: Dashboard
      },
      {
        path: "query",
        name: "查账还款",
        component: UserProfile
      },
      {
        path: "policy",
        name: "政策公告",
        component: Notifications
      },
      {
        path: "incentive",
        name: "上链激励",
        component: Icons
      },
      {
        path: "forgot",
        name: "数据遗忘",
        component: Maps
      },
      {
        path: "price",
        name: "风险定价",
        component: Typography
      },
      {
        path: "circulate",
        name: "评估流转",
        component: TableList
      }
    ]
  },
  { path: "*", component: NotFound }
];

/**
 * Asynchronously load view (Webpack Lazy loading compatible)
 * The specified component must be inside the Views folder
 * @param  {string} name  the filename (basename) of the view to load.
function view(name) {
   var res= require('../components/Dashboard/Views/' + name + '.vue');
   return res;
};**/

export default routes;
