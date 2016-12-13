//
//  NSString+ToJSONDictionary.m
//  JSONRPCom
//
//  Created by andrew batutin on 12/6/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "NSString+ToJSONDictionary.h"

@implementation NSString (ToJSONDictionary)

- (NSDictionary*)toJSONDictionaryWithError:(NSError **)error{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (!data){
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (!result){
        return nil;
    }
    
    if ( ![result isKindOfClass:NSDictionary.class] ){
        NSError* wrongClassError = [NSError errorWithDomain:@"JSON parsing error" code:-32700 userInfo:@{@"reason":@"Dictionary model expected"}];
        if (error){
            *error = wrongClassError;
        }
        return nil;
    }
    return result;
}

@end
