<h3 align="left" >
  <img valign="middle" src="https://github.com/andrewBatutin/SilentRunner/blob/master/assets/house_of_rising_sun.png?raw=true">
  <b>SilentRunner</b>
</h3>

 [![Build Status](https://travis-ci.org/andrewBatutin/SilentRunner.svg?branch=master)](https://travis-ci.org/andrewBatutin/SilentRunner)

 [![codecov](https://codecov.io/gh/andrewBatutin/SilentRunner/branch/master/graph/badge.svg)](https://codecov.io/gh/andrewBatutin/SilentRunner)

 [![codebeat badge](https://codebeat.co/badges/3b2fee2c-afc2-4410-9281-6b56224ee112)](https://codebeat.co/projects/github-com-andrewbatutin-silentrunner)

##Intro
Silent Runner is a testing tool for iOS to trigger some method calls remotely

Idea is simple:
1. Remote server sends to the app message with method invocation details
2. Silent runner invokes the method inside the iOS app.
3. Profit

Useful for
1. Push notifications testing
2. Analytic System calls testing


Samples of messages:

* Call push notification delegate method
```javascript
{
    "jsonrpc": "2.0",
    "method": "execute",
    "params": {
        "commandId": "app",
        "method": "application:didReceiveRemoteNotification:fetchCompletionHandler:",
        "arguments": [{
            "class": "UIApplication",
            "properties": [{
                "name": "delegate",
                "value": "https://github.com/andrewBatutin/SilentRunner"
            }],
            "methods": [{
                "name": "isIgnoringInteractionEvents",
                "returnValue": "YES"
            }]
        }, {
            "value": {
                "opt1": "test"
            }
        },
        {
            "block": {
                "returnValue": "notUsed"
                      }
        }]
    }
}

```
## Usage

0. Use Cocoapod **SilentRunnerEngine** to add lib to project.
1. Start testing server from **SilentRunnerTestServer**
2. Connect to server from the app with:
```objective-c
    // register your app delegate to be callable from test server
    [SRClientPool addClient:[UIApplication sharedApplication].delegate forTag:@"app"];
    // create server instance
    self.serv = [SRServer serverWithURL:@"ws://localhost:9000/chat"  withErrorHandler:^(NSError * error) {
        [self.serv sendErrorMessage:error];
    }];
    // run the engine
    [self.serv runServer];
```
3. use **SilentRunnerTestServer** admin page to send messages.

If you'r testing some method make sure you've implemented it in your app.
So for push notifications check if you have `application:didReceiveRemoteNotification:fetchCompletionHandler:` implemented

###Dependecies
* [SocketRocket](https://github.com/facebook/SocketRocket)
* [JSONRPCom](https://github.com/andrewBatutin/JSONRPCom)

###TODO

* Formal protocol spec
* Support for batch requests
* Swift wrapper
* Mock params and return values for  block arguments
* more samples of test cases
