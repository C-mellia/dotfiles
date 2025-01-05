import Main from "./Main.js";
import { html } from "lit-html";

export default ({ title }) => html` <main>${Main(title)}</main> `;
