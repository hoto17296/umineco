var webpack = require('webpack');
var CompressionPlugin = require('compression-webpack-plugin');

var config = {
  context: __dirname + '/frontend',
  entry: {
    pc: './pc.js',
    sp: './sp.js',
    admin: './admin.js',
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
};

if ( process.env.NODE_ENV === 'production' ) {
  config.plugins = [ new CompressionPlugin() ];
}

module.exports = config;
