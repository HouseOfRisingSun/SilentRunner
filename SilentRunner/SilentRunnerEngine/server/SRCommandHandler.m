//
//  SRCommandHandler.m
//  SilentRunner
//
//  Created by andrew batutin on 2/3/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "SRCommandHandler.h"

@implementation SRCommandHandler

+ (void)runCommand:(SRCommand*)command withError:(NSError**)error{
    @try {
        [[command commandInvocation] invoke];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:exception.name code:0 userInfo:exception.userInfo];
    }
}

@end
