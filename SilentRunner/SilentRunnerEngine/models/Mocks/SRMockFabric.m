//
//  MockFabric.m
//  SilentRunner
//
//  Created by andrew batutin on 12/19/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRMockFabric.h"
#import "SRServer+Utils.h"

static NSString* const SRMockFabricMethodNameKey = @"name";
static NSString* const SRMockFabricReturnValueKey = @"returnValue";

@interface SRMockFabric ()

@property (nonatomic, strong) MKTBaseMockObject* mockModel;

@end

@implementation SRMockFabric

+ (MKTObjectMock*)mockWithClass:(Class)classValue{
    MKTObjectMock* instanceModel = mock(classValue);
    return instanceModel;
}

+ (void)addMethodsWithDictionary:(NSDictionary*)dict toModel:(MKTObjectMock*)model withError:(NSError**)error{
    NSString* methodName = dict[SRMockFabricMethodNameKey];
    SEL methodSel = NSSelectorFromString(methodName);
    
    if ( [self isStaticMethod:dict atClass:model] ) {
         if (error) {
             *error = [NSError errorWithDomain:SRErrorDomain code:SRErrorInvokeError userInfo:@{NSLocalizedDescriptionKey:@"static methods not supported"}];
         }
        return;
    }
    NSMethodSignature* sign = [model methodSignatureForSelector:methodSel];
    if (!sign){
        if (error) {
            NSString* errorMsg = [NSString stringWithFormat:@"can't create method signature for model %@ with selector %@", model, methodName];
            *error = [NSError errorWithDomain:SRErrorDomain code:SRErrorInvokeError userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
        }
        return;
    }
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sign];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    
    for (int i = 2; i < inv.methodSignature.numberOfArguments; i++) {
        [SRMockFabric addAnythingWithInvocation:inv atIndex:i forModel:model];
    }
    [inv invoke];
    if ( dict[SRMockFabricReturnValueKey] ){
        id res = nil;
        [inv getReturnValue:&res];
        [given(res) willReturn:dict[SRMockFabricReturnValueKey]];
    }
}

// TODO - add KVO support to mock
+ (void)addPropertiesWithDictionary:(NSDictionary*)dict toModel:(MKTObjectMock*)model withError:(NSError**)error{
    [self addMethodsWithDictionary:dict toModel:model withError:error];
}

+ (BOOL)isStaticMethod:(NSDictionary*)model atClass:(MKTObjectMock*)mockObject{
    Class classValue = [mockObject performSelector:@selector(mockedClass)];
    MKTClassObjectMock* staticModel = mockClass(classValue);
    MKTObjectMock* instanceModel = mock(classValue);
    NSString* methodName = model[SRMockFabricMethodNameKey];
    SEL methodSel = NSSelectorFromString(methodName);
    
    if ( [staticModel respondsToSelector:methodSel] ){
        return YES;
    }else if ( [instanceModel respondsToSelector:methodSel] ){
        return NO;
    }
    return NO;
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
