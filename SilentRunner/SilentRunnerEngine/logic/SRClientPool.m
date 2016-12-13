//
//  SRClientPool.m
//  SilentRunner
//
//  Created by andrew batutin on 12/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRClientPool.h"
#import <UIKit/UIKit.h>

@implementation SRClientPool

+ (id)clientForTag:(NSString *)tag{
    return [UIApplication sharedApplication];
}

@end
