//
//  SRServer+Utils.m
//  SilentRunner
//
//  Created by Andrew Batutin on 2/14/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "SRServer+Utils.h"

NSString* const SRErrorDomain = @"HomeOfRisingSun.SilentRunnerEngine";

@implementation SRServer (Utils)

static BOOL isE = NO;

inline void SRLog(NSString *format, ...)  {
    if ( ![SRServer isLoggerEnabled] ) { return; };
    __block va_list arg_list;
    va_start (arg_list, format);
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:arg_list];
    va_end(arg_list);
    NSLog(@"[SR] %@", formattedString);
}

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
