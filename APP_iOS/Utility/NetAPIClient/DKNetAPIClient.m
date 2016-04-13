//
//  DKNetAPIClient.m
//  APP_iOS
//
//  Created by Li on 4/13/16.
//  Copyright © 2016 Li. All rights reserved.
//

#import "DKNetAPIClient.h"
#import "DKNetAPIManager.h"
#import "NSJSONSerialization+DKJSON.h"

#define kNetworkMethodName @[@"Get", @"Post"]

@implementation DKNetAPIClient

static DKNetAPIClient *sharedClient = nil;

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[DKNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[DKNetAPIManager baseURLStr]]];
    });
    return sharedClient;
}

+ (instancetype)changeJsonClient {
    sharedClient = [[DKNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[DKNetAPIManager baseURLStr]]];
    return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    self.securityPolicy.allowInvalidCertificates = YES;
//    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    return self;
}

+ (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(DKNetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block {
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}

+ (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(DKNetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block {
    if (aPath.length <= 0) {
        return;
    }
    DLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    switch (method) {
        case Get:
        {
            //所有 Get 请求，增加缓存机制
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [[DKNetAPIClient sharedClient] GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [DKNetAPIManager handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    responseObject = [DKNetAPIManager loadResponseWithPath:localPath];
                    block(responseObject, error);
                }
                else {
                    [DKNetAPIManager saveResponseData:responseObject toPath:localPath];
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                if (autoShowError) {
                    [DKNetAPIManager showError:error];
                }
                id responseObject = [DKNetAPIManager loadResponseWithPath:localPath];
                block(responseObject, error);
            }];
        }
            break;
            
        case Post:
        {
            [[DKNetAPIClient sharedClient] POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [DKNetAPIManager handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }
                else {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                if (autoShowError) {
                    [DKNetAPIManager showError:error];
                }
                block(nil, error);
            }];
        }
            break;

        default:
            break;
    }
}

- (void)uploadImage:(UIImage *)image
               path:(NSString *)path
         withParams:(NSDictionary *)params
               name:(NSString *)name
      progerssBlock:(void (^)(NSProgress *uploadProgress))progress
           andBlock:(void (^)(id data, NSError *error))block {
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if ((float)data.length/1024 > 1000) {
        data = UIImageJPEGRepresentation(image, 1024*1000.0/(float)data.length);
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    DLog(@"\nuploadImageSize\n%@ : %.0f", fileName, (float)data.length/1024);
    
    [[DKNetAPIClient sharedClient] POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"\n===========response===========\n%@:\n%@", path, responseObject);
        id error = [DKNetAPIManager handleResponse:responseObject autoShowError:YES];
        if (error) {
            block(nil, error);
        }
        else {
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [DKNetAPIManager showError:error];
        block(nil, error);
    }];
}

@end
