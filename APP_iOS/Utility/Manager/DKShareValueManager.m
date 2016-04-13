//
//  DKShareValueManager.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "DKShareValueManager.h"

@implementation DKShareValueManager

+ (DKShareValueManager *)instance
{
    static DKShareValueManager *sharedInstance = nil;
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

#pragma mark - set & get

- (void)setIsRemember:(BOOL)isRemember {
    [[NSUserDefaults standardUserDefaults] setBool:isRemember forKey:@"kIsRemember"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isRemember {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"kIsRemember"];
}

- (void)setUserName:(NSString *)userName {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"kUserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserName"];
}

@end
