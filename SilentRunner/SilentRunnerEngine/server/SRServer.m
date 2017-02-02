//
//  SRServer.m
//  SilentRunner
//
//  Created by andrew batutin on 12/20/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRServer.h"
#import "SRCommand.h"
#import "NSURL+Validity.h"
#import <SocketRocket/SocketRocket.h>
#import <JSONRPCom/JSONRPCom.h>

@interface SRServer ()

@property (nonatomic, strong) SRWebSocket* webSocket;

@end

@implementation SRServer


- (instancetype)initWithURL:(NSString*)urlString{
    if (self == [super init]) {
        NSURL* url = [NSURL URLWithString:urlString];
        if ( ![url isValidWebSocket] ){ return nil; }
        _webSocket = [[SRWebSocket alloc] initWithURL:url];
        _webSocket.delegate = self;
    }
    return self;
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    
    if ( ![message isKindOfClass:NSString.class] ){ return; }
    
    [JSONRPCDeSerialization deSerializeString:message withJSONRPCRequset:^(JSONRPCRequest *data) {
        
    } orJSONRPCResponse:^(JSONRPCResponse *data) {
        
    } orJSONRPCNotification:^(JSONRPCNotification *data) {
        if ( ![data.params isKindOfClass:NSDictionary.class] ) { return; }
        SRCommand* entity = [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:data.params error:nil];
        NSInvocation* realResult = [entity commandInvocation];
        [realResult invoke];
        
        
    } orJSONRPCError:^(JSONRPCErrorResponse *data) {
        
    } serializationError:^(NSError *error) {
        
    }];
}

@end
