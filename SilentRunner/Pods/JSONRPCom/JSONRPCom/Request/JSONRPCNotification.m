//
//  JSONRPCNotification.m
//  JSONRPCom
//
//  Created by Andrew Batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "JSONRPCNotification.h"

@implementation JSONRPCNotification

@synthesize method = _method;
@synthesize params = _params;
@synthesize version = _version;

- (instancetype)initWithMethod:(NSString *)methodName params:(id)params version:(NSString*)version{
    if (self == [super init]){
        _method = methodName;
        _version = version;
        _params = params;
    }
    return self;
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{@"params":@"params",
             @"version":@"jsonrpc",
             @"method":@"method"};
}

@end
