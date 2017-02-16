//
//  JSONRPCRequset.m
//  JSONRPCom
//
//  Created by Andrew Batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "JSONRPCRequest.h"

@implementation JSONRPCRequest

@synthesize method = _method;
@synthesize params = _params;
@synthesize jrpcId = _jrpcId;
@synthesize version = _version;

- (instancetype)initWithMethod:(NSString *)methodName params:(id)params version:(NSString*)version jrpcId:(NSString*)jrpcId{
    if (self == [super init]){
        _method = methodName;
        _version = version;
        _params = params;
        _jrpcId = jrpcId;
    }
    return self;
}


+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{@"jrpcId":@"id",
             @"params":@"params",
             @"version":@"jsonrpc",
             @"method":@"method"};
}

@end
