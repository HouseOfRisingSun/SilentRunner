//
//  SRClassArgument.h
//  SilentRunner
//
//  Created by Andrew Batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "SRConcreteArgument.h"
#import "SRArgument.h"

@interface SRClassArgument : SRConcreteArgument <MTLJSONSerializing>

@property (nonatomic, strong) NSString* className;
@property (nonatomic, strong) NSArray* properties;
@property (nonatomic, strong) NSArray* methods;

@end
