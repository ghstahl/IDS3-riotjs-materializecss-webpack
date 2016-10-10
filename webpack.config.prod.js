var path = require('path'),
    libPath = path.join(__dirname, 'lib'),
    wwwPath = path.join(__dirname, 'www'),
    pkg = require('./package.json'),
    webpack = require("webpack"),
    minimize = process.argv.indexOf('--minimize') !== -1,
    HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry: {

     //   vendors: path.join(libPath, 'vendors.js'),
        index: path.join(libPath, 'index', 'index.js')


    },
    output: {
        path: path.join(wwwPath, 'js'),
        filename: '[name].js'
    },
    module: {
        preLoaders: [
            { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs-loader', query: { type: 'babel' } }
        ],
        loaders: [{
            test: /\.html$/,
            loader: 'html'
        }, {
            test: /\.json$/,
            loader: "json"
        }, {
            test: /\.(png|jpg)$/,
            loader: 'file?name=img/[name].[ext]'
        }, {
            test: /\.css$/,
            loader: "style!css"
        }, {
            test: /\.js$|\.tag$/,
            exclude: /(node_modules)/,
            loader: "babel",
            query: {
                presets: ['es2015']
            }
        }, {
            test: /\.scss$/,
            loader: "style!css!autoprefixer!sass"
        },
            { test: /\.(woff2?|ttf|eot|svg)$/, loader: 'url?limit=10000' },
            {
            test: [/MaterialIcons-Regular.eot/, /MaterialIcons-Regular.woff2/, /MaterialIcons-Regular.woff/, /MaterialIcons-Regular.ttf/],
            loader: 'file?name=fonts/[name].[ext]'
        }]
    },
    resolve: {
        extensions: ['', '.js', '.json', '.scss', '.html', '.ts'],
        root: [
            libPath,
            path.join(__dirname, 'node_modules')
        ],
        moduleDirectories: [
            'node_modules'
        ]
    },
    plugins: [
        new webpack.ProvidePlugin({
            riot: 'riot'
        }),
        new HtmlWebpackPlugin({
            filename: 'index.html',
            title: pkg.title,
            chunks: ['vendors', 'style', 'index'],
            inject: 'body',
            hash: true,
            pkg: pkg,
            template: path.join(libPath, 'index', 'index.html')
        }),
        new webpack.ProvidePlugin({
            $: "jquery",
            jQuery: "jquery",
            "window.jQuery": "jquery"
        }),

        new webpack.optimize.UglifyJsPlugin({
            compress: {
                warnings: false
            }
        })

    ],
    devServer: {
        contentBase: './build/',
        port: 1447,
        hot: true,
        inline: true
    }
};
