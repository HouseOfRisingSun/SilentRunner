//
//  SRClassArgument.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRClassArgument.h"
#import "MockFabric.h"

@implementation SRClassArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{    
    return @{@"className":@"class",
             @"properties":@"properties",
             @"methods":@"methods"
             };
}

- (id)argumentValue{
    MKTBaseMockObject* model = [self createModelWithMethods:self.methods andProperties:self.properties];
    return model;
}

- (MKTBaseMockObject*)createModelWithMethods:(NSArray*)methods andProperties:(NSArray*)properties{
    Class modelClass = NSClassFromString(self.className);
    for ( NSDictionary* model in methods ){
        MKTBaseMockObject* res = [MockFabric brewSomeMockWithDictionary:model andClass:modelClass];
        return res;
    }
    return nil;
}

@end
