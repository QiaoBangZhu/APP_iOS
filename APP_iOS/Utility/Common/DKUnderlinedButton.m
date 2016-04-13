//
//  DKUnderlinedButton.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#define kUnderlinedButtonHeight 20.0

#import "DKUnderlinedButton.h"

@implementation DKUnderlinedButton

+ (DKUnderlinedButton *)underlinedButton {
    DKUnderlinedButton *button = [[DKUnderlinedButton alloc] init];
    return button;
}
+ (DKUnderlinedButton *)buttonWithTitle:(NSString *)title andFont:(UIFont *)font andColor:(UIColor *)color{
    DKUnderlinedButton *button = [[DKUnderlinedButton alloc] init];
    
    CGFloat titleWidth = [title widthForFont:font];

    button.frame = CGRectMake(0, 0, titleWidth + 20.0, kScreenWidth);
    [button.titleLabel setFont:font];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect textRect = self.titleLabel.frame;
    
    // need to put the line at top of descenders (negative value)
    CGFloat descender = self.titleLabel.font.descender+2;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // set to same colour as text
 
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self setNeedsDisplay];
}

@end
