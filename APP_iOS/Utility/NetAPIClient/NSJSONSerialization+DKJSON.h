//
//  NSJSONSerialization+DKJSON.h
//  APP_iOS
//
//  Created by Li on 4/13/16.
//  Copyright © 2016 Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (DKJSON)

+ (nullable NSString *)stringWithJSONObject:(nonnull id)JSONObject;
+ (nullable id)objectWithJSONString:(nonnull NSString *)JSONString;
+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData;

@end
