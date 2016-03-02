//
//  CCNetworking.m
//  baseProject
//
//  Created by Li on 15/4/7.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "CCNetworking.h"
#import "NSObject+HXAddtions.h"
#import "AFAppDotNetAPIClient.h"

@implementation CCNetworking

+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseDic))success failure:(void (^)(NSError *error))failure {

    [[AFAppDotNetAPIClient sharedClient] GET:path parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        DLog(@"requestSuccess:\n%@", JSON);
        NSString *code = [JSON valueForKeyPath:@"code"];
        if ([code isEqualToString:@"YOURCODE"]) {
            if (success) {
                success(JSON);
            }
        }
        else {
            if (failure) {
                NSError *error = [NSError errorWithDomain:[JSON valueForKeyPath:@"message"] code:0 userInfo:nil];
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        DLog(@"requestFailure:\n%@", error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseDic))success failure:(void (^)(NSError *error))failure {

    [[AFAppDotNetAPIClient sharedClient] POST:path parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        DLog(@"requestSuccess:\n%@", JSON);
        NSString *code = [JSON valueForKeyPath:@"code"];
        if ([code isEqualToString:@"YOURCODE"]) {
            if (success) {
                success(JSON);
            }
        }
        else {
            if (failure) {
                NSError *error = [NSError errorWithDomain:[JSON valueForKeyPath:@"message"] code:0 userInfo:nil];
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        DLog(@"requestFailure:\n%@", error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postHttpRequest:(NSString *)path parameters:(NSDictionary *)parameters data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(NSDictionary *responseDic))success failure:(void (^)(NSError *error))failure {
    
    [[AFAppDotNetAPIClient sharedClient] POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        DLog(@"requestSuccess:\n%@", responseObject);
        NSString *code = [responseObject valueForKeyPath:@"code"];
        if ([code isEqualToString:@"YOURCODE"]) {
            if (success) {
                success(responseObject);
            }
        }
        else {
            if (failure) {
                NSError *error = [NSError errorWithDomain:[responseObject valueForKeyPath:@"message"] code:0 userInfo:nil];
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        DLog(@"requestFailure:\n%@", error);
        if (failure) {
            failure(error);
        }
    }];
}

@end
