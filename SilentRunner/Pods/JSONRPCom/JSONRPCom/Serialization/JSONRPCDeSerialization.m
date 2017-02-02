//
//  JSONRPCSerialization.m
//  JSONRPCom
//
//  Created by andrew batutin on 12/6/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//
// I'm aware that it looks a bit strange
//


#import "JSONRPCDeSerialization.h"
#import "NSString+ToJSONDictionary.h"

@interface JSONRPCDeSerialization ()

@end

@implementation JSONRPCDeSerialization

+ (BOOL (^)(NSDictionary*))requestKey{
    return ^BOOL(NSDictionary* dict){
        return ( [[dict allKeys] containsObject:@"id"] && [[dict allKeys] containsObject:@"method"] );
    };
}

+ (BOOL (^)(NSDictionary*))notificationKey{
    return ^BOOL(NSDictionary* dict){
        return ( ![[dict allKeys] containsObject:@"id"] && [[dict allKeys] containsObject:@"method"] );
    };
}

+ (BOOL (^)(NSDictionary*))responseKey{
    return ^BOOL(NSDictionary* dict){
        return ( [[dict allKeys] containsObject:@"id"] && [[dict allKeys] containsObject:@"result"] );
    };
}

+ (BOOL (^)(NSDictionary*))errorResponseKey{
    return ^BOOL(NSDictionary* dict){
        return ( [[dict allKeys] containsObject:@"error"] );
    };
}

+ (void (^)(NSDictionary*))requestValue:(void (^)(JSONRPCRequest* data))request serializationError:(void (^)(NSError* error))serializationError{
    return ^(NSDictionary* dict){
        [self parseJSON:dict forModel:[JSONRPCRequest class] withResult:^(id<JSONRPC> entity) {
            request((JSONRPCRequest*)entity);
        } serializationError:^(NSError *error) {
            serializationError(error);
        }];
    };
}

+ (void (^)(NSDictionary*))notificationValue:(void (^)(JSONRPCNotification* data))notification serializationError:(void (^)(NSError* error))serializationError{
    return ^(NSDictionary* dict){
        [self parseJSON:dict forModel:[JSONRPCNotification class] withResult:^(id<JSONRPC> entity) {
            notification((JSONRPCNotification*)entity);
        } serializationError:^(NSError *error) {
            serializationError(error);
        }];
    };
}

+ (void (^)(NSDictionary*))responseValue:(void (^)(JSONRPCResponse* data))response serializationError:(void (^)(NSError* error))serializationError{
    return ^(NSDictionary* dict){
        [self parseJSON:dict forModel:[JSONRPCResponse class] withResult:^(id<JSONRPC> entity) {
            response((JSONRPCResponse*)entity);
        } serializationError:^(NSError *error) {
            serializationError(error);
        }];
    };
}

+ (void (^)(NSDictionary*))errorResponseValue:(void (^)(JSONRPCErrorResponse* data))errorResponse serializationError:(void (^)(NSError* error))serializationError{
    return ^(NSDictionary* dict){
        [self parseJSON:dict forModel:[JSONRPCErrorResponse class] withResult:^(id<JSONRPC> entity) {
            errorResponse((JSONRPCErrorResponse*)entity);
        } serializationError:^(NSError *error) {
            serializationError(error);
        }];
    };
}

+ (NSDictionary*)serializationMappingwithJSONRPCRequset:(void (^)(JSONRPCRequest* data))request
                                      orJSONRPCResponse:(void (^)(JSONRPCResponse* data))response
                                  orJSONRPCNotification:(void (^)(JSONRPCNotification* data))notification
                                         orJSONRPCError:(void (^)(JSONRPCErrorResponse* data))errorResponse
                                     serializationError:(void (^)(NSError* error))serializationError{
    NSMutableDictionary* serializationMapping = @{}.mutableCopy;
    [serializationMapping setObject:[self requestValue:request serializationError:serializationError] forKey:[self requestKey]];
    [serializationMapping setObject:[self responseValue:response serializationError:serializationError] forKey:[self responseKey]];
    [serializationMapping setObject:[self notificationValue:notification serializationError:serializationError] forKey:[self notificationKey]];
    [serializationMapping setObject:[self errorResponseValue:errorResponse serializationError:serializationError] forKey:[self errorResponseKey]];
    return serializationMapping.copy;
}

+ (void)deSerializeString:(NSString*)message withJSONRPCRequset:(void (^)(JSONRPCRequest* data))request
                                            orJSONRPCResponse:(void (^)(JSONRPCResponse* data))response
                                            orJSONRPCNotification:(void (^)(JSONRPCNotification* data))notification
                                            orJSONRPCError:(void (^)(JSONRPCErrorResponse* data))errorResponse
                                            serializationError:(void (^)(NSError* error))serializationError{
    
    
    NSError* parseError = nil;
    NSDictionary* messageDict = [message toJSONDictionaryWithError:&parseError];
    if (parseError){
        serializationError(parseError);
        return;
    }
    
    NSDictionary* serializationMapping = [self serializationMappingwithJSONRPCRequset:request orJSONRPCResponse:response orJSONRPCNotification:notification orJSONRPCError:errorResponse serializationError:serializationError];
    
    for ( BOOL (^isKeyValidForMessage)(NSDictionary*) in [serializationMapping allKeys] ){
        if (isKeyValidForMessage(messageDict)){
            void (^serializationBlock)() = [serializationMapping objectForKey:isKeyValidForMessage];
            serializationBlock(messageDict);
            return;
        }
    }
    
    parseError = [NSError errorWithDomain:@"Parsing Error" code:-32700 userInfo:@{@"reason":@"unable to map message to RPC entity"}];
    serializationError(parseError);
}

+ (void)parseJSON:(NSDictionary*)json forModel:(Class)modelOfClass withResult:(void (^)(id<JSONRPC>entity))block
                                       serializationError:(void (^)(NSError* error))error{
    NSError* parseError = nil;
    JSONRPCRequest* result = [MTLJSONAdapter modelOfClass:modelOfClass fromJSONDictionary:json error:&parseError];
    if (!parseError){
        block(result);
    }else{
        error(parseError);
    }
}

@end
