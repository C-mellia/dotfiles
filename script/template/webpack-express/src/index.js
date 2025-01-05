import "styles/main.css";
import App from "components/App";
import { html, render } from "lit-html";

const appRoot = document.createElement("div");
appRoot.id = "app";
appRoot.className = "app";
document.body.appendChild(appRoot);

const appRender = (title) => render(App({ title }), appRoot);

appRender("Webpack + Express!");
