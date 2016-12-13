//
//  SRCommandProtocol.h
//  SilentRunner
//
//  Created by andrew batutin on 12/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SRCommandProtocol <NSObject>

@property (nonatomic, strong) NSString* commandId;
@property (nonatomic, strong) NSString* method;
@property (nonatomic, strong) NSArray* parametrs;

@end
