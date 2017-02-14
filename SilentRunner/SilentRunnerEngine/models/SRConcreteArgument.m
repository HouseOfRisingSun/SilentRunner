//
//  SRConcreteArgument.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRConcreteArgument.h"
#import "SRClassArgument.h"
#import "SRValueArgument.h"
#import "SRBlockArgument.h"

@implementation SRConcreteArgument

@dynamic argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{};
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    if ([JSONDictionary[@"class"] isEqualToString:@"block"]) {
        return SRBlockArgument.class;
    }
    
    if (JSONDictionary[@"class"] != nil) {
        return SRClassArgument.class;
    }
    
    if (JSONDictionary[@"value"] != nil) {
        return SRValueArgument.class;
    }
    
    NSAssert(NO, @"No matching class for the JSON dictionary '%@'.", JSONDictionary);
    return self;
}

@end
