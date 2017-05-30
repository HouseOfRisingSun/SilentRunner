'use strict';

const ws = require('nodejs-websocket');
//const example = require('./example');

let current_conn = undefined;
let server = undefined;

function connection(conn, io) {
  if (current_conn) {
    intel.error('Device already connected');
    return;
  }
  current_conn = conn;
  intel.verbose('Device connected');
  conn.on('close', () => disconnect(io));
  conn.on('text', (msg) => handleMessage(conn, msg, io));
  io.sockets.emit('device_ip', getDeviceIP());
}

function handleMessage(conn, msg, io) {
  intel.verbose('Handle message from device', msg);
  io.sockets.emit('receive_message', msg);
}

function disconnect(io) {
  intel.verbose('Device disconnected');
  current_conn = undefined;
  io.sockets.emit('device_ip', getDeviceIP());
  return;
}

function getDeviceIP() {
  if(current_conn){
    const socket = current_conn.socket;
    return socket.remoteAddress;
  }
  return '<disconnected>';
}

function send(msg) {
  if(current_conn){
    intel.info("Sending message to device:", msg);
    current_conn.send(msg);
  }
  else{
    intel.info("Requested sending message to device, but device not connected", msg);
  }
}

module.exports = {
  start: (clientIO, config) => {
    const port = config.devicePort;
    const addr = config.bindAddress;
    intel.info(`Starting device websocket server on port ${port}...`);
    server = ws.createServer((conn) => connection(conn, clientIO));
    server.listen(port, addr);
    intel.info('Device websocket server started.');
  },
  getDeviceIP,
  send,
};
