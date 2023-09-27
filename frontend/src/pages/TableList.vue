<template>
  <div class="container">
    <!-- 资产信息输入表单 -->
<el-form :model="form" label-width="120px" class="asset-form">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-form-item label="农户ID">
            <el-input v-model="form.farmerId"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="资产类型">
            <el-input v-model="form.assetType"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="资产面积">
            <el-input v-model="form.assetArea"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="农作物类型">
            <el-input v-model="form.cropType"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-form-item label="土壤类型">
            <el-input v-model="form.soilType"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="水源情况">
            <el-input v-model="form.waterSource"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="环境状况">
            <el-input v-model="form.environmentalCondition"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="预期产量">
            <el-input v-model="form.expectedYield"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="资产位置">
        <div id="map-container"></div>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitAsset">提交资产</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="assets" style="width: 100%" class="asset-table">
      <el-table-column prop="farmerId" label="农户ID"></el-table-column>
      <el-table-column prop="assetType" label="资产类型"></el-table-column>
      <el-table-column prop="assetArea" label="资产面积"></el-table-column>
      <el-table-column prop="cropType" label="农作物类型"></el-table-column>
      <el-table-column prop="soilType" label="土壤类型"></el-table-column>
      <el-table-column prop="waterSource" label="水源情况"></el-table-column>
      <el-table-column prop="environmentalCondition" label="环境状况"></el-table-column>
      <el-table-column prop="expectedYield" label="预期产量"></el-table-column>
      <el-table-column prop="tokenHash" label="代币哈希"></el-table-column>
      <el-table-column label="操作" width="180">
        <template #default="scope">
          <el-button size="mini">抵押</el-button>
          <el-button size="mini">流转</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-sizes="[5, 10, 20, 50]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="totalAssets"
    >
    </el-pagination>
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentPage: 1, // 当前页码
      pageSize: 10, // 每页显示的记录数
      totalAssets: 0, // 总记录数
      pagedAssets: [], // 当前页的资产数据
      form: {
        farmerId: '张三350302199009090909',
        assetType: '土地',
        assetArea: '100亩',
        cropType: '小麦',
        soilType: '砂壤',
        waterSource: '地下水',
        environmentalCondition: '良好',
        expectedYield: '10吨',
      },
      assets: [
        {
          farmerId: '张三350302199009090909',
          assetType: '土地',
          assetArea: '100亩',
          cropType: '小麦',
          soilType: '砂壤',
          waterSource: '地下水',
          environmentalCondition: '良好',
          expectedYield: '10吨',
          tokenHash: '0x23cf7902a3c9dd5f4eab2310bb780d23edac6589'          
        },
        {
          farmerId: '李四350302199112120101',
          assetType: '渔塘',
          assetArea: '50亩',
          cropType: '鲤鱼',
          soilType: '淤泥',
          waterSource: '地表水',
          environmentalCondition: '优良',
          expectedYield: '20吨',
          tokenHash: '0x47c4f342f3f5e41c6ddba37649833fddbe11e49a'
        },
        {
          farmerId: '王五350302198705070505',
          assetType: '果园',
          assetArea: '80亩',
          cropType: '苹果',
          soilType: '壤土',
          waterSource: '雨水',
          environmentalCondition: '良好',
          expectedYield: '30吨',
          tokenHash: '0x68e3f0a8a2b56819e5f08b6bce9b7e2dc5c7b0d9'
        },        
        // 添加其它静态资产数据
      ]
    };
  },
  mounted() {
    this.totalAssets = this.assets.length;
    this.handleCurrentChange(this.currentPage);
  },
  methods: {
    handleSizeChange(val) {
      this.pageSize = val;
      this.handleCurrentChange(1); // 每次变更每页显示的记录数时，都回到第一页
    },
    handleCurrentChange(val) {
      this.currentPage = val;
      const start = (val - 1) * this.pageSize;
      const end = val * this.pageSize;
      this.pagedAssets = this.assets.slice(start, end);
    },
    submitAsset() {
      // 实现提交资产的逻辑，比如将资产信息添加到assets数组中
    }
  }
};
</script>

<style scoped>
#map-container {
  width: 100%;
  height: 300px;
  background-image: url('map-placeholder.jpg'); /* 请替换为实际的地图占位图 */
  background-size: cover;
  background-position: center;
}

.asset-table {
  margin-top: 20px;
}
</style>
