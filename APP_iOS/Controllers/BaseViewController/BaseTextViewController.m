//
//  BaseTextViewController.m
//  APP_iOS
//
//  Created by Li on 15/8/26.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "BaseTextViewController.h"

@interface BaseTextViewController ()

@end

@implementation BaseTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_defaultContent.length <= self.numberOfWords) {
        _contentTextView.text = _defaultContent;
    }
    _numberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)(self.numberOfWords - _contentTextView.text.length)];
    
    if (_keyboardType) {
        _contentTextView.keyboardType = _keyboardType;
    }
    [_contentTextView becomeFirstResponder];

    __weak BaseTextViewController *weakSelf = self;
    [self setRightBarButtonWithTitle:@"完成" withBlock:^(NSInteger tag) {
        if (weakSelf.block) {
            weakSelf.block(weakSelf, weakSelf.contentTextView.text);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSUInteger)numberOfWords {
    if (!_numberOfWords) {
        _numberOfWords = kDefaultNumber;
    }
    return _numberOfWords;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSInteger willChangeLength = textView.text.length + text.length;
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if ([@"\n" isEqualToString:text] == YES) {
        if (self.block) {
            self.block(self, self.contentTextView.text);
        }
        [super backAction];
        return NO;
    }
    if (willChangeLength > self.numberOfWords) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSUInteger length = self.numberOfWords - textView.text.length;
    _numberLabel.text = [NSString stringWithFormat:@"%ld", (long)length];
}

@end
