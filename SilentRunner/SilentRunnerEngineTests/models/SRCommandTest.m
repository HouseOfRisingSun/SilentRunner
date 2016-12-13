//
//  SRCommandTest.m
//  SilentRunner
//
//  Created by andrew batutin on 12/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRCommand.h"

@interface SRCommandTest : XCTestCase

@end

@implementation SRCommandTest


- (void)testSRCommandSuccsesfullParsing{
    NSDictionary* intput = @{
      @"commandId": @"UIApplication || app",
      @"method": @"application:openURL:options:",
      @"arguments": @[
              @{
                  @"class": @"NSURL",
                  @"properties": @[
                          @"stubProperty(absoluteString, \"https://github.com/andrewBatutin/SilentRunner)\""
                          ],
                  @"methods": @[
                          @"[given(fileURLWithPath:\"path\") willReturn:\"path\"]"
                          ]
                  },
              @{
                  @"value": @{
                          @"opt1": @"test"
                          }
                  },
              @{
                  @"class": @"block",
                  @"methods": @[
                          @"[given(invoke) willReturn:\"smthng\"]"
                          ]
                  }
              ]
      };
    NSError* parseError = nil;
    SRCommand* realResult = [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:intput error:&parseError];
    XCTAssertNotNil(realResult);
}


- (void)testSRCommandSuccsesfullInvocationConstruct{
    NSDictionary* intput = @{
                             @"commandId": @"UIApplication",
                             @"method": @"openURL:options:completionHandler:",
                             @"arguments": @[
                                     @{
                                         @"class": @"NSURL",
                                         @"properties": @[
                                                 @"stubProperty(absoluteString, \"https://github.com/andrewBatutin/SilentRunner)\""
                                                 ],
                                         @"methods": @[
                                                 @"[given(fileURLWithPath:\"path\") willReturn:\"path\"]"
                                                 ]
                                         },
                                     @{
                                         @"value": @{
                                                 @"opt1": @"test"
                                                 }
                                         },
                                     @{
                                         @"class": @"block",
                                         @"methods": @[
                                                 @"[given(invoke) willReturn:\"smthng\"]"
                                                 ]
                                         }
                                     ]
                             };
    NSError* parseError = nil;
    SRCommand* entity = [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:intput error:&parseError];
    NSInvocation* realResult = [entity commandInvocation];
    XCTAssertNotNil(realResult);
}

@end
