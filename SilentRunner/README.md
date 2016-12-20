# Silent Runner

##Intro

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

`{
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
}`

 