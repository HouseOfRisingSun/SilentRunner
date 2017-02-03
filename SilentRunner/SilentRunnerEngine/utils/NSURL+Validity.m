//
//  NSURL+Validity.m
//  SilentRunner
//
//  Created by andrew batutin on 2/2/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import "NSURL+Validity.h"

@implementation NSURL (Validity)

- (BOOL)isValid{
    return self && self.host && self.scheme;
}

- (BOOL)isValidWebSocket{
    return self && self.host && ([self.scheme isEqualToString:@"ws"] || [self.scheme isEqualToString:@"http"] || [self.scheme isEqualToString:@"wss"] || [self.scheme isEqualToString:@"https"]);
}


//([scheme isEqualToString:@"ws"] || [scheme isEqualToString:@"http"] || [scheme isEqualToString:@"wss"] || [scheme isEqualToString:@"https"])

@end
