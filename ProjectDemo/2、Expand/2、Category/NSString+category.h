//
//  NSString+category.h
//  MiniSales
//
//  Created by sunjun on 13-7-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(chCategory)
- (BOOL)isPureInt;
- (BOOL)checkPhoneNumInput;
- (BOOL)validateEmail;
- (BOOL)isSpecialText;
//利用正则表达式验证
- (BOOL)isValidateEmail;
@end


@interface NSMutableString (category)

-(NSRange) replaceString:(NSString *)search replace:(NSString *)replace;
@end

@interface NSNumber(dollar_ex)
-(NSString *) stringValueDollar;
@end

@interface NSString (URLEncodingAdditions)

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

+ (NSString *)macAddress;
+ (NSString *)md5Digest:(NSString *)str;

+ (NSString *) makeName:(NSString *)name;
@end

@interface NSString (category)
- (NSString *)formatePosition;
@end


@interface NSString (phoneNumber)
//删除字符串中的 86 +86 086 0086
-(NSString *) deletePhone86;
- (NSString *)formatePhoneSpace;
- (NSString *)formatePhone;
- (NSString *)formateEmptyPhone;
- (BOOL)isLike86;
- (NSString *)formateCity;
- (NSString *)formateCountryCode;
- (NSString *)formateCityToCountry;
- (NSString *)deleteSpace;
-(NSString *) deletePhone86AndSpace;
-(NSNumber *) converToNumber;

@end