//
//  SRServerCommandProtocol.h
//  SilentRunner
//
//  Created by Andrey Batutin on 5/3/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SocketRocket.h>

@protocol SRServerCommandProtocol <NSObject>

- (void)runServer:(void (^)(SRWebSocket*))handler;
- (void)closeServer:(void (^)(SRWebSocket*))handler;

@end
