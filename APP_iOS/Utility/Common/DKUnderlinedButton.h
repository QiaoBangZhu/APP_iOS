//
//  DKUnderlinedButton.h
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKUnderlinedButton : UIButton

+ (DKUnderlinedButton *)underlinedButton;
+ (DKUnderlinedButton *)buttonWithTitle:(NSString *)title andFont:(UIFont *)font andColor:(UIColor *)color;

@end
