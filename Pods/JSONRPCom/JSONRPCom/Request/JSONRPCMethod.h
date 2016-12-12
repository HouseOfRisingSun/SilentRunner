//
//  JSONRPCMethod.h
//  JSONRPCom
//
//  Created by andrew batutin on 11/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONRPCMethod <NSObject>

@property (nonatomic, readonly, copy) NSString* method;
@property (nonatomic, readonly, strong) id params;

@end
