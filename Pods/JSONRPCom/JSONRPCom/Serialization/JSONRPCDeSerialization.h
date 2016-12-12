//
//  JSONRPCSerialization.h
//  JSONRPCom
//
//  Created by andrew batutin on 12/6/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRPCRequst.h"
#import "JSONRPCResponse.h"
#import "JSONRPCNotification.h"
#import "JSONRPCErrorResponse.h"

@interface JSONRPCDeSerialization : NSObject

+ (void)deSerializeString:(NSString*)message withJSONRPCRequset:(void (^)(JSONRPCRequst* data))request
                                            orJSONRPCResponse:(void (^)(JSONRPCResponse* data))response
                                            orJSONRPCNotification:(void (^)(JSONRPCNotification* data))notification
                                            orJSONRPCError:(void (^)(JSONRPCErrorResponse* data))errorResponse
                                            serializationError:(void (^)(NSError* error))error;

@end
