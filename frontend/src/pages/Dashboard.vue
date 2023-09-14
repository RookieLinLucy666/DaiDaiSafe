<template>
  <div>

    <!--Stats cards-->
    <div class="row">
      <div class="col-md-6 col-xl-3" v-for="stats in statsCards" :key="stats.title">
        <stats-card>
          <div class="icon-big text-center" :class="`icon-${stats.type}`" slot="header">
            <i :class="stats.icon"></i>
          </div>
          <div class="numbers" slot="content">
            <p>{{stats.title}}</p>
            {{stats.value}}
          </div>
          <div class="stats" slot="footer">
            <i :class="stats.footerIcon"></i> {{stats.footerText}}
          </div>
        </stats-card>
      </div>
    </div>

    <!--Charts-->
    <div class="row">

      <div class="col-12">
        <chart-card title="贷款业务"
                    sub-title="四个季度农户数据分析"
                    :chart-data="usersChart.data"
                    :chart-options="usersChart.options">
          <span slot="footer">
            <i class="ti-reload"></i> 3分钟前更新
          </span>
          <div slot="legend">
            <i class="fa fa-circle text-info"></i> 还款总额
            <i class="fa fa-circle text-danger"></i> 逾期总额
            <i class="fa fa-circle text-warning"></i> 坏账总额
          </div>
        </chart-card>
      </div>

      <div class="col-md-6 col-12">
        <chart-card title="贷款用途分布"
                    sub-title="按农作物种类分类的贷款总额"
                    :chart-data="preferencesChart.data"
                    chart-type="Pie">
          <span slot="footer">
            <i class="ti-timer"></i> 2023年第三季度</span>
          <div slot="legend">
            <i class="fa fa-circle text-info"></i> 购买农机
            <i class="fa fa-circle text-danger"></i> 土地改良
            <i class="fa fa-circle text-warning"></i> 种植或畜牧
          </div>
        </chart-card>
      </div>

      <div class="col-md-6 col-12">
        <chart-card title="不同季节贷款需求"
                    sub-title="如春耕和秋收"
                    :chart-data="activityChart.data"
                    :chart-options="activityChart.options">
          <span slot="footer">
            <i class="ti-check"></i> 截止2022年12月31日
          </span>
          <div slot="legend">
            <i class="fa fa-circle text-info"></i> 平均贷款金额
            <i class="fa fa-circle text-warning"></i> 平均还款金额
          </div>
        </chart-card>
      </div>

    </div>

  </div>
</template>
<script>
import { StatsCard, ChartCard } from "@/components/index";
import Chartist from 'chartist';
export default {
  components: {
    StatsCard,
    ChartCard
  },
  /**
   * Chart data used to render stats, charts. Should be replaced with server data
   */
  data() {
    return {
      statsCards: [
        {
          type: "warning",
          icon: "ti-server",
          title: "贷款总量（万）",
          value: "20,300",
          footerText: "更新",
          footerIcon: "ti-reload"
        },
        {
          type: "success",
          icon: "ti-wallet",
          title: "贷款笔数",
          value: "1,345",
          footerText: "截止2023年09月",
          footerIcon: "ti-calendar"
        },
        {
          type: "danger",
          icon: "ti-pulse",
          title: "还款总额（万）",
          value: "5,060",
          footerText: "截止2023年09月",
          footerIcon: "ti-timer"
        },
        {
          type: "info",
          icon: "ti-twitter-alt",
          title: "坏账率",
          value: "11.12%",
          footerText: "更新",
          footerIcon: "ti-reload"
        }
      ],
      usersChart: {
        data: {
          labels: [
            "2022年一季度",
            "2022年二季度",
            "2022年三季度",
            "2022年四季度",
            "2023年一季度",
            "2023年二季度",
            "2023年三季度",
            "2023年四季度"
          ],
          series: [
            [287, 385, 490, 562, 594, 626, 698, 895, 952],
            [67, 152, 193, 240, 387, 435, 535, 642, 744],
            [23, 113, 67, 108, 190, 239, 307, 410, 410]
          ]
        },
        options: {
          low: 0,
          high: 1000,
          showArea: true,
          height: "245px",
          axisX: {
            showGrid: false
          },
          lineSmooth: Chartist.Interpolation.simple({
            divisor: 3
          }),
          showLine: true,
          showPoint: false
        }
      },
      activityChart: {
        data: {
          labels: [
            "一月",
            "二月",
            "三月",
            "四月",
            "五月",
            "六月",
            "七月",
            "八月",
            "九月",
            "十月",
            "十一月",
            "十二月"
          ],
          series: [
            [542, 543, 520, 680, 653, 753, 326, 434, 568, 610, 756, 895],
            [230, 293, 380, 480, 503, 553, 600, 664, 698, 710, 736, 795]
          ]
        },
        options: {
          seriesBarDistance: 10,
          axisX: {
            showGrid: false
          },
          height: "245px"
        }
      },
      preferencesChart: {
        data: {
          labels: ["62%", "32%", "6%"],
          series: [62, 32, 6]
        },
        options: {}
      }
    };
  }
};
</script>
<style>
</style>
