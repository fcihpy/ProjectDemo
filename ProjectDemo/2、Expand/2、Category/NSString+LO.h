//
//  NSString+LO.h
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LO)

+ (BOOL)isChinese;

+ (BOOL)isEmpty;

#pragma mark - 身份证相关
+ (BOOL)isValidateCertifNum:(NSString *)value;

+ (NSString *)getIDCardBirthday:(NSString *)card;

+ (NSInteger)getIDCardSex:(NSString *)card;

#pragma mark - 电话、邮箱

+ (BOOL)isValidateMobile;

+ (BOOL)isValidateEmail;

#pragma mark - 时间


//求拼音
-(NSString *)pinYin;

//得到首字母的拼音
- (NSString *)firstCharactor;


#pragma mark - ----JSON解析--------------
/**
 *  把NSString转化为NSArray或者NSDictionary
 */
-(id)JasonToFoundation;


+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  把NSData转化为NSArray或者NSDictionary
 */



@end
