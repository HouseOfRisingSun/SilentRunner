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
#import "SRConcreteArgument.h"

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

+ (NSValueTransformer *)parametrsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:SRConcreteArgument.class];
}

- (NSInvocation*)commandInvocation{
    NSInvocation* inv = [NSInvocation invocationWithTarget:[SRClientPool clientForTag:self.commandId] selector:NSSelectorFromString(self.method)];
    int i = 2;
    for (id<SRArgument> parameter in self.parametrs){
        id argValue = parameter.argumentValue;
        [inv setArgument:&argValue atIndex:i];
        i++;
    }
    return inv;
}

@end
