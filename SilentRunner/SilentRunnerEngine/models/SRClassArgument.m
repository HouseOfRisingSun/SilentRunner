//
//  SRClassArgument.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRClassArgument.h"
#import "SRMockFabric.h"
#import "SRServer+Utils.h"

@interface SRClassArgument ()

@property (nonatomic, strong) MKTBaseMockObject* model;

@end

@implementation SRClassArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{    
    return @{@"className":@"class",
             @"properties":@"properties",
             @"methods":@"methods"
             };
}

- (BOOL)validate:(NSError **)error{
    BOOL res = NO;
    if ( !(res = [super validate:error]) ) {
        return res;
    }
    
    @try {
        self.model = [self createModelWithMethods:self.methods andProperties:self.properties withError:error];
        if ( *error ) { res = NO; }
    } @catch (NSException *exception) {
        res = NO;
        *error = [NSError errorWithDomain:SRErrorDomain code:SRErrorParseError userInfo:@{exception.reason:exception.callStackSymbols}];
    } @finally {
       return res;
    }
}

- (id)argumentValue{
    return self.model;
}

- (MKTBaseMockObject*)createModelWithMethods:(NSArray*)methods andProperties:(NSArray*)properties withError:(NSError**)error{
    Class modelClass = NSClassFromString(self.className);
    MKTObjectMock* object = [SRMockFabric mockWithClass:modelClass];
    for ( NSDictionary* model in methods ){
        [SRMockFabric addMethodsWithDictionary:model toModel:object withError:error];
    }
    for ( NSDictionary* prop in properties ){
        [SRMockFabric addPropertiesWithDictionary:prop toModel:object withError:error];
    }

    return object;
}

@end
