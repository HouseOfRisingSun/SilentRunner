//
//  MockFabric.h
//  SilentRunner
//
//  Created by andrew batutin on 12/19/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRConcreteArgument.h"
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

@interface MockFabric : SRConcreteArgument

+ (void)addMockForValue:(void *)value withInvocation:(NSInvocation*)inv atIndex:(NSInteger)index;
+ (void)addAnythingWithInvocation:(NSInvocation*)inv atIndex:(NSInteger)index forModel:(MKTBaseMockObject*)model;

@end
