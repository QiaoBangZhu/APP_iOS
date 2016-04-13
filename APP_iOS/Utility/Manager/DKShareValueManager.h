//
//  DKShareValueManager.h
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface DKShareValueManager : NSObject  {

}

+ (DKShareValueManager *)instance;

@property (nonatomic, assign) BOOL isRemember;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;

//@property (nonatomic, strong) UserModel *userModel;

@end
