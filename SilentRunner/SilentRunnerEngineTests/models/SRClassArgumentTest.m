//
//  SRClassArgumentTest.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRClassArgument.h"
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

@interface SRClassArgumentTest : XCTestCase

@end

@implementation SRClassArgumentTest

- (void)testSuccesfullModelParsing{
    NSDictionary* intput = @{
                              @"class": @"NSURL",
                              @"properties": @[
                                      @{@"name":@"absoluteString", @"returnValue":@"https://github.com/andrewBatutin/SilentRunner"}
                                      ],
                              @"methods": @[
                                      @{@"name":@"isFileReferenceURL", @"returnValue":@YES},
                                      ]
                             };
    NSError* parseError = nil;
    SRClassArgument* realResult = [MTLJSONAdapter modelOfClass:SRClassArgument.class fromJSONDictionary:intput error:&parseError];
    XCTAssertEqualObjects(realResult.className, intput[@"class"]);
    XCTAssertEqualObjects(realResult.properties, intput[@"properties"]);
    XCTAssertEqualObjects(realResult.methods, intput[@"methods"]);
}

- (void)testArgumentCreation{
    NSDictionary* intput = @{
                              @"class": @"NSURL",
                              @"properties": @[
                                      @{@"name":@"absoluteString", @"returnValue":@"https://github.com/andrewBatutin/SilentRunner"}
                                      ],
                              @"methods": @[
                                      @{@"name":@"isFileReferenceURL", @"returnValue":@YES},
                                      ]
                              };
    NSError* parseError = nil;
    SRClassArgument* realResult = [MTLJSONAdapter modelOfClass:SRClassArgument.class fromJSONDictionary:intput error:&parseError];
    NSURL* result = realResult.argumentValue;
    XCTAssertEqual(YES, [result isFileReferenceURL]);
    //XCTAssertEqualObjects(@"https://github.com/andrewBatutin/SilentRunner", [result absoluteString]);
}

@end
