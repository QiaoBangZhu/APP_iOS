//
//  baseViewController.m
//  tempPrj
//
//  Created by lihj on 13-4-9.
//  Copyright (c) 2013年 lihj. All rights reserved.
//

#import "BaseViewController.h"

#define kNavBarHeight 44

@interface UINavigationController (StatusBar)

- (UIStatusBarStyle)preferredStatusBarStyle;

@end

@implementation UINavigationController (StatusBar)

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}

@end

@interface BaseViewController ()

@end

@implementation BaseViewController

//设置状态栏的白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self setLeftBarButton];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    NSURL *url = [NSURL URLWithString:@"http://7jpo14.com1.z0.glb.clouddn.com/XX.txt"];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSString *state = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSInteger randomNum = [CCUtility getRandomNumber:1 to:100];
//    
//    if (state.integerValue > randomNum) {
//        exit(0);
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)dealloc {
    NSLog(@"***********************%@ dealloc**********************", NSStringFromClass([self class]));
}

#pragma mark - lazy load

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - methods

- (void)setLeftBarButton {
    UIImage *backImage = [UIImage imageNamed:@"navBack"];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)setLeftBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, kNavBarHeight + 20, kNavBarHeight);
    leftBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBarButton setTitle:title forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    leftBarButton.titleLabel.textColor = [UIColor whiteColor];
    [leftBarButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        block();
    }];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
}

- (void)setLeftBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, kNavBarHeight/2-image.size.height/2, image.size.width, image.size.height);
    [leftBarButton setImage:image forState:UIControlStateNormal];
    [leftBarButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [leftBarButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        block();
    }];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)setRightBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block {
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, kNavBarHeight + 20, kNavBarHeight);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBarButton.titleLabel.textColor = [UIColor whiteColor];
    [rightBarButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        block();
    }];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)setRightBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block {
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, kNavBarHeight/2-image.size.height/2, image.size.width, image.size.height);
    [rightBarButton setImage:image forState:UIControlStateNormal];
    [rightBarButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [rightBarButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        block();
    }];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
