//
//  JSONRPCRequset.h
//  JSONRPCom
//
//  Created by andrew batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRPC.h"
#import "JSONRPCId.h"
#import "JSONRPCMethod.h"
#import "Mantle.h"

@interface JSONRPCRequst : MTLModel <MTLJSONSerializing, JSONRPC, JSONRPCId, JSONRPCMethod>

- (instancetype)initWithMethod:(NSString*)methodName params:(id)params version:(NSString*)version jrpcId:(NSString*)jrpcId;

@end
