//
//  baseViewController.h
//  tempPrj
//
//  Created by lihj on 13-4-9.
//  Copyright (c) 2013年 lihj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchedBlock)();

@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSMutableArray *dataSource;

- (void)setLeftBarButton;

- (void)setLeftBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block;
- (void)setLeftBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block;

- (void)setRightBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block;
- (void)setRightBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block;

- (void)backAction;

@end
