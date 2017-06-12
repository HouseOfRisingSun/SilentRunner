<h3 align="left" >
  <img valign="middle" src="https://raw.githubusercontent.com/HouseOfRisingSun/SilentRunner/master/assets/house_of_rising_sun.png">
  <b>SilentRunner</b>
</h3>

 [![Build Status](https://travis-ci.org/HouseOfRisingSun/SilentRunner.svg?branch=master)](https://travis-ci.org/andrewBatutin/SilentRunner)

 [![codecov](https://codecov.io/gh/HouseOfRisingSun/SilentRunner/branch/master/graph/badge.svg)](https://codecov.io/gh/HouseOfRisingSun/SilentRunner)

 [![codebeat badge](https://codebeat.co/badges/3b2fee2c-afc2-4410-9281-6b56224ee112)](https://codebeat.co/projects/github-com-andrewbatutin-silentrunner)

## Intro
Silent Runner is a RPC debugging tool for iOS platform. It allows to remotely trigger execution of any objective-c method.

Idea is simple:
1. Remote server sends to the app command with method invocation details
2. Silent runner invokes the method inside the iOS app.
3. Profit

Useful for
1. Push notifications testing
2. Analytic System calls testing
3. Any non-ui triggered method.


Samples of messages:

* Call push notification delegate method

```json
{
  "jsonrpc": "2.0",
  "method": "execute",
  "params": {
    "commandId": "app",
    "method": "application:didReceiveRemoteNotification:",
    "arguments": [
      {
        "class": "UIApplication",
        "properties": [
          {
            "name": "delegate",
            "returnValue": "delegate"
          },
          {
            "name": "isIdleTimerDisabled",
            "returnValue": "YES"
          }
        ],
        "methods": [
          {
            "name": "isIgnoringInteractionEvents",
            "returnValue": "YES"
          }
        ]
      },
      {
        "value": {
          "aps": {
            "alert": "Silent Hi!"
          }
        }
      }
    ]
  }
}
```
## Installation
SilentRunner supports multiple methods for installing the library in a project.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. You can install it with the following command:

  ```bash
  $ gem install cocoapods
  ```

#### Podfile

To integrate SilentRunner into your Xcode project using CocoaPods, specify it in your `Podfile`:

  ```ruby
  target 'TargetName' do

  pod 'SilentRunnerEngine'

  end
  ```

Then, run the following command:

  ```bash
  $ pod install
  ```

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

  ```bash
  $ brew update
  $ brew install carthage
  ```

To integrate SilentRunner into your Xcode project using Carthage, specify it in your `Cartfile`:

  ```ogdl
  github "HouseOfRisingSun/SilentRunner"
  ```

Run `carthage` to build the framework and drag the built `SilentRunner.framework` into your Xcode project.

## Usage

1. Use Cocoapod or Carthage distribution of **SilentRunnerEngine** to add lib to project.
2. Start testing server from [SilentRunnerTestServer](https://github.com/HouseOfRisingSun/SilentRunnerTestServer)
3. Connect to server from the app with:

  ```objective-c
      // register your app delegate to be callable from test server
      [SRClientPool addClient:[UIApplication sharedApplication].delegate forTag:@"app"];
      // create server instance
      self.server = [SRServer serverWithURL:@"http://192.168.190.163:1489" withErrorHandler:^(NSError * error) {
          [self.server sendErrorMessage:error];
      }];
      // run the engine
      self.server runServer:^(SRWebSocket *socket) {}];
  ```

4. Use [SilentRunnerTestServer](https://github.com/HouseOfRisingSun/SilentRunnerTestServer) admin page to send messages to the app.

If you'r testing some method make sure you've implemented it in your app.
So for push notifications check if you have `application:didReceiveRemoteNotification:` implemented

## Demo Apps

* [Obj-C demo app](https://github.com/HouseOfRisingSun/SilentRunnerDemo)
* [Swift demo app](https://github.com/HouseOfRisingSun/SRTestApp)

### Dependencies
* [SocketRocket](https://github.com/andrewBatutin/SocketRocket)
* [JSONRPCom](https://github.com/andrewBatutin/JSONRPCom)
* [Mantle](https://github.com/Mantle/Mantle)
* [OCHamcrest](https://github.com/hamcrest/OCHamcrest)
* [OCMockito](https://github.com/jonreid/OCMockito)

### TODO

* Formal protocol spec
* Support for batch requests
* Swift wrapper
* Mock params and return values for  block arguments
* more samples of test cases
