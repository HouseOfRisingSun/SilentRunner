'use strict';

const _ = require('underscore');
const os = require('os');

//const handlers = require('./handlers');
const deviceWS = require('./deviceSocket');

const sendMessage = Promise.coroutine(function* (socket, io, deviceIO, msg) {
  intel.verbose('sendMessage', msg);
  deviceWS.send(msg);
});

function connection(socket, io, deviceIO, config) {
  const addr = socket.request.connection.remoteAddress;
  const port = socket.request.connection.remotePort;
  //intel.verbose("server ip:", config.ip); 
  intel.verbose(`Browser connected from ${addr}:${port}`);
  //intel.verbose('DeviceIO:', deviceIO);
  socket.on('send_message', (msg) => sendMessage(socket, io, deviceIO, msg));
  socket.emit('server_ip', config.ip); 
  socket.emit('device_ip', deviceWS.getDeviceIP());
}

module.exports = {
  start: (io, deviceIO, config) => {
    io.on('connection', (socket) => connection(socket, io, deviceIO, config))
  },
};
