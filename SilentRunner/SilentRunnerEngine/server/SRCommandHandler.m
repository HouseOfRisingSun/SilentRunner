//
//  SRCommandHandler.m
//  SilentRunner
//
//  Created by Andrew Batutin on 2/3/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "SRCommandHandler.h"
#import "SRServer+Utils.h"

@implementation SRCommandHandler

+ (void)runCommand:(SRCommand*)command withError:(NSError**)error{
    @try {
        [[command commandInvocation] invoke];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:SRErrorDomain code:SRErrorInvokeError userInfo:@{exception.reason:exception.callStackSymbols}];
    }
}

@end
