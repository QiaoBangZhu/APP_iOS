//
//  DKLocationHelper.h
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DKLocationHelper : NSObject

//百度转火星坐标
+ (CLLocationCoordinate2D )bdToGGEncrypt:(CLLocationCoordinate2D)coord;
//火星转百度坐标
+ (CLLocationCoordinate2D )ggToBDEncrypt:(CLLocationCoordinate2D)coord;

@end
