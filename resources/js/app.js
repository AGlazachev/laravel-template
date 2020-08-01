Vue.config.devtools = true

const files = require.context('./components', true, /\.vue$/i);
files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default));

let app = new Vue({
    el: '#app',
    data: {},
});

document.addEventListener("DOMContentLoaded", function () {
//LazyLoad
    let LazyLoad = require('vanilla-lazyload');
    let lazyLoadInstance = new LazyLoad({
        use_native: true,
        elements_selector: '.lazy'
    });
});
