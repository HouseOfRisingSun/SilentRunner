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
    [[command commandInvocation] invoke];
}

@end
