//
//  JSONRPCError.m
//  JSONRPCom
//
//  Created by Andrew Batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "JSONRPCErrorResponse.h"

@implementation JSONRPCErrorResponse

@synthesize jrpcId = _jrpcId;
@synthesize version = _version;

- (instancetype)initWithError:(id)error version:(NSString*)version jrpcId:(NSString*)jrpcId{
    if (self == [super init]){
        _version = version;
        _error = error;
        _jrpcId = jrpcId;
    }
    return self;
}

+ (NSValueTransformer *)errorJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:JSONRPCErrorModel.class];
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{@"jrpcId":@"id",
             @"error":@"error",
             @"version":@"jsonrpc"};
}

@end
