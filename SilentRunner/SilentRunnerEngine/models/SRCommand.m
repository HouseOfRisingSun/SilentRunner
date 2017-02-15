//
//  SRCommand.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/13/16.
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
    for ( int i = 2; i < inv.methodSignature.numberOfArguments; i++ ){
        id<SRArgument> parameter = nil;
        if ( (i - 2) < self.parametrs.count ){
            parameter  = self.parametrs[i - 2];
        }
        id argValue = parameter.argumentValue;
        [inv setArgument:&argValue atIndex:i];
    }
    return inv;
}

@end
