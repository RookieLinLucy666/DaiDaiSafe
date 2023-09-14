<template>
 <div class="row">
  <div class="col-md-12">
    <card>
      <template slot="header">
        <h4 class="card-title">金融科技与乡村振兴</h4>
        <p class="card-category">主要发布的是关于乡村振兴的新政策、新项目或活动信息</p>
      </template>
      <div class="content">
        <div class="typo-line">
          <h4>
            <p class="category">2023年02月13日</p>中共中央 国务院关于做好2023年全面推进乡村振兴重点工作的意见</h4>
        </div>
        <div class="typo-line">
          <p>
            <span class="category">摘要</span>党的二十大擘画了以中国式现代化全面推进中华民族伟大复兴的宏伟蓝图。全面建设社会主义现代化国家，最艰巨最繁重的任务仍然在农村。世界百年未有之大变局加速演进，我国发展进入战略机遇和风险挑战并存、不确定难预料因素增多的时期，守好“三农”基本盘至关重要、不容有失。党中央认为，必须坚持不懈把解决好“三农”问题作为全党工作重中之重，举全党全社会之力全面推进乡村振兴，加快农业农村现代化。强国必先强农，农强方能国强。要立足国情农情，体现中国特色，建设供给保障强、科技装备强、经营体系强、产业韧性强、竞争能力强的农业强国。
          </p>
        </div>

        <div class="typo-line">
          <h4>
            <p class="category">2023年09月09日</p>习近平在黑龙江考察时强调 牢牢把握在国家发展大局中的战略定位 奋力开创黑龙江高质量发展新局面</h4>
        </div>
        <div class="typo-line">
          <p>
            <span class="category">摘要</span>新华社哈尔滨9月8日电 中共中央总书记、国家主席、中央军委主席习近平近日在黑龙江考察时强调，要牢牢把握在国家发展大局中的战略定位，扭住推动高质量发展这个首要任务，落实好党中央关于推动东北全面振兴的决策部署，扬长补短，把资源优势、生态优势、科研优势、产业优势、区位优势转化为发展新动能新优势，建好建强国家重要商品粮生产基地、重型装备生产制造基地、重要能源及原材料基地、北方生态安全屏障、向北开放新高地，在维护国家国防安全、粮食安全、生态安全、能源安全、产业安全中积极履职尽责，在全面振兴、全方位振兴中奋力开创黑龙江高质量发展新局面。
          </p>
        </div>

        <div class="typo-line">
          <h4>
            <p class="category">2023年03月08日</p>人民融观察·如何全面推进乡村振兴？</h4>
        </div>
        <div class="typo-line">
          <p>
            <span class="category">摘要</span>正值春耕备耕，田野生机勃勃。在人民网开展的2023年全国两会调查中，“乡村振兴”入选十大热词。今年全国两会上，全面推进乡村振兴成为代表委员的热议话题。人民融观察本期关注：全面推进乡村振兴。
          </p>
        </div>

        <div class="typo-line">
          <h4>
            <p class="category">2022年12月27日</p>人民网评：围绕“五个振兴”全面推进乡村振兴</h4>
        </div>
        <div class="typo-line">
          <p>
            <span class="category">摘要</span>农业兴则国家兴，全面推进乡村振兴是新时代建设农业强国的重要任务。习近平总书记在中央农村工作会议上强调：“要全面推进产业、人才、文化、生态、组织‘五个振兴’，统筹部署、协同推进，抓住重点、补齐短板。”这一重要部署高瞻远瞩、内涵丰富、要求明确，是新时代做好“三农”工作、全面推进乡村振兴的根本遵循和行动指南。
          </p>
        </div>

        <nav>
            <ul class="pagination">
              <li class="page-item" :class="{ disabled: currentPage === 1 }">
                <a class="page-link" @click="currentPage--">上一页</a>
              </li>
              <li class="page-item" v-for="page in totalPages" :key="page" :class="{ active: currentPage === page }">
                <a class="page-link" @click="currentPage = page">{{ page }}</a>
              </li>
              <li class="page-item" :class="{ disabled: currentPage === totalPages }">
                <a class="page-link" @click="currentPage++">下一页</a>
              </li>
            </ul>
          </nav>

      </div>    
    </card>
  </div>
 </div>
</template>
<script>
export default {};
</script>
<style>
</style>