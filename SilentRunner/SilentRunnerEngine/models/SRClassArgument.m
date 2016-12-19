//
//  SRClassArgument.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRClassArgument.h"
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

@implementation SRClassArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{    
    return @{@"className":@"class",
             @"properties":@"properties",
             @"methods":@"methods"
             };
}

- (id)argumentValue{
   /* id model = mock(NSClassFromString(self.className));
    NSString* methodName = self.methods[0][@"name"];
    MKTOngoingStubbing* stb2 = given(([model performSelector:NSSelectorFromString(methodName)]));
    NSString* returnValue = self.methods[0][@"returnValue"];
    [stb2 willReturn:returnValue];
    
    
    //[MKTGiven([model propertyName]) willReturn:stubbedValue];
    MKTOngoingStubbing* stbPr = given(([model performSelector:NSSelectorFromString(self.properties[0][@"name"])]));
    [stbPr willReturn:self.properties[0][@"returnValue"]];
    [MKTGiven([model valueForKey:@"absoluteString"]) willReturn:self.properties[0][@"returnValue"]];
    [MKTGiven([model valueForKeyPath:@"absoluteString"]) willReturn:self.properties[0][@"returnValue"]];*/
    
    MKTBaseMockObject* model = [self createModelWithMethods:self.methods andProperties:self.properties];
    
    return model;
}

- (MKTBaseMockObject*)createModelWithMethods:(NSArray*)methods andProperties:(NSArray*)properties{
    Class modelClass = NSClassFromString(self.className);
    
    for ( NSDictionary* model in methods ){
        MKTBaseMockObject* res = [self addMethods:model toModel:modelClass];
        return res;
    }
    
    return nil;
}

- (MKTBaseMockObject*)addMethods:(NSDictionary*)method toModel:(Class)modelClass{
    id staticModel = mockClass(modelClass);
    id instanceModel = mock(modelClass);
    NSString* methodName = @"fileURLWithPath:isDirectory:";
    SEL methodSel = NSSelectorFromString(methodName);
    
    
    if ( [staticModel respondsToSelector:methodSel] ){
        NSLog(@"instance");
        
        NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[staticModel methodSignatureForSelector:methodSel]];
        [inv setSelector:methodSel];
        [inv setTarget:staticModel];
    
        
        HCIsAnything* anyT = [[HCIsAnything alloc] init];
        
        const char * type2 = [inv.methodSignature getArgumentTypeAtIndex:2];
        const char * type3 = [inv.methodSignature getArgumentTypeAtIndex:3];
        BOOL isD = NO;
        if ( !strcmp( type3, @encode(BOOL) ) ){
            isD =YES;
        }
        
        [inv setArgument:&anyT atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        
        
        [inv setArgument:&isD atIndex:3]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
        
        
        [inv invoke];
        id anObject;
        [inv getReturnValue:&anObject];
        
        //id fff = [staticModel performSelector:NSSelectorFromString(methodName) withObject:anything()];
        id fff2 = given(anObject);
        [fff2 willReturn:@"tkkest"];
        int ers =  sizeof(double);
        NSLog(@"inst");
        //[given([staticModel performSelector:NSSelectorFromString(methodName) withObject:anything()]) willReturn:@"test"];
    }else if ( [instanceModel instancesRespondToSelector:methodSel] ){
        NSLog(@"class");
    }
    
    //[given([model fileURLWithPath:nil]) willReturn:@""];
    
    
    //given([[model class] performSelector:NSSelectorFromString(methodName) withObject:nil]);
    
    //MKTOngoingStubbing* stub = given(([model performSelector:NSSelectorFromString(methodName)]));
    //willReturn:[NSURL URLWithString:@"www.google.com"]];
    return nil;
}

@end
