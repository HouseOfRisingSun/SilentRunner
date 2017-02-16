//
//  JSONRPCResponse.h
//  JSONRPCom
//
//  Created by Andrew Batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRPC.h"
#import "JSONRPCId.h"
#import "Mantle.h"

@interface JSONRPCResponse : MTLModel <MTLJSONSerializing, JSONRPC, JSONRPCId>

@property (nonatomic, readonly, strong) id result;

- (instancetype)initWithResult:(id)result version:(NSString*)version jrpcId:(NSString*)jrpcId;

@end
