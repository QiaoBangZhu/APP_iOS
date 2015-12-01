//
//  BaseHttpRequest.m
//  APP_iOS
//
//  Created by Li on 15/8/12.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseRequestModel.h"
#import "SvUDIDTools.h"

@implementation BaseRequestModel

- (id)init {
    self = [super init];
    if (self) {
        _deviceId = [SvUDIDTools UDID];
    }
    return self;
}


@end

@implementation BasePageRequestModel

- (id)init {
    self = [super init];
    if (self) {
        _offset = @"1";
        _max = @"20";
    }
    return self;
}


@end
