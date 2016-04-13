//
//  DKVerticalAlignmentLabel.h
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DKVerticalAlignment) {
    DKVerticalAlignmentTop = 0,       ///< default
    DKVerticalAlignmentMiddle,
    DKVerticalAlignmentBottom,
};

@interface DKVerticalAlignmentLabel : UILabel

@property (nonatomic) DKVerticalAlignment verticalAlignment;

@end
