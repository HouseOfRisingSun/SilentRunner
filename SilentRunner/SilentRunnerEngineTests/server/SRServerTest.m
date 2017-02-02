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

- (void)testServerInitWithInValidParamsFail{
    SRServer* server = [[SRServer alloc] initWithURL:@"foo://www.google.com"];
    XCTAssertNil(server, @"server not should be created");
}


@end
