import path from "path";
import express from "express";
import webpack from "webpack";
import webpackDebMiddleware from "webpack-dev-middleware";
import config from "./webpack.config.js";

const PORT = 3000;
const app = express();
const compiler = webpack(config);

app.use(
  webpackDebMiddleware(compiler, {
    publicPath: config.output.publicPath,
  }),
);

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send("Something broke!");
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
