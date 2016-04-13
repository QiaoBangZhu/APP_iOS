//
//  DKWebViewController.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "DKWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface DKWebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate> {
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *url;

@end

@implementation DKWebViewController

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
    
    _webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height);
    [self.view addSubview:_webView];
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [_progressView setProgress:0.0];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    DLog(@"webViewProgress:%f", progress);
    [_progressView setProgress:progress animated:YES];
    
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length && !self.title.length && progress == 1.0f)
        self.title = title;
}

@end
