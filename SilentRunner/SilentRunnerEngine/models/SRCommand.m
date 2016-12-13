//
//  SRCommand.m
//  SilentRunner
//
//  Created by andrew batutin on 12/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRCommand.h"
#import "SRClientPool.h"
#import "NSInvocation+Constructors.h"

@implementation SRCommand

@synthesize commandId;
@synthesize parametrs;
@synthesize method;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{@"commandId":@"commandId",
             @"parametrs":@"arguments",
             @"method":@"method"
             };
}

- (NSInvocation*)commandInvocation{
    return [NSInvocation invocationWithTarget:[SRClientPool clientForTag:self.commandId] selector:NSSelectorFromString(self.method)];
}

@end
