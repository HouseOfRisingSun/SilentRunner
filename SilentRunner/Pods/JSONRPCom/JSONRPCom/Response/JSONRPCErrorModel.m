//
//  JSONRPCErrorModel.m
//  JSONRPCom
//
//  Created by andrew batutin on 11/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "JSONRPCErrorModel.h"

@implementation JSONRPCErrorModel

- (instancetype)initWithMessage:(NSString*)message data:(id)data errorCode:(JSONRPCErrorModelError)code{
    if (self == [super init]){
        _message = message;
        _data = data;
        _code = code;
    }
    return self;
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{@"code":@"code",
             @"message":@"message",
             @"data":@"data"};
}

@end
