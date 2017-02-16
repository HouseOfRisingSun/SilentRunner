//
//  SRServer+Utils.h
//  SilentRunner
//
//  Created by Andrew Batutin on 2/14/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <SilentRunnerEngine/SilentRunnerEngine.h>

@interface SRServer (Utils)

+ (void)enableLogging;
+ (void)disableLogging;
+ (BOOL)isLoggerEnabled;

@end

