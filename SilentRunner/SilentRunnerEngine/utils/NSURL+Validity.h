//
//  NSURL+Validity.h
//  SilentRunner
//
//  Created by Andrew Batutin on 2/2/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Validity)

- (BOOL)isValid;
- (BOOL)isValidWebSocket;

@end
