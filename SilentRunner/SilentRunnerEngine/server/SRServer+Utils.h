//
//  SRServer+Utils.h
//  SilentRunner
//
//  Created by andrew batutin on 2/14/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "SRServer.h"



@interface SRServer (Utils)

void SRLog(NSString *format, ...);
+ (void)enableLogging;
+ (void)disableLogging;
+ (BOOL)isLoggerEnabled;

@end

