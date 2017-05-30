'use strict';

const http = require('./http');

function* bootstrap(configs) {
  yield* http(configs.http);
}

const coroutine = Promise.coroutine(bootstrap);
module.exports = coroutine;
