<template>
  <div>
    <div class="chart-container">
      <div ref="accuracyChart" class="chart"></div>
      <div ref="lossChart" class="chart"></div>
    </div>

  <div class="container">
    <div class="form-container">
      <div class="form-row">
        <div class="form-group">
          <label>选择要遗忘的农户数据集:</label>
          <select v-model="selectedDataPoint" class="form-control">
            <option v-for="point in dataPoints" :value="point" :key="point.id">{{ point.name }}</option>
          </select>
        </div>
        <div class="form-group">
          <label>选择农户数据遗忘策略:</label>
          <select v-model="selectedStrategy" class="form-control">
            <option v-for="strategy in strategies" :value="strategy" :key="strategy">{{ strategy }}</option>
          </select>
        </div>
      </div>
      <div class="button-container">
        <button @click="unlearn" class="btn btn-primary">农户数据遗忘</button>
      </div>
    </div>
    <div v-if="feedbackMessage" class="feedback">
      <p>{{ feedbackMessage }}</p>
    </div>
  </div> 
  
  </div>
</template>

<script>
import * as echarts from 'echarts';

export default {
  data() {
    return {
      selectedDataPoint: '农户数据集2',
      selectedStrategy: '农户数据遗忘策略1',
      strategies: ['农户数据遗忘策略1', '农户数据遗忘策略2', '农户数据遗忘策略3', '农户数据遗忘策略4'],
      dataPoints: [
        { id: 1, name: '农户数据集1' },
        { id: 2, name: '农户数据集2' },
        { id: 3, name: '农户数据集3' },
      ],
      feedbackMessage: '',
    };
  },
  mounted() {
    this.drawAccuracyChart();
    this.drawLossChart();
  },
  methods: {
    drawAccuracyChart() {
      const chart = echarts.init(this.$refs.accuracyChart);
      const option = {
        title: { text: '正确率' },
        xAxis: { type: 'category', data: ['农户数据集 1', '农户数据集 2', '农户数据集 3'] },
        yAxis: { type: 'value' },
        legend: { // 添加 legend 组件
          data: ['FedAvg', 'FedEraser', 'Ours', 'RapidTrain'] // 你的每个系列的 name
        },
        series: [
          { name: 'FedAvg', type: 'line', data: [0.9774, 0.8617, 0.6606],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
          { name: 'FedEraser', type: 'line', data: [0.9648, 0.8545, 0.5789],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
          { name: 'Ours', type: 'line', data: [0.9668, 0.8576, 0.5461],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
          { name: 'RapidTrain', type: 'line', data: [0.9538, 0.8477, 0.5467],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
        ]
      };
      chart.setOption(option);
    },
    drawLossChart() {
      const chart = echarts.init(this.$refs.lossChart);
      const option = {
        title: { text: '损失值' },
        xAxis: { type: 'category', data: ['农户数据集 1', '农户数据集 2', '农户数据集 3'] },
        yAxis: { type: 'value' },
        legend: { // 添加 legend 组件
          data: ['FedAvg', 'FedEraser', 'Ours', 'RapidTrain'] // 你的每个系列的 name
        },
        series: [
          { name: 'FedAvg', type: 'line', data: [0.00168120, 0.01333314, 0.02825453],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
          { name: 'FedEraser', type: 'line', data: [0.00179501, 0.00675153, 0.02960426],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
          { name: 'Ours', type: 'line', data: [0.00173691, 0.00666871, 0.03009269],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
          { name: 'RapidTrain', type: 'line', data: [0.00231600, 0.00693692, 0.03005097],label: {
          show: true,
          position: 'top',
          formatter: '{c}'
        }, },
        ]
      };
      chart.setOption(option);
    },
    async unlearn() {
      if (this.selectedDataPoint && this.selectedStrategy) {
        this.feedbackMessage = `已应用${this.selectedStrategy}来遗忘${this.selectedDataPoint.name}。`;
      }
    },
  },
};
</script>

<style>
.chart-container {
  display: flex;
  justify-content: space-between;
}

.chart {
  width: 48%;
  height: 400px;
  background-color: #f0f0f0;
}

.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
}

.form-container {
  width: 600px;
}

.form-row {
  display: flex;
  flex-direction: row;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 10px;
  flex: 1; /* Make each form-group take equal width */
}

.form-control {
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.button-container {
  margin-top: 20px;
  text-align: center;
}

.btn {
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
  border: none;
  border-radius: 4px;
  background-color: #007bff;
  color: #fff;
}

.btn:hover {
  background-color: #0056b3;
}

.feedback {
  margin-top: 20px;
  color: red;
  text-align: center;
}
</style>
