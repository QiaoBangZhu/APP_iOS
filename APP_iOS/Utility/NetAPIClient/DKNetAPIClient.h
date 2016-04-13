//
//  DKNetAPIClient.h
//  APP_iOS
//
//  Created by Li on 4/13/16.
//  Copyright © 2016 Li. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, DKNetworkMethod) {
    Get = 0,
    Post,
};

@interface DKNetAPIClient : AFHTTPSessionManager

+ (instancetype)changeJsonClient;

+ (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(DKNetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

+ (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(DKNetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)uploadImage:(UIImage *)image
               path:(NSString *)path
         withParams:(NSDictionary *)params
               name:(NSString *)name
      progerssBlock:(void (^)(NSProgress *uploadProgress))progress
           andBlock:(void (^)(id data, NSError *error))block;


@end
