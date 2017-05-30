'use strict';

const path = require('path');
const scandir = require('../services/scandir');
const dir = path.join(__dirname, './');

let inited = false;
const configs = {};

function get() {
  if (inited) {
    return Promise.resolve(configs);
  }
  return scandir(dir, function(file, name) {
    configs[name] = require(path.join(dir, file));
  }).
  then(() => {
    inited = true;  
    return configs;
  });
}

module.exports = get;
