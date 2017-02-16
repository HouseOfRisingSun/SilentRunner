//
//  NSDictionary+ToString.m
//  JSONRPCom
//
//  Created by Andrew Batutin on 12/6/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "NSDictionary+ToString.h"

@implementation NSDictionary (ToString)

- (NSString*)toJsonStringWithError:(NSError **)error{
    if (![NSJSONSerialization isValidJSONObject:self]){
        *error = [NSError errorWithDomain:@"json parse error" code:-32700 userInfo:@{@"reason":@"invalid fot JSON serialization"}];
        return nil;
    }
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:0 error:error];
    NSString* result =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!result){
        *error = [NSError errorWithDomain:@"json parse error" code:-32700 userInfo:@{@"reason":@"unable to create string from JSON"}];
    }
    return result;
}

@end
