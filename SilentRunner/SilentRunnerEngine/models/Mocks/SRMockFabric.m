//
//  MockFabric.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/19/16.
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
        id retValue = dict[SRMockFabricReturnValueKey];
        const char *retType = sign.methodReturnType;
        //TODO - work through all primitive types
        if ( !strcmp(retType, @encode(BOOL)) ){
            BOOL arg = ( [retValue isEqual:@"YES"] || [retValue isEqual:@1] ) ? YES : NO;
            //[given(res) willReturnBool:arg];
            [given(res) willReturn:retValue];
        }else if ( !strcmp(retType, @encode(long)) ){
            if ( [retValue isKindOfClass:NSNumber.class]){
                [given(res) willReturn:retValue];
            }
        }else if ( retType[0] == @encode(id)[0] ){
            [given(res) willReturn:retValue];
        }else{
            [given(res) willReturn:[[HCIsAnything alloc] init]];
        }
    }
}

+ (void)mapRetValue:(id)retValue toMockType:(const char *)retType forMock:(id)res{
    if ( !strcmp(retType, @encode(BOOL)) || !strcmp(retType, @encode(unsigned char)) ){
        BOOL arg = ( [retValue isEqual:@"YES"] || [retValue isEqual:@1] ) ? YES : NO;
        [given(res) willReturnBool:arg];
    }else if ( !strcmp(retType, @encode(short)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnShort:[retValue shortValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(int)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnInt:[retValue intValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(long)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnLong:[retValue longValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(long long)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnLongLong:[retValue longLongValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(NSInteger)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnInteger:[retValue integerValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(unsigned int)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnUnsignedInt:[retValue unsignedIntValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(unsigned short)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnUnsignedShort:[retValue unsignedShortValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(unsigned long)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnUnsignedLong:[retValue unsignedLongValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(unsigned long long)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnUnsignedLongLong:[retValue unsignedLongLongValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(NSUInteger)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnUnsignedInteger:[retValue unsignedIntegerValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(float)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnFloat:[retValue floatValue]];
        }else{
            goto default_type;
        }
    }else if ( !strcmp(retType, @encode(double)) ){
        if ( [retValue isKindOfClass:NSNumber.class]){
            [given(res) willReturnDouble:[retValue doubleValue]];
        }else{
            goto default_type;
        }
    }else if ( retType[0] == @encode(id)[0] ){
default_type:
        [given(res) willReturn:retValue];
    }else{
        [given(res) willReturn:[[HCIsAnything alloc] init]];
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
