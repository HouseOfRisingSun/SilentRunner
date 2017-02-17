//
//  SRServer.h
//  SilentRunner
//
//  Created by Andrew Batutin on 12/20/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRConcreteArgument.h"
#import <SilentRunnerEngine/SilentRunnerEngine.h>
#import <SocketRocket/SocketRocket.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const SRErrorDomain;

typedef enum{
    SRErrorParseError = -101,
    SRErrorInvokeError = -102,
} SRErrorCode;


@interface SRServer : NSObject <SRWebSocketDelegate>

@property (nonatomic, readonly, strong) SRWebSocket* webSocket;
@property (nonatomic, readonly, copy)  void (^messageHandler) (NSString* );
@property (nonatomic, readonly, copy) void (^errorHandler) (NSError*);

+ (nullable SRServer*)serverWithURL:(NSString*)url withErrorHandler:(nullable void (^)(NSError*))errorHandler;
+ (nullable SRServer*)serverWithURL:(NSString*)url withMessageHandler:(nullable void (^)(NSString*))messageHandler withErrorHandler:(nullable void (^)(NSError*))errorHandler;

- (nullable instancetype)initWithURL:(NSString*)urlString;

- (void)sendErrorMessage:(NSError*)error;
- (void)runServer;
- (void)closeServer;

void SRLog(NSString *format, ...);

NS_ASSUME_NONNULL_END

@end
