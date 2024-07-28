const path    = require("path")
const webpack = require("webpack")

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: "./app/javascript/application.js"
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx', '.json'],
    alias: {
      '@hotwired/stimulus': path.resolve(__dirname, 'node_modules/@hotwired/stimulus'),
      '@hotwired/stimulus-webpack-helpers': path.resolve(__dirname, 'node_modules/@hotwired/stimulus-webpack-helpers')
    },
    fallback: {
      "fs": false,
      "path": false,
      "os": false
    }
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
}
