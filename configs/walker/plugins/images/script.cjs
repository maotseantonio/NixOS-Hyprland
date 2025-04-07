const fs = require("node:fs");
const path = require("node:path");

const folderPath = "/home/andrej/Pictures";

const isFile = (fileName) => {
  return fs.lstatSync(fileName).isFile();
};

const res = fs
  .readdirSync(folderPath)
  .map((fileName) => {
    return path.join(folderPath, fileName);
  })
  .filter(isFile);

res.forEach((i) => {
  console.log(
    `image=${i};label=${i};exec=xdg-open ${i};exec_alt=wl-copy < ${i};drag_drop=true;drag_drop_data=${i};class=pic;matching=1;`,
  );
});
