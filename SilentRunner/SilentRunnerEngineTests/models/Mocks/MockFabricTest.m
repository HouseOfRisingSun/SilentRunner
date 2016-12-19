//
//  MockFabricTest.m
//  SilentRunner
//
//  Created by andrew batutin on 12/19/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import "MockFabric.h"

@interface MockFabricTest : XCTestCase

@end

@implementation MockFabricTest

- (void)testAddingStringValueToInvocation{
    id staticModel = mockClass(NSURL.class);
    NSString* methodName = @"fileURLWithPath:isDirectory:";
    SEL methodSel = NSSelectorFromString(methodName);
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[staticModel methodSignatureForSelector:methodSel]];
    [inv setSelector:methodSel];
    [inv setTarget:staticModel];
    NSString* expRes = @"expRes";
    [MockFabric addMockForValue:(__bridge void *)(expRes) withInvocation:inv atIndex:2];
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
    [MockFabric addMockForValue:(__bridge void *)(expRes) withInvocation:inv atIndex:2];
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
    [MockFabric addAnythingWithInvocation:inv atIndex:2 forModel:staticModel];
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
    [MockFabric addAnythingWithInvocation:inv atIndex:2 forModel:staticModel];
    [MockFabric addAnythingWithInvocation:inv atIndex:3 forModel:staticModel];
    [inv invoke];
    id res = nil;
    [inv getReturnValue:&res];
    [given(res) willReturn:@"test"];
    
    BOOL realRes = nil;
    [inv getArgument:&realRes atIndex:3];
    XCTAssertFalse(realRes);
    
    NSString* magicRes = [staticModel fileURLWithPath:@"wer" isDirectory:NO];
    XCTAssertEqualObjects(magicRes, @"test");
}



@end
