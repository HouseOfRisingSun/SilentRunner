//
//  SRBlockArgument.h
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRConcreteArgument.h"

@interface SRBlockArgument : SRConcreteArgument <MTLJSONSerializing>

@property (nonatomic, strong) NSArray* methods;


@end
