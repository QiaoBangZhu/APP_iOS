//
//  CCUtility.h
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CCUtility : NSObject

/**
 *  显示警告框
 */
+ (void)showAlert:(NSString *)msg;

/**
 *  计算UILabel的Size
 */
+ (CGSize)sizeWithLabel:(UILabel *)label;

/**
 *  获取count位的随机数
 */
+ (NSString *)strRandom:(NSInteger)count;

//获取一个随机整数，范围在[from,to），包括from，包括to
+ (int)getRandomNumber:(int)from to:(int)to;

@end
