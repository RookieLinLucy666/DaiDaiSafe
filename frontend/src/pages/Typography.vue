<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card class="fixed-height-card box-card">
          <div slot="header" class="clearfix">
            <span>
              <i class="el-icon-s-data"></i>
              农户贷款风险评估
            </span>
          </div>

          <div class="text item">
            <div v-for="record in assessmentRecords" :key="record.id" class="record">
              <el-tag class="tag">
                {{ record.user.username }} {{ record.user.id }} {{ record.user.gender }} {{ record.user.age }} {{ record.incentives.level }} {{ record.incentives.points }}
                <i :class="getRiskIcon(record.incentives.level)"></i>
              </el-tag>
            </div>

            <div id="pieChart" style="height: 300px;"></div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="8">
        <el-card class="fixed-height-card">
          <div slot="header" class="clearfix">
            <span>
              <i class="el-icon-setting"></i>
              农户贷前风险评估模型训练与更新
            </span>
          </div>
          <el-button type="primary" @click="trainModel">农户数据训练与遗忘</el-button>
          <div v-for="bar in progressBars" :key="bar.id">
            <el-progress :percentage="bar.progress" :status="bar.status"></el-progress>
          </div>
          <div id="training-chart" style="height:300px;"></div>
        </el-card>
      </el-col>
      
      <el-col :span="8">
          <el-card class="fixed-height-card">
            <div slot="header" class="clearfix">
              <span>
                <i class="el-icon-s-data"></i>
                链上农户数据查看
              </span>
              <el-input
                v-model="search"
                placeholder="搜索"
                class="header-search"
                clearable
              />
            </div>
            <el-table
              :data="filteredBlockchainData"
              style="width: 100%"
              @sort-change="sortChange"
            >
              <el-table-column
                prop="loanRecord"
                label="贷款记录"
                sortable="custom"
              ></el-table-column>
              <el-table-column
                prop="nftAssets"
                label="NFT资产"
                sortable="custom"
              ></el-table-column>
            </el-table>
            <el-pagination
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
              :current-page="currentPage"
              :page-sizes="[5, 10, 20]"
              :page-size="pageSize"
              layout="total, sizes, prev, pager, next, jumper"
              :total="blockchainData.length"
            ></el-pagination>
          </el-card>
        </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts';


export default {
  mounted() {
    this.initPieChart();
    this.accPieChart();
  },
  data() {
    return {
      search: '',
      currentPage: 1,
      pageSize: 10,
      progressBars: [
        { id: 1, progress: 0, status: 'success' },
        { id: 2, progress: 50, status: 'exception' },
        { id: 3, progress: 25, status: 'success' },
        { id: 4, progress: 75, status: 'exception' },
        { id: 5, progress: 100, status: 'success' },
        { id: 6, progress: 60, status: 'exception' },
        { id: 7, progress: 30, status: 'success' },
        { id: 8, progress: 80, status: 'exception' },
        { id: 9, progress: 40, status: 'success' },
        { id: 10, progress: 90, status: 'exception' },
        { id: 11, progress: 20, status: 'success' },
        { id: 12, progress: 55, status: 'exception' },
        { id: 13, progress: 70, status: 'success' },
        { id: 14, progress: 35, status: 'exception' },
        { id: 15, progress: 85, status: 'success' },
      ],
      preferencesChart: {
        data: {
          labels: ["62%", "32%", "6%"],
          series: [62, 32, 6]
        },
        options: {}
      },
      assessmentRecords: [
        {
          id: 1,
          user: { username: "张三", id: "350302199009090909", gender: "男", age: "32" },
          incentives: { points: 50, level: "Bronze" },
        },
        {
          id: 2,
          user: {
            username: "李四",
            id: "350302198809080808",
            gender: "女",
            age: "34",
          },
          incentives: {
            points: 80,
            level: "Silver",
          },
        },
        {
          id: 3,
          user: {
            username: "王五",
            id: "350302198707070707",
            gender: "男",
            age: "35",
          },
          incentives: {
            points: 120,
            level: "Gold",
          },
        },
        {
          id: 4,
          user: {
            username: "赵六",
            id: "350302198606060606",
            gender: "女",
            age: "36",
          },
          incentives: {
            points: 150,
            level: "Platinum",
          },
        },
        {
          id: 5,
          user: {
            username: "陈七",
            id: "350302198505050505",
            gender: "男",
            age: "37",
          },
          incentives: {
            points: 180,
            level: "Diamond",
          },
        },
        {
        id: 6,
        user: {
          username: "林一",
          id: "350302199401010101",
          gender: "女",
          age: "29",
        },
        incentives: {
          points: 70,
          level: "Silver",
        },
      },

        // 更多记录...
      ],
      loanApplication: '申请1',
      progress: 0,
      progressStatus: 'success',
      blockchainData: [
        { 
            id: 1, 
            loanRecord: '张三', 
            nftAssets: '0x23cf7902a3c9dd5f4eab2310bb780d23edac6589' 
        },
        { 
            id: 2, 
            loanRecord: '李四', 
            nftAssets: '0x47c4f342f3f5e41c6ddba37649833fddbe11e49a' 
        },
        { 
            id: 3, 
            loanRecord: '王五', 
            nftAssets: '0x68e3f0a8a2b56819e5f08b6bce9b7e2dc5c7b0d9' 
        },
      ]
    }
  },
  computed: {
    filteredBlockchainData() {
      let data = this.blockchainData;
      if (this.search) {
        data = data.filter((item) =>
          item.loanRecord.includes(this.search) ||
          item.nftAssets.includes(this.search)
        );
      }
      return data.slice(
        (this.currentPage - 1) * this.pageSize,
        this.currentPage * this.pageSize
      );
    }
  },
  methods: {
    handleSizeChange(val) {
      this.pageSize = val;
      this.currentPage = 1;
    },
    handleCurrentChange(val) {
      this.currentPage = val;
    },
    sortChange({ column, prop, order }) {
      this.blockchainData.sort((a, b) => {
        const isDescending = order === 'descending';
        if (a[prop] > b[prop]) return isDescending ? -1 : 1;
        if (a[prop] < b[prop]) return isDescending ? 1 : -1;
        return 0;
      });
    },
    accPieChart() {
        // 初始化echarts实例
      var myChart = echarts.init(document.getElementById('training-chart'));
      
      // 配置项和数据
      var option = {
        title: {
          text: '2023年09月26日',
          subtext: '模型训练遗忘进度',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        series: [
          {
            name: '训练数据',
            type: 'pie',
            radius: '50%',
            data: [
              {value: 70, name: '训练完成'},
              {value: 30, name: '训练未完成'}
            ],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };

      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);
    },
    initPieChart() {
      // 基于准备好的dom，初始化echarts实例
      const myChart = echarts.init(document.getElementById('pieChart'));

      // 分组 assessmentRecords 以计算各风险等级的数量
      const levels = this.assessmentRecords.reduce((acc, record) => {
        acc[record.incentives.level] = (acc[record.incentives.level] || 0) + 1;
        return acc;
      }, {});

      // 计算百分比并格式化数据
      const total = this.assessmentRecords.length;
      const seriesData = Object.entries(levels).map(([level, count]) => ({
        value: (count / total) * 100,
        name: level,
      }));

      // 指定图表的配置项和数据
      const option = {
        title: {
            text: '2023年09月26日',
            subtext: '主要风险等级的百分比',
            left: 'center'
        },
        series: [
          {
            name: '风险等级',
            type: 'pie',
            radius: '50%',
            data: seriesData,
          },
        ],
      };

      // 使用刚指定的配置项和数据显示图表
      myChart.setOption(option);
    },
    trainModel() {
      this.progress = 0;
      const interval = setInterval(() => {
        this.progress += 10;
        if (this.progress >= 100) {
          clearInterval(interval);
          this.$message.success('模型训练完成!');
          this.progressStatus = 'success';
        }
      }, 500);
    },
    getRiskIcon(level) {
      switch (level) {
        case 'Gold':
          return 'el-icon-warning'; // 请替换为您认为合适表示高风险的图标
        case 'Silver':
          return 'el-icon-error'; // 请替换为您认为合适表示中风险的图标
        case 'Bronze':
        default:
          return 'el-icon-success'; // 请替换为您认为合适表示低风险的图标
      }
    },
  }
}
</script>

<style scoped>
.el-card {
  margin-bottom: 20px;
}

.fixed-height-card {
  height: 600px;
  display: flex;
  flex-direction: column;
  font-size: 12px;
}

.box-card {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.record {
  margin-bottom: 10px;
}

.tag {
  margin-right: 5px;
  display: flex;
  align-items: center;
}

i.el-icon-success {
  color: #67C23A;
}

i.el-icon-error {
  color: #F56C6C;
}

i.el-icon-warning {
  color: #E6A23C;
}

</style>
