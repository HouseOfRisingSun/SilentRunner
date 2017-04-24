//
//  MockFabricTest.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/19/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import "SRMockFabric.h"

@interface SRMockCLass : NSObject

@property(nonatomic, assign) BOOL boolProp;
@property(nonatomic, assign) short shortProp;
@property(nonatomic, assign) int intProp;
@property(nonatomic, assign) long longProp;
@property(nonatomic, assign) long longLongProp;
@property(nonatomic, assign) NSInteger integerProp;
@property(nonatomic, assign) unsigned int unsignedIntProp;
@property(nonatomic, assign) unsigned char unsignedCharProp;
@property(nonatomic, assign) unsigned short unsignedShortProp;
@property(nonatomic, assign) unsigned long unsignedLongProp;
@property(nonatomic, assign) unsigned long long unsignedLongLongProp;
@property(nonatomic, assign) NSUInteger unsignedUIntegerProp;
@property(nonatomic, assign) float floatProp;
@property(nonatomic, assign) double doubleProp;
@property(nonatomic, strong) id objProp;
@property(nonatomic, strong) NSString* stringProp;

@end

@implementation SRMockCLass

@synthesize boolProp;
@synthesize shortProp;
@synthesize intProp;
@synthesize longProp;
@synthesize longLongProp;
@synthesize integerProp;
@synthesize unsignedIntProp;
@synthesize unsignedCharProp;
@synthesize unsignedShortProp;
@synthesize unsignedLongProp;
@synthesize unsignedLongLongProp;
@synthesize unsignedUIntegerProp;
@synthesize floatProp;
@synthesize doubleProp;

@end

@interface SRMockFabricTest : XCTestCase

@end

@implementation SRMockFabricTest


- (void)testBrewingMockStaticMethod{
    NSError* error = nil;
    id mock = [SRMockFabric mockWithClass:NSURL.class];
    [SRMockFabric addMethodsWithDictionary:@{@"name":@"fileURLWithPath:isDirectory:", @"returnValue":@"test"} toModel:mock withError:&error];
    XCTAssertNotNil(error);
}

- (void)testBrewingMockInstanceMethod{
    id mock = [SRMockFabric mockWithClass:NSURL.class];
    [SRMockFabric addMethodsWithDictionary:@{@"name":@"isFileReferenceURL", @"returnValue":@NO} toModel:mock withError:nil];
    BOOL res =  [mock isFileReferenceURL];
    XCTAssertFalse(res);
}

- (void)testAddingStringValueToInvocation{
    id staticModel = mockClass(NSURL.class);
    NSString* methodName = @"fileURLWithPath:isDirectory:";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[staticModel methodSignatureForSelector:methodSel]];
    [inv setSelector:methodSel];
    [inv setTarget:staticModel];
    NSString* expRes = @"expRes";
    [SRMockFabric addMockForValue:(__bridge void *)(expRes) withInvocation:inv atIndex:2];
    [inv retainArguments];
    id realRes = nil;
    [inv getArgument:&realRes atIndex:2];
    XCTAssertEqualObjects(realRes, expRes);
}

- (void)testAddingMockValueToInvocation{
    id staticModel = mockClass(NSURL.class);
    NSString* methodName = @"fileURLWithPath:isDirectory:";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[staticModel methodSignatureForSelector:methodSel]];
    [inv setSelector:methodSel];
    [inv setTarget:staticModel];
    HCIsAnything* expRes = [[HCIsAnything alloc] init];
    [SRMockFabric addMockForValue:(__bridge void *)(expRes) withInvocation:inv atIndex:2];
    __weak id realRes = nil;
    [inv getArgument:&realRes atIndex:2];
    XCTAssertEqualObjects(realRes, expRes);
}

- (void)testAddingAnythingToInvocation{
    id staticModel = mockClass(NSURL.class);
    NSString* methodName = @"fileURLWithPath:isDirectory:";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[staticModel methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:staticModel];
    [SRMockFabric addAnythingWithInvocation:inv atIndex:2 forModel:staticModel];
    __weak HCIsAnything* realRes = nil;
    [inv getArgument:&realRes atIndex:2];
    XCTAssertNotNil(realRes);
    XCTAssertEqualObjects(HCIsAnything.class, realRes.class);
}

- (void)testAddingBoolToInvocation{
    id staticModel = mockClass(NSURL.class);
    NSString* methodName = @"fileURLWithPath:isDirectory:";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[staticModel methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:staticModel];
    [SRMockFabric addAnythingWithInvocation:inv atIndex:2 forModel:staticModel];
    [SRMockFabric addAnythingWithInvocation:inv atIndex:3 forModel:staticModel];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    [given(res) willReturn:@"test"];
    
    BOOL realRes = nil;
    [inv getArgument:&realRes atIndex:3];
    XCTAssertFalse(realRes);
    
    NSString* magicRes = (NSString*)[staticModel fileURLWithPath:@"wer" isDirectory:NO];
    XCTAssertEqualObjects(magicRes, @"test");
}

- (void)testBoolPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"boolProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@"YES" toMockType:@encode(BOOL) forMock:res];
    XCTAssertTrue(model.boolProp);
    [SRMockFabric mapRetValue:@1 toMockType:@encode(BOOL) forMock:res];
    XCTAssertTrue(model.boolProp);
}

- (void)testShortPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"shortProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@13 toMockType:@encode(short) forMock:res];
    XCTAssertEqual((short)13, model.shortProp);
}

- (void)testIntPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"intProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@15 toMockType:@encode(int) forMock:res];
    XCTAssertEqual((int)15, model.intProp);
}

- (void)testLongPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"longProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@14 toMockType:@encode(long) forMock:res];
    XCTAssertEqual((long)14, model.longProp);
}

- (void)testLongLongPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"longLongProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@10 toMockType:@encode(long long) forMock:res];
    XCTAssertEqual((long)10, model.longLongProp);
}

- (void)testIntegerPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"integerProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@(-2) toMockType:@encode(NSInteger) forMock:res];
    XCTAssertEqual((NSInteger)-2, model.integerProp);
}

- (void)testUnsIntPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"unsignedIntProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@2 toMockType:@encode(unsigned int) forMock:res];
    XCTAssertEqual((unsigned int)2, model.unsignedIntProp);
}

- (void)testUnsCharPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"unsignedCharProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@"YES" toMockType:@encode(unsigned char) forMock:res];
    XCTAssertEqual((unsigned char)1, model.unsignedCharProp);
}

- (void)testUnsShortPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"unsignedShortProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@43 toMockType:@encode(unsigned short) forMock:res];
    XCTAssertEqual((unsigned short)43, model.unsignedShortProp);
}

- (void)testUnsLongPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"unsignedLongProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@22 toMockType:@encode(unsigned long) forMock:res];
    XCTAssertEqual((unsigned long)22, model.unsignedLongProp);
}

- (void)testUnsLongLongPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"unsignedLongLongProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@22 toMockType:@encode(unsigned long long) forMock:res];
    XCTAssertEqual((unsigned long long)22, model.unsignedLongLongProp);
}

- (void)testNSUIntegerPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"unsignedUIntegerProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@23 toMockType:@encode(NSUInteger) forMock:res];
    XCTAssertEqual((NSUInteger)23, model.unsignedUIntegerProp);
}

- (void)testFloatPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"floatProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@3.41 toMockType:@encode(float) forMock:res];
    XCTAssertEqual((float)3.41, model.floatProp);
}

- (void)testDoubelPrimitiveDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"doubleProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@3.41 toMockType:@encode(double) forMock:res];
    XCTAssertEqual((double)3.41, model.doubleProp);
}

- (void)testObjDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"objProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@234 toMockType:@encode(id) forMock:res];
    XCTAssertEqualObjects(@234, model.objProp);
}

- (void)testNumberAsStringDataTypesProps{
    SRMockCLass* model = mock(SRMockCLass.class);
    NSString* methodName = @"stringProp";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[model methodSignatureForSelector:methodSel]];
    [inv retainArguments];
    [inv setSelector:methodSel];
    [inv setTarget:model];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    
    [SRMockFabric mapRetValue:@234 toMockType:@encode(NSString) forMock:res];
    XCTAssertEqualObjects(@234, model.stringProp);
}

@end
