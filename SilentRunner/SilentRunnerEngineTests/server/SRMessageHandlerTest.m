//
//  SRMessageHandlerTest.m
//  SilentRunner
//
//  Created by Andrew Batutin on 2/2/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRMessageHandler.h"
#import "SRClientPool.h"

@interface SRMessageHandlerTest : XCTestCase

@end

@implementation SRMessageHandlerTest

- (void)testNotificationMessageParsedCorrectly{
    NSURL* url =  [[NSBundle bundleForClass:[self class]] URLForResource:@"simple_notification" withExtension:@"json"];
    NSString* msg = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    SRCommand* command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:nil];
    XCTAssertNotNil(command, @"command should be created");
}

@end
