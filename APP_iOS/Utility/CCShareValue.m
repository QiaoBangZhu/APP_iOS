//
//  CCShareValue.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "CCShareValue.h"

@implementation CCShareValue

+ (CCShareValue *)instance
{
    static CCShareValue *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end
