//
//  MTLJSONAdapter+Utils.m
//  JSONRPCom
//
//  Created by andrew batutin on 11/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "MTLJSONAdapter+Utils.h"

@implementation MTLJSONAdapter (Utils)

+ (NSDictionary*)JSONDictionaryFromModelNoNil:(id<MTLJSONSerializing>)model error:(NSError **)error{
    NSDictionary *originalDict = [MTLJSONAdapter JSONDictionaryFromModel:model error:error];
    
    if (!originalDict){
        return nil;
    }
    
    NSMutableDictionary* modifiedDictionaryValue = originalDict.mutableCopy;
    [self removeNSNullValuesFrom:modifiedDictionaryValue];
    return [modifiedDictionaryValue copy];
}

+ (void)removeNSNullValuesFrom:(NSMutableDictionary*)dictionary{
    NSMutableArray* keysArray = @[].mutableCopy;
    
    for (NSString *key in dictionary) {
        if ([dictionary[key] isKindOfClass:[NSDictionary class]]){
            [self removeNSNullValuesFrom:dictionary[key]];
        }
        if ([dictionary[key] isEqual:NSNull.null]) {
            [keysArray addObject:key];
        }
    }
    
    [dictionary removeObjectsForKeys:keysArray];
}

@end
