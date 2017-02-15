//
//  SRServer+Utils.h
//  SilentRunner
//
//  Created by Andrew Batutin on 2/14/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "SRServer.h"

extern NSString* const SRErrorDomain;

typedef enum{
    SRErrorParseError = -101,
    SRErrorInvokeError = -102,
} SRErrorCode;


@interface SRServer (Utils)

void SRLog(NSString *format, ...);
+ (void)enableLogging;
+ (void)disableLogging;
+ (BOOL)isLoggerEnabled;

@end

