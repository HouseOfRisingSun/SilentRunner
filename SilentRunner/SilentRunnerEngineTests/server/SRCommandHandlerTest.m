//
//  SRCommandHandlerTest.m
//  SilentRunner
//
//  Created by andrew batutin on 2/3/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRCommandHandler.h"
#import "SRMessageHandler.h"
#import "SRClientPool.h"

@interface SRCommandHandlerTest : XCTestCase

@end

@implementation SRCommandHandlerTest

- (void)testCommandInvocation{
    NSURL* url =  [[NSBundle bundleForClass:[self class]] URLForResource:@"simple_notification" withExtension:@"json"];
    NSString* msg = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    SRCommand* command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:nil];
    NSError* error = nil;
    [SRCommandHandler runCommand:command withError:&error];
    NSMutableArray* res =  [SRClientPool clientForTag:@"NSMutableArray"];
    XCTAssertTrue(res.count == 1);
    XCTAssertNil(error);
}

- (void)testNilCommandInvocationDontCrash{
    SRCommand* command = nil;
    NSError* error = nil;
    [SRCommandHandler runCommand:command withError:&error];
    XCTAssertTrue(YES, @"we are still alive");
}

- (void)testDoubleCommandInvocation{
    NSURL* url =  [[NSBundle bundleForClass:[self class]] URLForResource:@"simple_notification" withExtension:@"json"];
    NSString* msg = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    SRCommand* command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:nil];
    NSError* error = nil;
    [SRCommandHandler runCommand:command withError:&error];
    command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:nil];
    [SRCommandHandler runCommand:command withError:&error];
    NSMutableArray* res =  [SRClientPool clientForTag:@"NSMutableArray"];
    XCTAssertTrue(res.count == 2);
    XCTAssertNil(error);
}

- (void)testCommandInvocationWithMultiMethodMock{
    NSURL* url =  [[NSBundle bundleForClass:[self class]] URLForResource:@"multi_method_invoke" withExtension:@"json"];
    NSString* msg = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    SRCommand* command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:nil];
    NSError* error = nil;
    [SRCommandHandler runCommand:command withError:&error];
    NSMutableArray* res =  [SRClientPool clientForTag:@"NSMutableArray"];
    XCTAssertTrue(res.count == 1);
    XCTAssertNil(error);
    NSURL* mockURL = res[0];
    XCTAssertEqualObjects(@"mock url", [mockURL fileReferenceURL]);
    XCTAssertEqualObjects(@"https://github.com/andrewBatutin/SilentRunner", mockURL.absoluteString);
    XCTAssertEqual(YES, [mockURL isFileReferenceURL]);
}

- (void)testCommandInvocationWithInvalidMultiMethodMockFailsGracefully{
    NSURL* url =  [[NSBundle bundleForClass:[self class]] URLForResource:@"invalid_multi_method_invoke" withExtension:@"json"];
    NSString* msg = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    SRCommand* command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:nil];
    NSError* error = nil;
    [SRCommandHandler runCommand:command withError:&error];
    XCTAssertNotNil(error);
}

@end
