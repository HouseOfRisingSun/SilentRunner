//
//  NSDictionary+ToString.h
//  JSONRPCom
//
//  Created by Andrew Batutin on 12/6/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ToString)

- (NSString*)toJsonStringWithError:(NSError **)error;

@end
