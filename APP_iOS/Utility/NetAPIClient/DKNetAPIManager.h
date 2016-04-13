//
//  DKNetAPIManager.h
//  APP_iOS
//
//  Created by Li on 4/13/16.
//  Copyright © 2016 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

//测试地址
#define kBaseUrlStrTest @"http://"
//线上地址
#define kBaseUrlStrDIS @"http://"

#define kTestKey @"BaseURLIsTest"

@interface DKNetAPIManager : NSObject

+ (NSString *)baseURLStr;
+ (void)changeBaseURLStrToTest:(BOOL)isTest;

+ (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;
+ (id)loadResponseWithPath:(NSString *)requestPath;
+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath;
+ (BOOL)deleteResponseCache;

+ (void)showError:(NSError *)error;

@end
