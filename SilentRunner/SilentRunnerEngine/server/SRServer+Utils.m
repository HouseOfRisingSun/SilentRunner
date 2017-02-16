//
//  SRServer+Utils.m
//  SilentRunner
//
//  Created by Andrew Batutin on 2/14/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "SRServer+Utils.h"

@implementation SRServer (Utils)

static BOOL isE = NO;

+ (void)enableLogging{
    isE = YES;
}

+ (void)disableLogging{
    isE = NO;
}

+ (BOOL)isLoggerEnabled{
    return isE;
}

@end
