<!--
 * @Author: RookieLinLucy666 18810911883@163.com
 * @Date: 2023-09-05 15:25:34
 * @LastEditors: RookieLinLucy666 18810911883@163.com
 * @LastEditTime: 2023-09-14 17:16:09
 * @FilePath: /frontend/src/pages/UserProfile.vue
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
<template>
    <div class="row">
      <div class="col-xl-12 col-lg-7 col-md-6">
        <!-- <user-card>

        </user-card> -->

        <edit-profile-form>

        </edit-profile-form>

        <members-card>

        </members-card>
      </div>
    </div>
</template>
<script>
import EditProfileForm from "./UserProfile/EditProfileForm.vue";
import UserCard from "./UserProfile/UserCard.vue";
import MembersCard from "./UserProfile/MembersCard.vue";
export default {
  components: {
    EditProfileForm,
    // UserCard,
    MembersCard
  }
};
</script>
<style>
</style>
