import React, { Component } from 'react';
import {
  Button,
  Col,
  Panel,
  Label,
  Grid,
  Row,
} from 'react-bootstrap';
import io from 'socket.io-client';
import styled from 'styled-components';
import solarized from './solarized';
import './App.css';

const inputJSON = "";

const outputJSON = inputJSON;


const WideButton = styled(Button)`
    background-color: ${solarized.base2};
    color: ${solarized.base01};
    margin: 2px;
    width: 100%;
`;

const TagPanel = styled.div`
    padding: 5px;
    border-radius: 3px;
    background-color: ${solarized.base02};
    color: ${solarized.base1};
    border-color: ${solarized.base2};
    border-style: solid;
    border-width: 1px;
`;

const SPanel = styled(Panel)`
    background-color: ${solarized.base1};
    color: ${solarized.base03};
    align: left;
`;

const ServerPanel = styled(SPanel)`
`;

const ButtonPanel = styled.div`
    padding: 3px;
    border-radius: 3px;
    margin-bottom: 5px;
    text-align: left;
    background-color: ${solarized.base1};
`;

const PanelButton = styled(Button)`
    margin: 10px;
    background-color: ${solarized.base2};
    color: ${solarized.base01};
`;

const InputMessage = styled.textarea`
    color: black;
    height: 300px;
    border-radius: 3px;
    background-color: ${solarized.green};
    width: 100%;
    font-size: 16px;
    font-family: Courier;
`;

const OutputMessage = (props) => {
  const color = props.isThereError
    ? solarized.red
    : solarized.green;
  const StyledMessage = styled(InputMessage)`
    background-color: ${color};
  `;
  return <StyledMessage {...props} />;
}

function isValidJSON(str) {
  try{
    JSON.parse(str);
  }
  catch (e){
    return false;
  }
  return true;
}

const ValidationResult = ({valid}) => {
  let textColor = solarized.green;
  let text = "Valid";
  if(!valid) {
    textColor = solarized.red;
    text = "Invalid";
  }
  const ResultLabel = styled(Label)`
    color: ${textColor};
    background-color: ${solarized.base03};
    margin: 10px;
    font-size: 20px;
    vertical-align: middle;
    height: 100%;
  `;
  return <ResultLabel>{text}</ResultLabel>;
};

const DeviceDashboard = (props) => (
  <div className="App">
    <Grid>
      <Col xs={2}>
        <SPanel>
          <TagPanel>Device</TagPanel>
          IP: {props.deviceIP}
        </SPanel>
        <SPanel>
          <WideButton onClick={props.buttonCallbacks[0]}>
            Message 1
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[1]}>
            Message 2
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[2]}>
            Message 3
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[3]}>
            Message 4
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[4]}>
            Message 5
          </WideButton>
        </SPanel>
      </Col>
      <Col xs={8}>
        <ButtonPanel>
          <PanelButton onClick={props.runCallback}>Run</PanelButton>
          <ValidationResult valid={props.isInputValid} />
        </ButtonPanel>
        <InputMessage defaultValue={props.inputJSON} onChange={props.inputChange}/>
        <OutputMessage value={props.outputJSON} isThereError={props.isThereError} readOnly />
      </Col>
      <Col xs={2}>
        <ServerPanel>
          <TagPanel>Server</TagPanel>
          IP: {props.serverIP}
        </ServerPanel>
      </Col>
    </Grid>
  </div>
);

const predefinedMessages = [
  `{["this is invalid message",
  ]`,
  `["push message"]`,
  `{"message": "Test Message 1",
  }`,
  `Test Message
  number 2`,
  `Test Message
  number 4`,
];

export default class App extends Component {
  constructor() {
    super();
    this.state = {
      serverIP: "?",
      deviceIP: "?",
      inputJSON,
      outputJSON,
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
      this.setState({outputJSON: msg});
    });
    console.log("App did mount");
  }

  sendMessage(msg) {
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
      (e) => {this.sendMessage(predefinedMessages[0])},
      (e) => {this.sendMessage(predefinedMessages[1])},
      (e) => {this.sendMessage(predefinedMessages[2])},
      (e) => {this.sendMessage(predefinedMessages[3])},
      (e) => {this.sendMessage(predefinedMessages[4])},
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
