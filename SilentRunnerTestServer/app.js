'use strict';

global.Promise = require('bluebird');
global.intel = require('intel');
const bootstrap = require('./bootstrap');

if (!module.parent) {
  const configs = require('./configs');
  configs().then(
    (configs) => bootstrap(configs)
  ).catch((err) => {
    intel.error('Bootstrap error');
    intel.error(err);
  });
}
else {
  module.exports = bootstrap;
}
