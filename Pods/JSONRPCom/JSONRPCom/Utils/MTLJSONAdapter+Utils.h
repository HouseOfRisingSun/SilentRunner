//
//  MTLJSONAdapter+Utils.h
//  JSONRPCom
//
//  Created by andrew batutin on 11/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTLJSONAdapter (Utils)

+ (NSDictionary*)JSONDictionaryFromModelNoNil:(id<MTLJSONSerializing>)model error:(NSError **)error;

@end
