<template>
  <div id="embed">
    <div class="content">
      <primary-title />
      <share-link />
      <welcome />
      <sharing-services />
    </div>
  </div>
</template>

<script>
  import PrimaryTitle from './primary_title.vue'
  import ShareLink from './share_link.vue'
  import Welcome from './welcome.vue'
  import SharingServices from './sharing_services.vue'

  export default {
    components: {
      PrimaryTitle,
      ShareLink,
      Welcome,
      SharingServices
    }
  }
</script>
