//
//  SRServer.m
//  SilentRunner
//
//  Created by andrew batutin on 12/20/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRServer.h"
#import "SRCommand.h"
#import "SRServer+Utils.h"
#import "NSURL+Validity.h"
#import <SocketRocket/SocketRocket.h>
#import <JSONRPCom/JSONRPCom.h>

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
    JSONRPCErrorModel* model = [[JSONRPCErrorModel alloc] initWithMessage:error.description data:error.userInfo errorCode:JSONRPCErrorModelParseError];
    JSONRPCErrorResponse* resp = [[JSONRPCErrorResponse alloc] initWithError:model version:@"2.0" jrpcId:@"0"];
    NSString* msg = [JSONRPCSerialization serializeEntity:resp withError:nil];
    [self.webSocket send:msg];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    SRLog(@"%@ %@", NSStringFromSelector(_cmd), self);
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    SRLog(@"%@ %@, %@", NSStringFromSelector(_cmd), self, error);
    if (self.errorHandler) { self.errorHandler(error); }
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    SRLog(@"%@ %@", NSStringFromSelector(_cmd), self);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    SRLog(@"%@ %@", NSStringFromSelector(_cmd), self);
    if ( ![message isKindOfClass:NSString.class] ){ return; }
    if (self.messageHandler){ self.messageHandler(message); }
}


@end
