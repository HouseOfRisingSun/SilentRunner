//
//  SRMessageHandler.h
//  SilentRunner
//
//  Created by Andrew Batutin on 2/2/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SilentRunnerEngine/SilentRunnerEngine.h>

@interface SRMessageHandler : NSObject

+ (nullable id<SRCommandProtocol>)createCommandFromMessage:(nullable NSString*)message withError:(nullable void (^)(NSError* _Nullable error))parseErrorHandler;

@end
