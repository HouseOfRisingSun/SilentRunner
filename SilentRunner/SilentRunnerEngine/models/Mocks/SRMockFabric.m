//
//  MockFabric.m
//  SilentRunner
//
//  Created by andrew batutin on 12/19/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRMockFabric.h"

@interface SRMockFabric ()

@property (nonatomic, strong) MKTBaseMockObject* mockModel;

@end

@implementation SRMockFabric

+ (MKTBaseMockObject*)mockWithModel:(NSDictionary*)model andClass:(Class)classValue{
    MKTClassObjectMock* staticModel = mockClass(classValue);
    MKTObjectMock* instanceModel = mock(classValue);
    MKTBaseMockObject* resultModel = nil;
    NSString* methodName = model[@"name"];
    SEL methodSel = NSSelectorFromString(methodName);
    
    if ( [staticModel respondsToSelector:methodSel] ){
        resultModel = staticModel;
    }else if ( [instanceModel respondsToSelector:methodSel] ){
        resultModel = instanceModel;
    }
    return resultModel;
}

+ (MKTBaseMockObject*)brewSomeMockWithDictionary:(NSDictionary*)dict andClass:(Class)classValue{
    MKTBaseMockObject* resultModel = [SRMockFabric mockWithModel:dict andClass:classValue];
    NSString* methodName = dict[@"name"];
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[resultModel methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:resultModel];
    
    for (int i = 2; i < inv.methodSignature.numberOfArguments; i++) {
        [SRMockFabric addAnythingWithInvocation:inv atIndex:i forModel:resultModel];
    }
    [inv invoke];
    if ( dict[@"returnValue"] ){
        id res = nil;
        [inv getReturnValue:&res];
        [given(res) willReturn:dict[@"returnValue"]];
    }
    return resultModel;
}


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
