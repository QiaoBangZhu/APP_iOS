//
//  DKNetAPIManager.m
//  APP_iOS
//
//  Created by Li on 4/13/16.
//  Copyright © 2016 Li. All rights reserved.
//

#import "DKNetAPIManager.h"
#import "DKNetAPIClient.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"

static NSString *const DKNetAPIManagerCache = @"DKNetAPIManagerCache";

@implementation DKNetAPIManager

+ (NSString *)baseURLStr {
    NSString *baseURLStr;
    if ([self baseURLStrIsTest]) {
        baseURLStr = kBaseUrlStrTest;
    }
    else {
        baseURLStr = kBaseUrlStrDIS;
    }
    
    return baseURLStr;
}

+ (BOOL)baseURLStrIsTest {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kTestKey] boolValue];
}

+ (void)changeBaseURLStrToTest:(BOOL)isTest {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(isTest) forKey:kTestKey];
    [defaults synchronize];
    
    [DKNetAPIClient changeJsonClient];
}

+ (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError {
    NSError *error = nil;
    //code为非0值时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
    
    if (resultCode.intValue != 0) {
        error = [NSError errorWithDomain:[self baseURLStr] code:resultCode.intValue userInfo:responseJSON];
        
        if (resultCode.intValue == 1000) {//用户未登录
//            if ([Login isLogin]) {
//                [Login doLogout];//已登录的状态要抹掉
//                //更新 UI 要延迟 >1.0 秒，否则屏幕可能会不响应触摸事件。。暂不知为何
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                    [((AppDelegate *)[UIApplication sharedApplication].delegate) showLoginViewController];
//                    kTipAlert(@"%@", [error.userInfo objectForKey:@"msg"]);
//                });
//            }
        }
        else {
            if (autoShowError) {
                [self showError:[error.userInfo objectForKey:@"msg"]];
            }
        }
    }
    return error;
}

+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath {
    YYCache *cache = [[YYCache alloc] initWithName:DKNetAPIManagerCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    [cache setObject:data forKey:requestPath];   //YYCache 已经做了responseObject为空处理
    return YES;
}

+ (id)loadResponseWithPath:(NSString *)requestPath {
    YYCache *cache = [[YYCache alloc] initWithName:DKNetAPIManagerCache];
    return [cache objectForKey:requestPath];
}

+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath {
    YYCache *cache = [[YYCache alloc] initWithName:DKNetAPIManagerCache];
    [cache removeObjectForKey:requestPath];
    return YES;
}

+ (BOOL)deleteResponseCache {
    YYCache *cache = [[YYCache alloc] initWithName:DKNetAPIManagerCache];
    [cache removeAllObjects];
    return YES;
}

+ (void)showError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:error.description];
}

@end
