import path from "path";
import webpack from "webpack";
import HtmlWebpackPlugin from "html-webpack-plugin";

export default {
  mode: "development",

  entry: "./src/index.js",

  output: {
    path: path.resolve("dist"),
    filename: "bundle.js",
    publicPath: "/",
    clean: true,
  },

  resolve: {
    extensions: [".js", ".css"],
    alias: {
      components: path.resolve("src/components"),
      styles: path.resolve("src/styles"),
      assets: path.resolve("src/assets"),
      public: path.resolve("public"),
    },
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: "babel-loader",
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.(png|jpe?g|gif|ico)$/,
        type: "asset/resource",
      },
      {
        test: /\.svg$/,
        use: "svg-inline-loader",
      },
    ],
  },

  plugins: [
    new HtmlWebpackPlugin({
      favicon: path.resolve("public/favicon.ico"),
      publicPath: "/",
      filename: "index.html",
      inject: "body",
    }),
  ],

  devtool: "inline-source-map",
};
