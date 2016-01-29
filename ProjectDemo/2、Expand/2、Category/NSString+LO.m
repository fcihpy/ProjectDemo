//
//  NSString+LO.m
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "NSString+LO.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (LO)

+ (BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

+ (BOOL)isEmpty{
    return !self || self == (id) [NSNull null] || ((NSString *) self).length <= 0 || [@"(null)" isEqualToString:(NSString *)self];
}

#pragma mark - -------------电话、邮箱-------------------
+ (BOOL)isValidateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}

// 5-10位数字或字母
- (BOOL)isValidatePassword {
    if (self.length < 5 || self.length > 10) return NO;
    NSString *phoneRegex = @"^[a-zA-Z0-9]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}




//只能是数字
- (BOOL)isNumber{
    NSString *numStr = @"^[0-9]*$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numStr];
    return [numTest evaluateWithObject:self];
}


- (NSString *)md5Hex:(NSString *)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%2s",result ];
    }
    return ret;
    
}


- (NSArray *)splitToArray:(NSString *)sep {
    NSMutableArray *result = [NSMutableArray array];
    NSArray *array = [self componentsSeparatedByString:sep];
    for(NSString *str in array) {
        if (![NSString isEmpty]) {
            [result addObject:str];
        }
    }
    return result;
}

#pragma mark - 距离当前时间的时间差
- (NSString*)onetimeSinceNow:(NSString*)time
{
    float Inster=[time floatValue];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [date setTimeZone:timeZone];
    [date setDateStyle:NSDateFormatterMediumStyle];
    [date setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *temp=[NSDate dateWithTimeIntervalSince1970:Inster];
    NSTimeInterval timeInterval=[temp timeIntervalSinceNow];
    int A=(int)timeInterval;
    int day;
    int hour;
    day=A/86400;
    hour=(A%86400)/3600;
    return [NSString stringWithFormat:@"%2d天%2d小时",day,hour];
}

-(NSString*)stringFormTime:(NSString *)dateTime
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[dateTime intValue]];
    
    NSString *str=[[NSString stringWithFormat:@"%@",date]substringToIndex:10];
    return str;
    
}

#pragma mark - --------------------身份证相关----------------------

#pragma mark 验证身份证有效性
+ (BOOL)isValidateCertifNum:(NSString *)value{ //验证身份证
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
    
}

#pragma mark 得到身份证的生日
+ (NSString *)getIDCardBirthday:(NSString *)card{   //得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证
    
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([card length] != 18) {
        return nil;
    }
    NSString *birthady = [NSString stringWithFormat:@"%@年%@月%@日",[card substringWithRange:NSMakeRange(6,4)], [card substringWithRange:NSMakeRange(10,2)], [card substringWithRange:NSMakeRange(12,2)]];
    return birthady;
    
}

#pragma mark -得到身份证的性别
+ (NSInteger)getIDCardSex:(NSString *)card{   //得到身份证的性别（1男0女）****这个方法中不做身份证校验，请确保传入的是正确身份证
    
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger defaultValue = 0;
    if ([card length] != 18) {
        return defaultValue;
    }
    NSInteger number = [[card substringWithRange:NSMakeRange(16,1)] integerValue];
    if (number % 2 == 0) {  //偶数为女
        return 0;
    } else {
        return 1;
    }
    
}


//#####################################
//求拼音
-(NSString *)pinYin
{
#if 0
    //先转换为带声调的拼音
    NSMutableString *str = [self mutableCopy];//CFStringCreateMutableCopy(NULL, 0, CFSTR(self));
    
    
    
    CFStringTransform((__bridge CFMutableStringRef)str,NULL, /*kCFStringTransformMandarinLatin*/kCFStringTransformToLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((__bridge CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    if (str == nil || [str isEqualToString:@""]) {
        str = [[NSMutableString alloc] initWithString:@"#"];
    }
    return str;
#endif
    
    return [NSString phonetic:self];
    
}
//得到首字母的拼音
- (NSString *)firstCharactor
{
    //1.先传化为拼音
    NSString *pinYin = [self pinYin];
    //2.获取首字母
    if (pinYin == nil || [pinYin isEqualToString:@""]) {
        return @"#";
    }
    NSString *fs = [[pinYin substringToIndex:1] uppercaseString];
    unichar fch = [fs characterAtIndex:0];
    if (!(fch >= 'A' && fch <= 'Z')) {
        fs = @"#";
    }
    return fs;
}

+ (NSString *) phonetic:(NSString*)sourceString {
    
    if ([sourceString isEqualToString:@""]) {
        
        return sourceString;
        
    }
    
    NSMutableString *source = [sourceString mutableCopy];
    
    if(!CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO)){
        NSLog(@"error");
    }
    
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"长"] ==NSOrderedSame)
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 5)withString:@"chang"];
        
    }
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"呵"] ==NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 2)withString:@"he"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"沈"] ==NSOrderedSame)
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 4)withString:@"shen"];
        
    }
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"厦"] ==NSOrderedSame)
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 3)withString:@"xia"];
    }
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"地"] ==NSOrderedSame)
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 3)withString:@"di"];
        
    }
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"重"] ==NSOrderedSame)
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
        
    }
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"万"] ==NSOrderedSame)
    {
        
        [source replaceCharactersInRange:NSMakeRange(0, 3) withString:@"wan"];
        
    }
    return [source lowercaseString];
}

#pragma mark - JSON解析----by sunjun----------

#pragma mark NSArray或者NSDictionary转化为NSString
-(NSString*)JSONString
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    if(result){
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return result;
}


@end
