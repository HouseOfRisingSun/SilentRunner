//
//  MockFabric.h
//  SilentRunner
//
//  Created by Andrew Batutin on 12/19/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRConcreteArgument.h"
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

@interface SRMockFabric : SRConcreteArgument

+ (MKTObjectMock*)mockWithClass:(Class)classValue;
+ (void)addMethodsWithDictionary:(NSDictionary*)dict toModel:(MKTObjectMock*)model withError:(NSError**)error;
+ (void)addPropertiesWithDictionary:(NSDictionary*)dict toModel:(MKTObjectMock*)model withError:(NSError**)error;
+ (void)addMockForValue:(void *)value withInvocation:(NSInvocation*)inv atIndex:(NSInteger)index;
+ (void)addAnythingWithInvocation:(NSInvocation*)inv atIndex:(NSInteger)index forModel:(MKTBaseMockObject*)model;

@end
