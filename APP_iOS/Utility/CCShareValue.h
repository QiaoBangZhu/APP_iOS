//
//  CCShareValue.h
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CCShareValue : NSObject  {

}

+ (CCShareValue *)instance;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;

@end
