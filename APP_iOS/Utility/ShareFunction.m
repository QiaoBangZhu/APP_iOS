//
//  shareFun.m
//  tempPrj
//
//  Created by lihj on 13-4-8.
//  Copyright (c) 2013年 lihj. All rights reserved.
//

#import "ShareFunction.h"
#import "AppDelegate.h"

@implementation ShareFunction

+ (void)showAlert:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [alert show];
}

+ (float)heightOfLabel:(UILabel *)label {
    CGSize size = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = label.lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelsize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;

    return ceil(labelsize.height);
}

+ (float)widthOfLabel:(UILabel *)label {
    CGSize size = CGSizeMake(CGFLOAT_MAX, label.frame.size.height);
//    CGSize labelsize = [label.text sizeWithFont:label.font constrainedToSize:size];
    
    CGSize labelsize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;

    return labelsize.width;
    
    
}

+ (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContext(view.frame.size); //currentView 当前的view
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    return viewImage;
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