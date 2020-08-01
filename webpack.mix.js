const mix = require('laravel-mix');

require('@ayctor/laravel-mix-svg-sprite');
let LiveReloadPlugin = require('webpack-livereload-plugin');
let StyleLintPlugin = require('stylelint-webpack-plugin');

mix.autoload({
    'vue': ['Vue','window.Vue'],
});

mix.webpackConfig({
    node: {
        fs: 'empty'
    },

    plugins: [
        new StyleLintPlugin({
            files: './resources/sass/**/*.scss',
            configFile: './.stylelintrc'
        }),
        new LiveReloadPlugin()
    ]
});

mix.js('resources/js/app.js', 'public/js').version()
    .sass('resources/sass/app.scss', 'public/css');

mix.options({
    postCss: [
        require('autoprefixer')({
            overrideBrowserslist: ['last 10 versions'],
        })
    ]
});

mix.svgSprite('resources/assets/img/icons-svg/*.svg', {
    output:  {
        filename: '../resources/assets/img/sprite.svg',
        svgo: {
            plugins: [{
                removeEmptyAttrs: true,
                convertStyleToAttrs: true,
            }],
        },
        chunk: {
            name: '/js/sprite',
            keep: true
        }
    },
    sprite: {
        prefix: false,
    }
});
mix.copyDirectory('resources/assets', 'public/assets');
