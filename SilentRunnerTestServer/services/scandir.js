'use strict';

const readdir = Promise.promisify(require('fs').readdir);
const isFunction = require('lodash/isFunction');

function scandir(dir, each) {
  return readdir(dir).
  then((files) => {
    const out = [];
    for (const file of files) {
      if (file === 'index.js') continue;
      if (file.slice(-3) !== '.js') continue;
      if (isFunction(each)) {
        each(file, file.slice(0, -3));
      }
      out.push(file);
    }
    return out;
  });
}

module.exports = scandir;
