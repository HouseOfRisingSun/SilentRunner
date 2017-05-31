import React, { Component } from 'react';
import io from 'socket.io-client';

import './App.css';
import DeviceDashboard from './DeviceDashboard';
import predefinedMessage1 from './predefinedMessage1';
import predefinedMessage2 from './predefinedMessage2';
import predefinedMessage3 from './predefinedMessage3';
import predefinedMessage4 from './predefinedMessage4';
import predefinedMessage5 from './predefinedMessage5';

const inputJSON = "";

const outputJSON = inputJSON;

function isValidJSON(str) {
  try{
    JSON.parse(str);
  }
  catch (e){
    return false;
  }
  return true;
}

function prettify(str) {
  try{
    return [
      true,
      JSON.stringify(JSON.parse(str), undefined, 4)
    ]
  }
  catch (e){
    return [
      false,
      str
    ]
  }
}

const predefinedMessages = [
  predefinedMessage1,
  predefinedMessage2,
  predefinedMessage3,
  predefinedMessage4,
  predefinedMessage5,
];

export default class App extends Component {
  constructor() {
    super();
    this.state = {
      serverIP: "?",
      deviceIP: "?",
      inputJSON,
      outputJSON,
      outputJSONValid: true,
      isThereError: false,
    };
  }

  componentDidMount() {
    const socket = io(`http://${window.location.host}/`);
    this.socket = socket;
    socket.on('server_ip', (msg) => {
      console.log("server_ip message");
      this.setState({serverIP: msg});
    });
    socket.on('device_ip', (msg) => {
      console.log("device_ip message");
      this.setState({deviceIP: msg});
    });
    socket.on('receive_message', (msg) => {
      console.log("receive_message message");
      const [valid, prettyMsg ] = prettify(msg);
      this.setState({
        outputJSONValid: valid,
        outputJSON: prettyMsg,
      });
    });
    console.log("App did mount");
  }

  predefinedButtonClick(msg) {
    this.setState({inputJSON: msg});
    this.sendMessage(msg);
  }

  sendMessage(msg) {
    this.setState({outputJSON: ""});
    this.socket.emit("send_message", msg);
  }

  render() {
    const isInputValid = isValidJSON(this.state.inputJSON);
    const validate = () => {
      this.setState();
    };
    const inputChange = (ev) => {
      console.log("input change");
      //this.state.inputJSON = ev.target.value;
      this.setState({inputJSON: ev.target.value});
    };
    const buttonCallbacks = [
      (e) => {this.predefinedButtonClick(predefinedMessages[0])},
      (e) => {this.predefinedButtonClick(predefinedMessages[1])},
      (e) => {this.predefinedButtonClick(predefinedMessages[2])},
      (e) => {this.predefinedButtonClick(predefinedMessages[3])},
      (e) => {this.predefinedButtonClick(predefinedMessages[4])},
    ];
    const props = {
      isInputValid,
      validate,
      inputChange,
      buttonCallbacks,
      runCallback: (e) => {this.sendMessage(this.state.inputJSON)},
      ...this.state
    };
    return <DeviceDashboard {...props} />
  }
}
