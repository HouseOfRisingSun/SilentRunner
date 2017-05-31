import React, { Component } from 'react';
import {
  Button,
  Col,
  Panel,
  Label,
  Grid,
} from 'react-bootstrap';
import styled from 'styled-components';

import solarized from './solarized';

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
    : props.valid
    ? solarized.green
    : solarized.yellow;
  const StyledMessage = styled(InputMessage)`
    background-color: ${color};
  `;
  return <StyledMessage {...props} />;
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
            Invalid Msg
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[1]}>
            Push Long Msg
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[2]}>
            Push Short Msg
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[3]}>
            DidLoad Msg
          </WideButton>
          <WideButton onClick={props.buttonCallbacks[4]}>
            WillTerminate Msg
          </WideButton>
        </SPanel>
      </Col>
      <Col xs={8}>
        <ButtonPanel>
          <PanelButton onClick={props.runCallback}>Run</PanelButton>
          <ValidationResult valid={props.isInputValid} />
        </ButtonPanel>
        <InputMessage value={props.inputJSON} onChange={props.inputChange}/>
        <OutputMessage
          value={props.outputJSON}
          isThereError={props.isThereError}
          valid={props.outputJSONValid}
          readOnly
        />
      </Col>
      <Col xs={2}>
        <ServerPanel>
          <TagPanel>Server</TagPanel>
          {props.serverIP}
        </ServerPanel>
      </Col>
    </Grid>
  </div>
);

export default DeviceDashboard;
