//
//  SilentRunnerEngineTests.m
//  SilentRunnerEngineTests
//
//  Created by Andrew Batutin on 12/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

@interface SilentRunnerEngineTests : XCTestCase

@end

@implementation SilentRunnerEngineTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    __block NSString* test = mock(NSString.class);
    NSObject* a = ^{int a= a+1; test = @"";};
    [a isEqual:@"fd"];
    id smthng =  mock(((NSObject*)a).class);
    
    NSArray *mockArray = mock([NSArray class]);
    MKTOngoingStubbing* gg = given([mockArray objectAtIndex:0]);
    // stubbing
    //[given([mockArray objectAtIndex:0]) willReturn:@"first"];
    [gg willReturn:@"smt"];
    
    NSLog(@"%@", [mockArray objectAtIndex:0]);
}

@end
