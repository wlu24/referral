import Vue from 'vue/dist/vue.esm'
import App from '../embed/app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const embed = new Vue({
    el: '#embed',
    render: h => h(App)
  })
})
