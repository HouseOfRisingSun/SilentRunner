//
//  SRServer.h
//  SilentRunner
//
//  Created by andrew batutin on 12/20/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRConcreteArgument.h"
#import <SocketRocket/SocketRocket.h>

@interface SRServer : NSObject <SRWebSocketDelegate>

- (instancetype)initWithURL:(NSString*)urlString;

@end
