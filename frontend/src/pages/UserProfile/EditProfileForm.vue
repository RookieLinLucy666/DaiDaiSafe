<template>
  <card class="card" title="农户贷款申请表">
    <div>
      <form @submit.prevent>
        <h5>基本信息</h5>
        <div class="row">
          <div class="col-md-1">
            <fg-input type="text"
                      label="姓名"
                      placeholder="Username"
                      v-model="user.username">
            </fg-input>
          </div>
          
          <div class="col-md-3">
            <fg-input type="text"
                      label="身份证"
                      placeholder="ID"
                      v-model="user.id">
            </fg-input>
          </div>

          <div class="col-md-1">
            <fg-input type="text"
                      label="性别"
                      placeholder="Gender"
                      v-model="user.gender">
            </fg-input>
          </div>

          <div class="col-md-1">
            <fg-input type="text"
                      label="年龄"
                      placeholder="Age"
                      v-model="user.age">
            </fg-input>
          </div>

          <div class="col-md-1">
            <fg-input type="text"
                      label="婚姻"
                      placeholder="Marry"
                      v-model="user.marry">
            </fg-input>
          </div>
          
          <div class="col-md-3">
            <fg-input type="text"
                      label="邮箱"
                      placeholder="Email"
                      v-model="user.email">
            </fg-input>
          </div>

        </div>

        <div class="row">

          <div class="col-md-2">
            <fg-input type="text"
                      label="手机"
                      placeholder="Phone"
                      v-model="user.phone">
            </fg-input>
          </div>

          <div class="col-md-4">
            <fg-input type="text"
                      label="住址"
                      placeholder="Address"
                      v-model="user.address">
            </fg-input>
          </div>
        </div>

        <h5>贷款信息</h5>
        <div class="row">
          <div class="col-md-2">
            <fg-input type="text"
                      label="贷款金额"
                      placeholder="Amount"
                      v-model="loan.amount">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="贷款期限"
                      placeholder="Time"
                      v-model="loan.time">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="贷款目的"
                      placeholder="Goal"
                      v-model="loan.goal">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="希望的还款方式"
                      placeholder="method"
                      v-model="loan.method">
            </fg-input>
          </div>
        </div>

        <h5>财务与收入</h5>
        <div class="row">
          <div class="col-md-2">
            <fg-input type="text"
                      label="年收入"
                      placeholder="Annual"
                      v-model="finance.annual">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="主要收入来源"
                      placeholder="MainSource"
                      v-model="finance.mainSource">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="负债情况"
                      placeholder="Debt"
                      v-model="finance.debt">
            </fg-input>
          </div>

          <div class="col-md-3">
            <fg-input type="text"
                      label="资产情况"
                      placeholder="asset"
                      v-model="finance.asset">
            </fg-input>
          </div>
        </div>

        <h5>农业活动信息</h5>
        <div class="row">
          <div class="col-md-2">
            <fg-input type="text"
                      label="主要农作物或畜牧品种"
                      placeholder="kind"
                      v-model="agriculture.kind">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="生产周期"
                      placeholder="period"
                      v-model="agriculture.period">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="预计收益"
                      placeholder="revenue"
                      v-model="agriculture.revenue">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="是否有农业保险"
                      placeholder="issurance"
                      v-model="agriculture.issurance">
            </fg-input>
          </div>
        </div>

        <h5>其他信息</h5>
        <div class="row">
          <div class="col-md-2">
            <fg-input type="text"
                      label="银行账户信息"
                      placeholder="bank"
                      v-model="others.bank">
            </fg-input>
          </div>

          <div class="col-md-2">
            <fg-input type="text"
                      label="信用记录"
                      placeholder="record"
                      v-model="others.record">
            </fg-input>
          </div>
        </div>

        <h5>附件</h5>
        <div>
          <p>身份证，土地或其他资产的所有权证明，近期的收入或税收证明，农业活动的相关证明（如种植面积、产量等），其他相关文件（如担保人的资料、负债证明等）等</p>
          <input type="file" ref="fileInput" @change="handleFileUpload"/>
          <button @click="submitFile">上传</button>
        </div>
        <br>
        <div class="text-center">
          <p-button type="info"
                    round
                    @click.native.prevent="applyLoan">
            提交申请
          </p-button>
        </div>
        <div class="clearfix"></div>
       
      </form>
    </div>
  </card>
</template>
<script>
export default {
  data() {
    return {
      user: {
        username: "小林小林",
        id: "350302199909090909",
        gender: "女",
        age: "26",
        marry: "未婚",
        phone: "18888888888",
        email: "18888888888@163.com",
        address: "北京市海淀区西土城路10号北京邮电大学",
      },
      loan: {
        amount: "100",
        time: "365",
        goal: "购买农机",
        method: "等额本息",
      },
      finance: {
        annual: "300",
        mainSource: "农作物、畜牧、兼职等",
        debt: "房贷",
        asset: "土地面积、房产、机械设备",
      },
      agriculture: {
        kind: "200亩水稻",
        period: "一年",
        revenue: "250",
        issurance: "有农业保险",
      },
      others: {
        bank: "4628450056269195",
        record: "信用良好",
      },
    };
  },
  methods: {
    applyLoan() {
      alert("Your data: " + JSON.stringify(this.user));
    }
  }
};
</script>
<style>
</style>
