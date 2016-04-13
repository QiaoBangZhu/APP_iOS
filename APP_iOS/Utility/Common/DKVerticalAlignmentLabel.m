//
//  DKVerticalAlignmentLabel.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "DKVerticalAlignmentLabel.h"

@implementation DKVerticalAlignmentLabel

- (void)setVerticalAlignment:(DKVerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case DKVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case DKVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case DKVerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
