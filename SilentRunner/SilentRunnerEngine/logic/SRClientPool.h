//
//  SRClientPool.h
//  SilentRunner
//
//  Created by andrew batutin on 12/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRClientPool : NSObject

+ (id)clientForTag:(NSString*)tag;

@end
