//
//  CCNetwork.m
//  baseProject
//
//  Created by Li on 15/4/7.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "CCNetwork.h"
#import "NSJSONSerialization+LYJSON.h"

static NSString * const CCNetworkURLString = @"https://api.app.net/";
NSString * const CCNetworkRequestCache = @"CCNetworkRequestCache";
static NSTimeInterval const CCNetworkTimeoutInterval = 30;

typedef NS_ENUM(NSUInteger, CCNetworkRequestType) {
    CCNetworkRequestTypeGET = 0,
    CCNetworkRequestTypePOST,
};

@implementation CCNetwork

+ (instancetype)sharedClient {
    static CCNetwork *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [CCNetwork client];
    });
    return sharedClient;
}

+ (instancetype)client {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [[CCNetwork alloc] initWithBaseURL:[NSURL URLWithString:CCNetworkURLString] sessionConfiguration:configuration];
}

#pragma mark - public

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self requestMethod:CCNetworkRequestTypeGET urlString:URLString parameters:parameters timeoutInterval:CCNetworkTimeoutInterval cachePolicy:CCNetworkReturnCacheDataThenLoad success:success failure:failure];
}

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
              timeoutInterval:(NSTimeInterval)timeoutInterval
                  cachePolicy:(CCNetworkRequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self requestMethod:CCNetworkRequestTypeGET urlString:URLString parameters:parameters timeoutInterval:timeoutInterval cachePolicy:cachePolicy success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self requestMethod:CCNetworkRequestTypePOST urlString:URLString parameters:parameters timeoutInterval:CCNetworkTimeoutInterval cachePolicy:CCNetworkReturnCacheDataThenLoad success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
               timeoutInterval:(NSTimeInterval)timeoutInterval
                   cachePolicy:(CCNetworkRequestCachePolicy)cachePolicy
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self requestMethod:CCNetworkRequestTypePOST urlString:URLString parameters:parameters timeoutInterval:timeoutInterval cachePolicy:cachePolicy success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                      fileData:(NSData *)fileData
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [[CCNetwork client] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        DLog(@"success:\n%@", responseObject);
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        DLog(@"failure:\n%@", error);
        failure(task, error);
    }];
}

#pragma mark - private

+ (NSURLSessionDataTask *)requestMethod:(CCNetworkRequestType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                        timeoutInterval:(NSTimeInterval)timeoutInterval
                            cachePolicy:(CCNetworkRequestCachePolicy)cachePolicy
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    URLString = URLString.length?URLString:@"";
    NSString *cacheKey = URLString;
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return nil;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [cacheKey stringByAppendingString:paramStr];
    }
    
    YYCache *cache = [[YYCache alloc] initWithName:CCNetworkRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    
    id object = [cache objectForKey:cacheKey];
    
    switch (cachePolicy) {
        case CCNetworkReturnCacheDataThenLoad: {        //先返回缓存，同时请求
            if (object) {
                success(nil, object);
            }
            break;
        }
        case CCNetworkReloadIgnoringLocalCacheData: {   //忽略本地缓存直接请求
            //不做处理，直接请求
            break;
        }
        case CCNetworkReturnCacheDataElseLoad: {        //有缓存就返回缓存，没有就请求
            if (object) {   //有缓存
                success(nil, object);
                return nil;
            }
            break;
        }
        case CCNetworkReturnCacheDataDontLoad: {        //有缓存就返回缓存,从不请求（用于没有网络）
            if (object) {   //有缓存
                success(nil, object);
            }
            return nil;//退出从不请求
        }
        default: {
            break;
        }
    }
    return [self requestMethod:type urlString:URLString parameters:parameters timeoutInterval:timeoutInterval cache:cache cacheKey:cacheKey success:success failure:failure];
}

+ (NSURLSessionDataTask *)requestMethod:(CCNetworkRequestType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                        timeoutInterval:(NSTimeInterval)timeoutInterval
                                  cache:(YYCache *)cache
                               cacheKey:(NSString *)cacheKey
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    CCNetwork *manager = [CCNetwork sharedClient];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    switch (type) {
        case CCNetworkRequestTypeGET:{
            return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];   //YYCache 已经做了responseObject为空处理
                DLog(@"success:\n%@", responseObject);
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"failure:\n%@", error);
                failure(task, error);
            }];
            break;
        }
        case CCNetworkRequestTypePOST:{
            return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];   //YYCache 已经做了responseObject为空处理
                DLog(@"success:\n%@", responseObject);
                success(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"failure:\n%@", error);
                failure(task, error);
            }];
            break;
        }
        default:
            break;
    }
}

///// URLString 应该是全url 上传单个文件
//+ (NSURLSessionUploadTask *)upload:(NSString *)URLString filePath:(NSString *)filePath parameters:(id)parameters{
//    NSURL *URL = [NSURL URLWithString:URLString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
//    NSURLSessionUploadTask *uploadTask = [[CCNetwork client] uploadTaskWithRequest:request fromFile:fileUrl progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Success: %@ %@", response, responseObject);
//        }
//    }];
//    [uploadTask resume];
//    return uploadTask;
//}

@end
