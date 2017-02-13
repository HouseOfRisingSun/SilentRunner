//
//  SRMessageHandler.h
//  SilentRunner
//
//  Created by andrew batutin on 2/2/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRCommand.h"

@interface SRMessageHandler : NSObject

+ (nullable id<SRCommandProtocol>)createCommandFromMessage:(nullable NSString*)message withError:(void (^)(NSError* error))parseErrorHandler;

@end
