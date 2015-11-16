//
//  BaseHttpRequest.h
//  APP_iOS
//
//  Created by Li on 15/8/12.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  BaseRequestModel：公共参数
 */
@interface BaseRequestModel : NSObject

@property (nonatomic, copy) NSString *deviceId;

@end

/**
 *  BasePageRequestModel：分页参数
 */
@interface BasePageRequestModel : BaseRequestModel

@property (nonatomic, copy) NSString *offset;   /**< 分页开始位置（偏移量）*/
@property (nonatomic, copy) NSString *max;      /**< 每页请求的条数*/

@end
