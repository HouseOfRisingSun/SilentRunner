//
//  JSONRPCError.h
//  JSONRPCom
//
//  Created by andrew batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRPC.h"
#import "JSONRPCId.h"
#import "JSONRPCErrorModel.h"
#import "Mantle.h"

@interface JSONRPCErrorResponse : MTLModel <MTLJSONSerializing, JSONRPC, JSONRPCId>

@property (nonatomic, readonly, strong) JSONRPCErrorModel* error;

- (instancetype)initWithError:(JSONRPCErrorModel*)error version:(NSString*)version jrpcId:(NSString*)jrpcId;

@end
