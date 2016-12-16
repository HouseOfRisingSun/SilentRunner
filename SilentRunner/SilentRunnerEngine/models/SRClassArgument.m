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
    MKTOngoingStubbing* stb2 = given(([model performSelector:NSSelectorFromString(methodName)]));
    NSString* returnValue = self.methods[0][@"returnValue"];
    [stb2 willReturn:returnValue];
    
    
    //[MKTGiven([model propertyName]) willReturn:stubbedValue];
    MKTOngoingStubbing* stbPr = given(([model performSelector:NSSelectorFromString(self.properties[0][@"name"])]));
    [stbPr willReturn:self.properties[0][@"returnValue"]];
    [MKTGiven([model valueForKey:@"absoluteString"]) willReturn:self.properties[0][@"returnValue"]];
    [MKTGiven([model valueForKeyPath:@"absoluteString"]) willReturn:self.properties[0][@"returnValue"]];
    
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
