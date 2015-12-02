//
//  CCWebViewController.m
//  YYKitExample
//
//  Created by ibireme on 15/9/11.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "CCWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface CCWebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate> {
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *url;

@end

@implementation CCWebViewController

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    _url = url;
    _webView = [UIWebView new];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
    [self.view addSubview:_webView];
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [_progressView setProgress:0.0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar addSubview:_progressView];
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    DLog(@"web load:%f", progress);
    [_progressView setProgress:progress animated:YES];
    
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([title length] > 0 && [self.title length] == 0 && progress == 1.0f)
        self.title = title;
}

@end
