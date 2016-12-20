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

+ (NSMutableDictionary*)tagStorage{
    static NSMutableDictionary* dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{}.mutableCopy;
    });
    return dict;
}

+ (void)addClient:(id)client forTag:(NSString *)tag{
    NSMutableDictionary* dict = [SRClientPool tagStorage];
    dict[tag] = client;
}

+ (id)clientForTag:(NSString *)tag{
    return [SRClientPool tagStorage][tag];
}

@end
