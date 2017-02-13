//
//  SRMessageHandler.m
//  SilentRunner
//
//  Created by andrew batutin on 2/2/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "SRMessageHandler.h"
#import <JSONRPCom/JSONRPCom.h>

@implementation SRMessageHandler

+ (nullable id<SRCommandProtocol>)createCommandFromMessage:(nullable NSString*)message withError:(void (^)(NSError* error))parseErrorHandler{
    __block id <SRCommandProtocol> command = nil;
    [JSONRPCDeSerialization deSerializeString:message withJSONRPCRequset:^(JSONRPCRequest *data) {
        
    } orJSONRPCResponse:^(JSONRPCResponse *data) {
        
    } orJSONRPCNotification:^(JSONRPCNotification *data) {
        if ( ![data.params isKindOfClass:NSDictionary.class] ) { command = nil; return; }
        NSError* error = nil;
        SRCommand* entity = [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:data.params error:&error];
        if ( error ) {
            command = nil;
            if ( parseErrorHandler ){
                parseErrorHandler(error);
            }
            return;
        }
        command = entity;
        
    } orJSONRPCError:^(JSONRPCErrorResponse *data) {
        
    } serializationError:^(NSError *error) {
        
    }];
    
    return command;
}

@end
