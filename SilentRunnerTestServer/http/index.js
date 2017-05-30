'use strict';

const express = require('express');
const os = require('os');
const _ = require('lodash');
const path = require('path');
const socket = require('./socket');
const deviceWSServer = require('./deviceSocket');
const socketIO = require('socket.io');
const app = express();

function getIP(iface) {
  return ( 
    _.chain(os.networkInterfaces())
    .get(iface)
    .find(
      (val) => (val.family == 'IPv4' && val.internal == false)
    )
    .get('address')
    .value()
  );
}

function* http(config) {
  const protocol = (config.protocol === 'http' ? require('http') : require('https'));
  const server = protocol.Server(app);
  const io = socketIO(server);
  const serverIP = getIP(config.iface);
  intel.info('Server ip:', serverIP);
  config.ip = serverIP;
  socket.start(io, '', config);
  deviceWSServer.start(io, config);
  const rootPath = path.join(__dirname, config.staticDir);
  app.use(express.static(rootPath));
  intel.info('Starting static server...');
  server.listen(config.port, config.bindAddress, () => {
    intel.info('Server started at port', config.port, 'static path:', rootPath);
  });
}

module.exports = http;
