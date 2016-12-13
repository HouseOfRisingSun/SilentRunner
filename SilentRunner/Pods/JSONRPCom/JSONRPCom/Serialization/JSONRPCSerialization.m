//
//  JSONRPCSerialization.m
//  JSONRPCom
//
//  Created by andrew batutin on 12/7/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "JSONRPCSerialization.h"
#import "NSDictionary+ToString.h"

@implementation JSONRPCSerialization

+ (NSString*)serializeEntity:(id<MTLJSONSerializing>)entity withError:(NSError**)error{
    NSDictionary* dict = [MTLJSONAdapter JSONDictionaryFromModel:entity error:error];
    NSString* result = [dict toJsonStringWithError:error];
    return result;
}

@end
