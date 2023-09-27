<template>
  <div class="container">

    <div class="filter-section">
      <label>筛选：</label>
      <input v-model="filterText" placeholder="按激励点数筛选" />
      <label>排序：</label>
      <select v-model="sortOption">
        <option value="username">姓名</option>
        <option value="points">激励点数</option>
        <option value="level">激励等级</option>
      </select>
    </div>


    <table class="farmer-table">
      <thead>
        <tr>
          <th>姓名</th>
          <th>身份证</th>
          <th>性别</th>
          <th>年龄</th>
          <!-- 更多列 ... -->
          <th>激励点数</th>
          <th>激励等级</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="farmer in filteredAndSortedFarmers" :key="farmer.id">
          <td>{{ farmer.user.username }}</td>
          <td>{{ farmer.user.id }}</td>
          <td>{{ farmer.user.gender }}</td>
          <td>{{ farmer.user.age }}</td>
          <!-- 更多单元格 ... -->
          <td>
            <div class="progress">
              <div class="progress-bar" :style="{ width: farmer.incentives.points + '%' }"></div>
            </div>
          </td>
          <td :class="farmer.incentives.level.toLowerCase()">{{ farmer.incentives.level }}</td>
          <td>
            <button @click="increaseIncentive(farmer)" class="btn-icon">🌟激励</button>
            <button @click="editFarmer(farmer)" class="btn-icon">✏️编辑</button>
            <button @click="deleteFarmer(farmer.id)" class="btn-icon">🗑️删除</button>
          </td>
        </tr>
      </tbody>
    </table>
    <div class="pagination">
      <button @click="previousPage" :disabled="currentPage <= 1">上一页</button>
      <span>{{ currentPage }}</span>
      <button @click="nextPage" :disabled="currentPage >= maxPage">下一页</button>
    </div>
    <div v-if="showModal" class="modal">
      <div class="modal-content">
        <span @click="showModal=false" class="close">&times;</span>
        <p>一些激励相关的内容</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      showModal: false,
      farmers: [
        {
          id: 1,
          user: {
            username: "张三",
            id: "350302199009090909",
            gender: "男",
            age: "32",
          },
          incentives: {
            points: 50,
            level: "Bronze",
          },
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
      {
        id: 7,
        user: {
          username: "周二",
          id: "350302199302020202",
          gender: "男",
          age: "30",
        },
        incentives: {
          points: 90,
          level: "Gold",
        },
      },
      {
        id: 8,
        user: {
          username: "吴三",
          id: "350302199203030303",
          gender: "女",
          age: "31",
        },
        incentives: {
          points: 110,
          level: "Gold",
        },
      },
      {
        id: 9,
        user: {
          username: "郑四",
          id: "350302199104040404",
          gender: "男",
          age: "32",
        },
        incentives: {
          points: 130,
          level: "Platinum",
        },
      },
      {
        id: 10,
        user: {
          username: "王五",
          id: "350302199005050505",
          gender: "女",
          age: "33",
        },
        incentives: {
          points: 150,
          level: "Platinum",
        },
      },
      {
        id: 11,
        user: {
          username: "李六",
          id: "350302198906060606",
          gender: "男",
          age: "34",
        },
        incentives: {
          points: 170,
          level: "Diamond",
        },
      },
      {
        id: 12,
        user: {
          username: "陈七",
          id: "350302198807070707",
          gender: "女",
          age: "35",
        },
        incentives: {
          points: 190,
          level: "Diamond",
        },
      },
      // {
      //   id: 13,
      //   user: {
      //     username: "何八",
      //     id: "350302198708080808",
      //     gender: "男",
      //     age: "36",
      //   },
      //   incentives: {
      //     points: 210,
      //     level: "Diamond",
      //   },
      // },
      // {
      //   id: 14,
      //   user: {
      //     username: "刘九",
      //     id: "350302198609090909",
      //     gender: "女",
      //     age: "37",
      //   },
      //   incentives: {
      //     points: 230,
      //     level: "Diamond",
      //   },
      // },
      // {
      //   id: 15,
      //   user: {
      //     username: "张十",
      //     id: "350302198510101010",
      //     gender: "男",
      //     age: "38",
      //   },
      //   incentives: {
      //     points: 250,
      //     level: "Diamond",
      //   },
      // },
      // {
      //   id: 16,
      //   user: {
      //     username: "欧阳十一",
      //     id: "350302198411111111",
      //     gender: "女",
      //     age: "39",
      //   },
      //   incentives: {
      //     points: 270,
      //     level: "Diamond",
      //   },
      // }
      ],
      filterText: '',
      sortOption: 'username',
    };
  },
  methods: {
    increaseIncentive(farmer) {
      farmer.incentives.points += 10;
      if (farmer.incentives.points > 100) {
        farmer.incentives.level = 'Silver';
      }
      this.showModal = true;
    },
    editFarmer(farmer) {
      // 编辑农户信息的逻辑
    },
    deleteFarmer(farmerId) {
      this.farmers = this.farmers.filter(f => f.id !== farmerId);
    },
    nextPage() {
      if (this.currentPage < this.maxPage) this.currentPage++;
    },
    previousPage() {
      if (this.currentPage > 1) this.currentPage--;
    },
  },

  computed: {
    maxPage() {
      return Math.ceil(this.filteredAndSortedFarmers.length / this.itemsPerPage);
    },
    paginatedFarmers() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      const end = start + this.itemsPerPage;
      return this.filteredAndSortedFarmers.slice(start, end);
    },
    filteredAndSortedFarmers() {
      let farmers = this.farmers.filter(f => f.user.username.includes(this.filterText));
      switch (this.sortOption) {
        case 'username':
          return farmers.sort((a, b) => a.user.username.localeCompare(b.user.username));
        case 'points':
          return farmers.sort((a, b) => b.incentives.points - a.incentives.points);
        case 'level':
          const levels = ['Diamond', 'Platinum', 'Gold', 'Silver', 'Bronze'];
          return farmers.sort((a, b) => levels.indexOf(b.incentives.level) - levels.indexOf(a.incentives.level));
        default:
          return farmers;
      }
    }
  },
};
</script>


<style scoped>
.farmer-table {
  width: 100%;
  border-collapse: collapse;
}

.farmer-table th, .farmer-table td {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

.farmer-table th {
  background-color: #f2f2f2;
}

.modal {
  display: flex;
  align-items: center;
  justify-content: center;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  background-color: #ffffff;
  padding: 20px;
  border-radius: 8px;
  width: 400px;
}

.close {
  cursor: pointer;
  float: right;
  font-size: 20px;
}

.filter-section {
  margin-bottom: 20px;
}

.progress {
  background-color: #e0e0e0;
  height: 10px;
}

.progress-bar {
  background-color: #76c7c0;
  height: 100%;
}

.bronze {
  color: #cd7f32;
}

.silver {
  color: #c0c0c0;
}

.gold {
  color: #ffd700;
}

.platinum {
  color: #e5e4e2;
}

.diamond {
  color: #b9f2ff;
}

.btn-icon {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 16px;
}
.pagination {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 20px;
}
</style>
