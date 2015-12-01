//
//  shareFun.h
//  tempPrj
//
//  Created by lihj on 13-4-8.
//  Copyright (c) 2013年 lihj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>
#import <UIKit/UIKit.h>

@interface ShareFunction : NSObject

/**
 *  显示警告框
 */
+ (void)showAlert:(NSString *)msg;

/**
 *  获取UILabel的高度
 */
+ (float)heightOfLabel:(UILabel *)label;

/**
 *  获取UILabel的宽度
 */
+ (float)widthOfLabel:(UILabel *)label;

/**
 *  截屏
 */
+ (UIImage *)imageFromView:(UIView *)view;

/**
 *  获取count位的随机数
 */
+ (NSString *)strRandom:(NSInteger)count;

//获取一个随机整数，范围在[from,to），包括from，包括to
+ (int)getRandomNumber:(int)from to:(int)to;

@end