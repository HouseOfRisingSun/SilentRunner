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
@property (nonatomic, copy) void (^startHandler) (SRWebSocket*);
@property (nonatomic, copy) void (^stopHandler) (SRWebSocket*);

@end

@implementation SRServer

+ (nullable SRServer*)serverWithURL:(NSString*)url withMessageHandler:(nullable void (^)(NSString*))messageHandler withErrorHandler:(nullable void (^)(NSError*))errorHandler{
    SRServer* server = [[SRServer alloc] initWithURL:url];
    server.messageHandler = messageHandler;
    server.errorHandler = errorHandler;
    return server;
}

+ (nullable SRServer*)serverWithURL:(NSString*)url  withErrorHandler:(nullable void (^)(NSError*))errorHandler{
    SRServer* server = [[SRServer alloc] initWithURL:url];
    __block SRServer* theServer = server;
    server.messageHandler = ^(NSString * msg) {
        NSError* error = nil;
        SRCommand* command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:^(NSError* error){
            [theServer sendErrorMessage:error];
        }];
        [SRCommandHandler runCommand:command withError:&error];
        if ( error ){
            [theServer sendErrorMessage:error];
        }
    };
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

- (void)createWebSocket:(NSURL*)url{
    self.webSocket = [[SRWebSocket alloc] initWithURL:url];
    self.webSocket.delegate = self;
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

- (void)runServer:(void (^)(SRWebSocket*))handler{
    switch (self.webSocket.readyState) {
        case SR_OPEN:{
            [self closeServer:^(SRWebSocket * socket) {
                [self createWebSocket:self.webSocket.url];
                [self.webSocket open];
                self.startHandler = handler;
            }];
            break;
        }
        case SR_CLOSING:
        case SR_CLOSED:
            [self createWebSocket:self.webSocket.url];
        case SR_CONNECTING:
            [self.webSocket open];
            self.startHandler = handler;
            break;
        default:{
            NSString* reasonOfFail = [NSString stringWithFormat:@"WebSocket is not in correct state to open %ld", (long)self.webSocket.readyState];
            SRLog(reasonOfFail);
            NSError* error = [NSError errorWithDomain:SRErrorDomain code:SRErrorServerError userInfo:@{NSLocalizedDescriptionKey:reasonOfFail}];
            self.errorHandler(error);
            break;
        }
    }
}

- (void)closeServer:(void (^)(SRWebSocket*))handler{
    [self.webSocket close];
    self.stopHandler = handler;
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket*)webSocket{
    if( self.startHandler ){
        self.startHandler(webSocket);
    }
}

- (void)webSocket:(SRWebSocket*)webSocket didFailWithError:(NSError *)error{
    if (self.errorHandler) { self.errorHandler(error); }
}

- (void)webSocket:(SRWebSocket*)webSocket didReceiveMessage:(id)message{
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

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    if( self.stopHandler ){
        self.stopHandler(webSocket);
    }
}

@end
