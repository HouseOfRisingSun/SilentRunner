//
//  SRValueArgument.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRValueArgument.h"

@implementation SRValueArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{@"argumentValue":@"value",
             };
}

@end
