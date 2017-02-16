//
//  SRServer.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/20/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <SilentRunnerEngine/SilentRunnerEngine.h>
#import <JSONRPCom/JSONRPCom.h>
#import "SRServer+Utils.h"

NSString* const SRErrorDomain = @"HomeOfRisingSun.SilentRunnerEngine";

inline void SRLog(NSString *format, ...)  {
    if ( ![SRServer isLoggerEnabled] ) { return; };
    __block va_list arg_list;
    va_start (arg_list, format);
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:arg_list];
    va_end(arg_list);
    NSLog(@"[SR] %@", formattedString);
}


@interface SRServer ()

@property (nonatomic, strong) SRWebSocket* webSocket;
@property (nonatomic, copy) void (^messageHandler) (NSString*);
@property (nonatomic, copy) void (^errorHandler) (NSError*);


@end

@implementation SRServer

+ (nullable SRServer*)serverWithURL:(NSString*)url withMessageHandler:(nullable void (^)(NSString*))messageHandler withErrorHandler:(nullable void (^)(NSError*))errorHandler{
    SRServer* server = [[SRServer alloc] initWithURL:url];
    server.messageHandler = messageHandler;
    server.errorHandler = errorHandler;
    return server;
}


- (nullable instancetype)initWithURL:(NSString*)urlString{
    if (self == [super init]) {
        NSURL* url = [NSURL URLWithString:urlString];
        if ( ![url isValidWebSocket] ){ return nil; }
        _webSocket = [[SRWebSocket alloc] initWithURL:url];
        _webSocket.delegate = self;
    }
    return self;
}

- (void)sendErrorMessage:(NSError*)error{
    if ( self.webSocket.readyState != SR_OPEN ){
        SRLog(@"WebSocket is not open");
        return;
    }
    JSONRPCErrorModel* model = [[JSONRPCErrorModel alloc] initWithMessage:error.description data:(id<MTLJSONSerializing>)error.userInfo errorCode:JSONRPCErrorModelParseError];
    JSONRPCErrorResponse* resp = [[JSONRPCErrorResponse alloc] initWithError:model version:@"2.0" jrpcId:@"0"];
    NSString* msg = [JSONRPCSerialization serializeEntity:resp withError:nil];
    [self.webSocket send:msg];
}

- (void)runServer{
    if ( self.webSocket.readyState == SR_CONNECTING ){
        [self.webSocket open];
    }else{
        SRLog(@"WebSocket is not in correct state to open");
    }
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    if (self.errorHandler) { self.errorHandler(error); }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    if ( ![message isKindOfClass:NSString.class] ){
        SRLog(@"Only strings allowed to be received");
        return;
    }
    if ( self.webSocket.readyState != SR_OPEN ){
        SRLog(@"WebSocket is not open");
        return;
    }
    if (self.messageHandler){ self.messageHandler(message); }
}


@end
