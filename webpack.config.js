var webpack = require('webpack');
var CompressionPlugin = require('compression-webpack-plugin');

module.exports = {
  context: __dirname + '/frontend',
  entry: {
    pc: './pc.js',
    sp: './sp.js',
  },
  output: {
    path: 'public',
    filename: '[name].js',
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel',
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.s?css$/,
        loaders: ['style', 'css', 'sass'],
      },
    ]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      output: { comments: false },
      compress: { warnings: false },
    }),
    new CompressionPlugin(),
  ],
  devtool: 'source-map',
};
