var webpack = require('webpack');

module.exports = {
  entry: './src/app.js',
  output: {
    path: 'dist',
    filename: 'bundle.js',
    sourceMapFilename: 'bundle.map'
  },
  module: {
    loaders: [{
      test: /\.scss$/,
      loaders: ["style", "css", "sass"]
    }, {
      test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      loader: "url-loader?name=./dist_files/[hash].[ext]&limit=10000&mimetype=application/font-woff"
    }, {
      test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      loader: "file-loader?name=./dist_files/[hash].[ext]"
    }, {
      test: /\.(jpg|jpeg|gif|png|ico|svg|xml|json|html)$/,
      exclude: /node_modules/,
      loader: 'file-loader?name=[path][name].[ext]&context=./src'
    }]
  },
  devtool: 'source-map',
  plugins: new webpack.optimize.UglifyJsPlugin({
    minimize: true
  })
};
