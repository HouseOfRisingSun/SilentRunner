export default `{
 "jsonrpc": "2.0",
 "method": "execute",
 "params": {
   "commandId": "app",
   "method": "application:didReceiveRemoteNotification:",
   "arguments": [{
     "class": "UIApplication",
     "properties": [{
       "name": "delegate",
       "returnValue": "delegate"
     }, {
       "name": "isIdleTimerDisabled",
       "returnValue": "YES"
     }],
     "methods": [{
       "name": "isIgnoringInteractionEvents",
       "returnValue": "YES"
     }]
   }, {
     "value": {
       "aps": {"alert" :"Silent Hi!"}
     }
   }]
 }
}
`;
