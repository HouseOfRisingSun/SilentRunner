//
//  JSONRPCSerialization.h
//  JSONRPCom
//
//  Created by Andrew Batutin on 12/7/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRPCRequest.h"
#import "JSONRPCResponse.h"
#import "JSONRPCNotification.h"
#import "JSONRPCErrorResponse.h"


@interface JSONRPCSerialization : NSObject

+ (NSString*)serializeEntity:(id<MTLJSONSerializing>)entity withError:(NSError**)error;

@end
