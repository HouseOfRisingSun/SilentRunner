//
//  SRCommand.h
//  SilentRunner
//
//  Created by Andrew Batutin on 12/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "SRCommandProtocol.h"

@interface SRCommand : MTLModel <MTLJSONSerializing, SRCommandProtocol>

- (NSInvocation*)commandInvocation;

@end
