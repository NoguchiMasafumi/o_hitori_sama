var body = new Vue({
    el: '#body_bg',
    data: {
      backgroundimageurl: {"background-image": "url('https://lh3.googleusercontent.com/_e032nu_ZF5VOtmpNL9wTy2mz1KRb4GAlLqb7uuyWguDhiqxtdF3AlqAxtVb_XyLno6zIf34_eaFAn6AyF_IwgMEWQyBvhzb-PYCoVr_lEC53-860wXjvw3YGdspprM1C2NAvYSp2S8=w1500-no?authuser=1')"}
    }
})


var example1 = new Vue({
  el: '#example-1',
  data: {
    counter: 0
  }
})




var vueIndex = new Vue({
  el: "#wrapper",
  data: {
      foods: "",
      food: {
          'fruits': ["りんご", "みかん", "ぶどう"],
          'vegetables': ["キャベツ", "じゃがいも", "なす"],
          'meats': ["鶏肉", "豚肉", "牛肉"]
      }
  },
  computed: {
      foodList() {
          return this.food[this.foods];
      }
  },
});






new Vue({
  el: '#demo',
  data: {
    show: true
  }
})






var app = new Vue({
  el: "#dream",
  data: {
    site_name:'angel'
  }
})