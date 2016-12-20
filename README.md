# Silent Runner

##Intro
![alt text][logo]
[logo]:http://vignette1.wikia.nocookie.net/eastenders/images/f/f6/Under-construction.png/revision/latest?cb=20141120185311

Silent Runner is a testing tool for iOS to trigger some method calls remotly

Idea is simple: 
1. Remote server sends to the app message with method invocation details
2. Silent runner invokes the method.
3. Profit

Usefull for
1.	Push notifications testing
2. Analytic System calls
3. Operation System calls

Smaples of messages:

* Add item to array
```javascript
{
	"jsonrpc": "2.0",
	"method": "execute",
	"params": { 
			"commandId": "objTag",
			"method": "addObject:",
			"arguments": [{
				"class": "NSURL",
				"methods": [{
				"name": "URLWithString",
				"returnValue": "mock data"
			}, {
				"name": "fileURLWithPath",
				"returnValue": "mock path"
			}]
		}]
	}
}
```

* Call `openURL:options:completionHandler:` method
```javascript
{
    "jsonrpc": "2.0",
    "method": "execute",
    "params": {
        "commandId": "UIApplication",
        "method": "openURL:options:completionHandler:",
        "arguments": [{
            "class": "NSURL",
            "properties": [{
                "name": "absoluteString",
                "value": "https://github.com/andrewBatutin/SilentRunner"
            }, {
                "name": "relativeString",
                "value": "https://github.com/andrewBatutin/SilentRunner"
            }],
            "methods": [{
                "name": "isFileReferenceURL",
                "returnValue": "1"
            }, {
                "name": "fileReferenceURL",
                "returnValue": "mock reference"
            }]
        }, {
            "value": {
                "opt1": "test"
            }
        }, {
            "class": "block",
            "methods": {
                "name": "invoke:",
                "returnValue": "smthng"
            }
        }]
    }
}
```


###Dependecies
* [SocketRocket](https://github.com/facebook/SocketRocket)
* [JSONRPCom](https://github.com/andrewBatutin/JSONRPCom)

###TODO

* Formal protocol spec
* Protocol parser implementation
* Mock objects parser
* Invocation engine
* WebSocket integration

 