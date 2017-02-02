//
//  JSONRPCommunication.h
//  JSONRPCom
//
//  Created by andrew batutin on 11/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRPCRequest.h"
#import "JSONRPCResponse.h"
#import "JSONRPCErrorResponse.h"

@protocol JSONRPCommunication <NSObject>

- (void)sendRequest:(JSONRPCRequest*)request;

@end
