//
//  JSONRPCRequest.h
//  JSONRPCom
//
//  Created by Andrew Batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRPC.h"
#import "JSONRPCId.h"
#import "JSONRPCMethod.h"
#import <Mantle/Mantle.h>

@interface JSONRPCRequest : MTLModel <MTLJSONSerializing, JSONRPC, JSONRPCId, JSONRPCMethod>

- (instancetype)initWithMethod:(NSString*)methodName params:(id)params version:(NSString*)version jrpcId:(NSString*)jrpcId;

@end
