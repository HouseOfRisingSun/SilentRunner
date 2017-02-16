//
//  JSONRPCResponse.m
//  JSONRPCom
//
//  Created by Andrew Batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "JSONRPCResponse.h"

@implementation JSONRPCResponse

@synthesize jrpcId = _jrpcId;
@synthesize version = _version;

- (instancetype)initWithResult:(id)result version:(NSString*)version jrpcId:(NSString*)jrpcId{
    if (self == [super init]){
        _version = version;
        _result = result;
        _jrpcId = jrpcId;
    }
    return self;
}


+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{@"jrpcId":@"id",
             @"result":@"result",
             @"version":@"jsonrpc"};
}


@end
