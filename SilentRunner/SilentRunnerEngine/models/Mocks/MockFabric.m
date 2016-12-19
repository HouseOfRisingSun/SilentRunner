//
//  MockFabric.m
//  SilentRunner
//
//  Created by andrew batutin on 12/19/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "MockFabric.h"

@implementation MockFabric


+ (void)addMockForValue:(void*)value withInvocation:(NSInvocation*)inv atIndex:(NSInteger)index{
    [inv setArgument:&value atIndex:index];
}

+ (void)addAnythingWithInvocation:(NSInvocation*)inv atIndex:(NSInteger)index forModel:(MKTBaseMockObject*)model{
    HCIsAnything* anything = [[HCIsAnything alloc] init];
    const char * type = [inv.methodSignature getArgumentTypeAtIndex:index];
    
    if (!strcmp(type, @encode(BOOL))){
        BOOL arg = NO;
        [inv setArgument:&arg atIndex:index];
        [model withMatcher:[[HCIsAnything alloc] init] forArgument:index];
    }else if ( !strcmp(type, @encode(id))){
        [inv setArgument:&anything atIndex:index];
    }else{
        long long arg = 0;
        [inv setArgument:&arg atIndex:index];
        [model withMatcher:[[HCIsAnything alloc] init] forArgument:index];
    }
    
    
}


@end
