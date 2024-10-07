import fs from "fs/promises";
import { solution } from './src/solution.js';

let input = await (async () => (await fs.readFile("input", "utf8")).trim())();

for (const _ of input.trim().split("\n")) {
  const res = solution();
  console.log(res);
}
