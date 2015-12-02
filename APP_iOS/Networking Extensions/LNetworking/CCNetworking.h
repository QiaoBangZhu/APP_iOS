//
//  CCNetworking.h
//  APP_iOS
//
//  Created by Li on 15/4/7.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Networking Extensions. Minimum iOS Target: iOS 7
 *
 *  @param 网络使用AFNetworking2.0，需要：pod 'AFNetworking', '~> 2.0'
 *
 */

@interface CCNetworking : NSObject

/**
 *  Http Get 请求
 *
 *  @param path   请求路径
 *  @param dic    请求参数
 *  @param sucess 成功block
 *  @param fail   失败block
 */
+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseDic))success failure:(void (^)(NSError *error))failure;

/**
 *  Http Post 请求
 *
 *  @param path   请求路径
 *  @param dic    请求参数
 *  @param sucess 成功block
 *  @param fail   失败block
 */
+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseDic))success failure:(void (^)(NSError *error))failure;

/**
 *  Http Post Data 上传
 *
 *  @param path       请求路径
 *  @param parameters 请求参数
 *  @param data       上传的data
 *  @param name       文件类型：eg：file
 *  @param fileName   文件名：eg：xxxx.jpg
 *  @param mimeType   类型：eg：@"image/jpg"
 *  @param sucess     成功block
 *  @param failure    失败block
 */
+ (void)postHttpRequest:(NSString *)path parameters:(NSDictionary *)parameters data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(NSDictionary *responseDic))success failure:(void (^)(NSError *error))failure;


@end
