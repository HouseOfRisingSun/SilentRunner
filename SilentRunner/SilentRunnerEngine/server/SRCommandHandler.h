//
//  SRCommandHandler.h
//  SilentRunner
//
//  Created by Andrew Batutin on 2/3/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SilentRunnerEngine/SilentRunnerEngine.h>

@interface SRCommandHandler : NSObject

+ (void)runCommand:(SRCommand*)command withError:(NSError**)error;

@end
