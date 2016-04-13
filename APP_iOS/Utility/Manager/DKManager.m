//
//  DKManager.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//


#import "DKManager.h"

@implementation DKManager

+ (void)showAlert:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alert show];
}

+ (NSString *)strRandom:(NSInteger)count {
    NSString *strRandom = @"";
    
    for(int i=0; i<count; i++) {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    return strRandom;
}

+ (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end
