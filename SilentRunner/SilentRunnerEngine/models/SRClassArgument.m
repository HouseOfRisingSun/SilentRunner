//
//  SRClassArgument.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRClassArgument.h"
#import "SRMockFabric.h"

@interface SRClassArgument ()

@end

@implementation SRClassArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{    
    return @{@"className":@"class",
             @"properties":@"properties",
             @"methods":@"methods"
             };
}

- (BOOL)validate:(NSError **)error {
    BOOL res = NO;
    @try {
        res = [super validate:error];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:exception.reason code:999 userInfo:exception.userInfo];
    } @finally {
        return res;
    }
}

- (id)argumentValue{
    MKTBaseMockObject* model = [self createModelWithMethods:self.methods andProperties:self.properties];
    return model;
}

- (MKTBaseMockObject*)createModelWithMethods:(NSArray*)methods andProperties:(NSArray*)properties{
    Class modelClass = NSClassFromString(self.className);
    MKTObjectMock* object = [SRMockFabric mockWithClass:modelClass];
    NSError* error = nil;
    for ( NSDictionary* model in methods ){
        [SRMockFabric addMethodsWithDictionary:model toModel:object withError:&error];
    }
    for ( NSDictionary* prop in properties ){
        [SRMockFabric addPropertiesWithDictionary:prop toModel:object withError:&error];
    }
    if ( error ) {
        NSException* exp = [NSException exceptionWithName:@"error argument parsing" reason:error.description userInfo:error.userInfo];
        @throw exp;
    }
    return object;
}

@end
