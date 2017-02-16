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

@interface MockFabricTest : XCTestCase

@end

@implementation MockFabricTest


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



@end
