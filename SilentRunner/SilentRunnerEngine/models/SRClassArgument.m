//
//  SRClassArgument.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRClassArgument.h"
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

@implementation SRClassArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{    
    return @{@"className":@"class",
             @"properties":@"properties",
             @"methods":@"methods"
             };
}

- (id)argumentValue{
    id model = mock(NSClassFromString(self.className));
    NSString* methodName = self.methods[0][@"name"];
    given(([model performSelector:NSSelectorFromString(methodName)]));
    void* fPointer = (__bridge void *)([model performSelector:NSSelectorFromString(methodName)]);
    MKTOngoingStubbing* stb2 = MKTGivenWithLocation(self, __FILE__, __LINE__, fPointer);
    NSString* returnValue = self.methods[0][@"returnValue"];
    [stb2 willReturn:returnValue];
    
    return model;
}

MKTOngoingStubbing *myMKTGivenWithLocation(id testCase, const char *fileName, int lineNumber, ...)
{
    va_list args;
    va_start(args, lineNumber);
    for (int arg = lineNumber; arg != 0; arg = va_arg(args, int))
    {
        NSLog(@"");
    }
    
    va_end(args);
    return nil;
}



@end
