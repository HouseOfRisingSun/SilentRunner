//
//  JSONRPCErrorModel.h
//  JSONRPCom
//
//  Created by Andrew Batutin on 11/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

typedef enum{
    JSONRPCErrorModelParseError = -32700,
    JSONRPCErrorModelInvalidRequest = -32600,
    JSONRPCErrorModelMethodNotFound = -32601,
    JSONRPCErrorModelInvalidParams = -32602,
    JSONRPCErrorModelInternalError = -32603,
    JSONRPCErrorModelServerError = -32000,
}JSONRPCErrorModelError;

@interface JSONRPCErrorModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly, assign) JSONRPCErrorModelError code;
@property (nonatomic, readonly, copy) NSString* message;
@property (nonatomic, readonly, strong) id data;

- (instancetype)initWithMessage:(NSString*)message data:(id<MTLJSONSerializing>)data errorCode:(JSONRPCErrorModelError)code;

@end
