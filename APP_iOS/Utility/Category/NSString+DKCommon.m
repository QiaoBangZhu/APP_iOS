//
//  NSString+DKCommon.m
//  APP_iOS
//
//  Created by Li on 4/13/16.
//  Copyright © 2016 Li. All rights reserved.
//

#import "NSString+DKCommon.h"

@implementation NSString (DKCommon)

- (BOOL)isPhoneNo {
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
