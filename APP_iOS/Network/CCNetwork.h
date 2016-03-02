//
//  CCNetwork.h
//  APP_iOS
//
//  Created by Li on 15/4/7.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, CCNetworkRequestCachePolicy){
    CCNetworkReturnCacheDataThenLoad = 0,           ///< 有缓存就先返回缓存，同步请求数据（默认）
    CCNetworkReloadIgnoringLocalCacheData,          ///< 忽略缓存，重新请求
    CCNetworkReturnCacheDataElseLoad,               ///< 有缓存就用缓存，没有缓存就重新请求（用于数据不变时）
    CCNetworkReturnCacheDataDontLoad,               ///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};

extern NSString * const LYHTTPClientRequestCache;   ///< 缓存的name，可用于清除缓存用

@interface CCNetwork : AFHTTPSessionManager

/**
 *  默认使用CCNetworkReturnCacheDataThenLoad缓存方式
 *  默认超时时间30s，可在.m中设置
 *
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
              timeoutInterval:(NSTimeInterval)timeoutInterval
                  cachePolicy:(CCNetworkRequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
               timeoutInterval:(NSTimeInterval)timeoutInterval
                   cachePolicy:(CCNetworkRequestCachePolicy)cachePolicy
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  Http Post Data 上传
 *
 *  @param URLString  请求路径
 *  @param parameters 请求参数
 *  @param fileData   上传的data
 *  @param name       文件类型：eg：file
 *  @param fileName   文件名：eg：xxxx.jpg
 *  @param mimeType   类型：eg：@"image/jpg"
 *  @param sucess     成功block
 *  @param failure    失败block
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                      fileData:(NSData *)fileData
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
