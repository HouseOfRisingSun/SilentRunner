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
    NSDictionary* intput =  @{
                                 @"class": @"NSURL",
                                 @"properties": @[
                                         @"stubProperty(absoluteString, \"https://github.com/andrewBatutin/SilentRunner)\""
                                         ],
                                 @"methods": @[
                                         @"[given(fileURLWithPath:\"path\") willReturn:\"path\"]"
                                         ]
                             };
    NSError* parseError = nil;
    SRClassArgument* realResult = [MTLJSONAdapter modelOfClass:SRClassArgument.class fromJSONDictionary:intput error:&parseError];
    XCTAssertEqualObjects(realResult.className, intput[@"class"]);
    XCTAssertEqualObjects(realResult.properties, intput[@"properties"]);
    XCTAssertEqualObjects(realResult.methods, intput[@"methods"]);
}

- (void)testArgumentCreation{
    id mock = [[MKTObjectMock alloc] initWithClass:NSURL.class];
    stubProperty(mock, absoluteString, @"https://github.com/andrewBatutin/SilentRunner)");
    
    NSDictionary* intput =  @{
                              @"class": @"NSURL",
                              @"properties": @[
                                      @"stubProperty(absoluteString, \"https://github.com/andrewBatutin/SilentRunner)\""
                                      ],
                              @"methods": @[
                                      @{@"name":@"isFileReferenceURL", @"returnValue":@1},
                                      ]
                              };
    NSError* parseError = nil;
    SRClassArgument* realResult = [MTLJSONAdapter modelOfClass:SRClassArgument.class fromJSONDictionary:intput error:&parseError];
    id result = realResult.argumentValue;
    XCTAssertEqualObjects(mock, result);
    
}

@end
