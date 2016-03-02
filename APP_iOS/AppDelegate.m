//
//  AppDelegate.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "InteractivePopNavigationController.h"
#import "TestViewController.h"
#import "KeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [self customizeInterface];
    
    TestViewController *vc = [TestViewController new];
    InteractivePopNavigationController *nav = [[InteractivePopNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Private Methods

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:kRGBCOLOR(254, 84, 0)] forBarMetrics:UIBarMetricsDefault];
    
    //    可以去除NavBar下面那条线
    //    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {
    //        [navigationBarAppearance setShadowImage:[[UIImage alloc] init]];
    //    }
    
    //设置naviegationBar的文本属性
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


@end
