//
//  SRServerTest.m
//  SilentRunner
//
//  Created by andrew batutin on 2/2/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRServer.h"

@interface SRServerTest : XCTestCase

@end

@implementation SRServerTest

- (void)testServerInitWithValidParamsPass{
    SRServer* server = [[SRServer alloc] initWithURL:@"http://www.google.com"];
    XCTAssertNotNil(server, @"server should be created");
    server = [[SRServer alloc] initWithURL:@"https://www.google.com"];
    XCTAssertNotNil(server, @"server should be created");
    server = [[SRServer alloc] initWithURL:@"ws://www.google.com"];
    XCTAssertNotNil(server, @"server should be created");
    server = [[SRServer alloc] initWithURL:@"wss://www.google.com"];
    XCTAssertNotNil(server, @"server should be created");
}

- (void)testServerInitDelegateNotNil{
    SRServer* server = [[SRServer alloc] initWithURL:@"http://www.google.com"];
    XCTAssertNotNil(server.webSocket.delegate, @"server should be created");
}

- (void)testServerInitWithInValidParamsFail{
    SRServer* server = [[SRServer alloc] initWithURL:@"foo://www.google.com"];
    XCTAssertNil(server, @"server not should be created");
}

- (void)testCallbacksAreSetForMessageAndErrorNotNil{
    SRServer* server = [SRServer serverWithURL:@"https://www.google.com" withMessageHandler:^(NSString * _Nonnull msg) {} withErrorHandler:^(NSError * _Nonnull error) {}];
    XCTAssertNotNil(server.messageHandler);
    XCTAssertNotNil(server.errorHandler);
}

- (void)testNilCallbacksSetForMessageAndErrorNil{
    SRServer* server = [SRServer serverWithURL:@"https://www.google.com" withMessageHandler:nil withErrorHandler:nil];
    XCTAssertNil(server.messageHandler);
    XCTAssertNil(server.errorHandler);
}

- (void)testMessageHandlerReceivedMessage{
    XCTestExpectation* exp = [self expectationWithDescription:@"msg received"];
    SRServer* server = [SRServer serverWithURL:@"https://www.google.com" withMessageHandler:^(NSString * _Nonnull msg) { [exp fulfill]; } withErrorHandler:^(NSError * _Nonnull error) {}];
    [server webSocket:server.webSocket didReceiveMessage:@"Hi!"];
    [self waitForExpectationsWithTimeout:0.1 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testNilMessageHandlerReceivedMessageDoesntCrash{
    SRServer* server = [SRServer serverWithURL:@"https://www.google.com" withMessageHandler:nil withErrorHandler:nil];
    [server webSocket:server.webSocket didReceiveMessage:@"Hi!"];
    XCTAssertNotNil(server, @"smthng went wrong");
}

- (void)testErrorHandlerReceivedError{
    XCTestExpectation* exp = [self expectationWithDescription:@"msg received"];
    SRServer* server = [SRServer serverWithURL:@"https://www.google.com" withMessageHandler:^(NSString * _Nonnull msg) { } withErrorHandler:^(NSError * _Nonnull error) { [exp fulfill]; }];
    [server webSocket:server.webSocket didFailWithError:[NSError errorWithDomain:@"test" code:0 userInfo:nil]];
    [self waitForExpectationsWithTimeout:0.1 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testNilErrorHandlerReceivedMessageDoesntCrash{
    SRServer* server = [SRServer serverWithURL:@"https://www.google.com" withMessageHandler:nil withErrorHandler:nil];
    [server webSocket:server.webSocket didFailWithError:[NSError errorWithDomain:@"test" code:0 userInfo:nil]];
    XCTAssertNotNil(server, @"smthng went wrong");
}


@end
