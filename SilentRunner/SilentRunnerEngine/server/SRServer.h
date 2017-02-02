//
//  SRServer.h
//  SilentRunner
//
//  Created by andrew batutin on 12/20/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRConcreteArgument.h"
#import <SocketRocket/SocketRocket.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRServer : NSObject <SRWebSocketDelegate>

@property (nonatomic, readonly, strong) SRWebSocket* webSocket;
@property (nonatomic, readonly, copy)  void (^messageHandler) (NSString* );
@property (nonatomic, readonly, copy) void (^errorHandler) (NSError*);

+ (nullable SRServer*)serverWithURL:(NSString*)url withMessageHandler:(nullable void (^)(NSString*))messageHandler withErrorHandler:(nullable void (^)(NSError*))errorHandler;

- (nullable instancetype)initWithURL:(NSString*)urlString;

NS_ASSUME_NONNULL_END

@end
