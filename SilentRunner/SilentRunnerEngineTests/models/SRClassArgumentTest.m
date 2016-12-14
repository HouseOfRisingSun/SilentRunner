//
//  SRClassArgumentTest.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRClassArgument.h"

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


@end
