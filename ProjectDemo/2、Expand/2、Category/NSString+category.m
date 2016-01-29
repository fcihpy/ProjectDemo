//
//  NSString+category.m
//  MiniSales
//
//  Created by sunjun on 13-7-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "NSString+category.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "LOHelp.h"

#import <CommonCrypto/CommonDigest.h>
@implementation NSString(chCategory)

- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断手机号码是否合法
-(BOOL)checkPhoneNumInput{
  //  NSString *Regex = @"^1[3|4|5|7|8]\\d{9}";
    //NSString *Regex =@"(13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}";
#if 0
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:self];
#endif
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)checkPhoneNumFormat{
    //  NSString *Regex = @"^1[3|4|5|7|8]\\d{9}";
    //NSString *Regex =@"(13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}";
#if 0
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:self];
#endif
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
     NSString * MOBILE = @"^1(3[0-9]-|5[0-35-9]-|8[025-9]-)\\d{4}-\\d{4}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
//        || ([regextestcm evaluateWithObject:self] == YES)
//        || ([regextestct evaluateWithObject:self] == YES)
//        || ([regextestcu evaluateWithObject:self] == YES)
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//判断输入的邮箱是否合法
-(BOOL)validateEmail{
    
    if( (0 != [self rangeOfString:@"@"].length) &&  (0 != [self rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [self rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [self substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainPart = [self substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}

- (BOOL)isSpecialText
{
    if (IS_NOT_EMPTY(self)) {
        NSString *specialChinese = @"· ~ ! @ # $ % ^ & * ( ) （ ） [ ] { } - _ = + \\ | ; : ' \" , . / < > ? ！ ； ： ‘ ’ “ ” ， 。 《 》 【 】 ｛ ｝ ？ 「 」 『 』 〖 〗 ≈ ≡ ≠ ＝ ≤ ≥ ＜ ＞ ≮ ≯ ∷ ± ＋ － × ÷ ／ ∫ ∮ ∝ ∞ ∧ ∨ ∑ ∏ ∪ ∩ ∈ ∵ ∴ ⊥ ‖ ∠ ⌒ ⊙ ≌ ∽ √ ＄ ￡ ￥ ‰ ％ ℃ ¤ ￠ ┌ ┍ ┎ ┏ ┐ ┑ ┒ ┓ — ┄ ┈ ├ ┝ ┞ ┟ ┠ ┡ ┢ ┣ ┆ ┊ ┬ ┭ ┮ ┯ ┰ ┱ ┲ ┳ ┼ ┽ ┾ ┿ ╀ ╂ ╁ ╃ … 、 ～";
        NSArray *array = [specialChinese componentsSeparatedByString:@" "];
        
        if ([array containsObject:self]) {
            return YES;
        }else {
            char *charString = (char *)[self UTF8String];
            if (ispunct(*charString)) {
                return YES;
            }else {
                return NO;
            }
        }
    }else {
        return NO;
    }
}

//利用正则表达式验证
- (BOOL)isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end


@implementation NSMutableString (category)

-(NSRange) replaceString:(NSString *)search replace:(NSString *)replace
{
    NSRange substr = [self rangeOfString:search]; // 字符串查找,可以判断字符串中是否有
    if (substr.location != NSNotFound) {
         [self replaceCharactersInRange:substr withString:replace];
    }
    return substr;
}


@end


@implementation NSString (URLEncodingAdditions)

+ (NSString *) makeName:(NSString *)name{
    
    NSString *begin = @"[@]";
    NSString *end = @"[$]";
    if (!name) {
        return @"";
    }
    NSMutableString *newString = [[NSMutableString alloc] initWithString:name];
    [newString  replaceOccurrencesOfString:begin withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [newString  replaceOccurrencesOfString:end withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    return newString;
}

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            CFSTR("!*'();:@&=+$,/?%#[] "),
                                            kCFStringEncodingUTF8));
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self, CFSTR(""),kCFStringEncodingUTF8));
    return result;
}

+ (NSString *)macAddress
{
    int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	//NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
}

+ (NSString *)md5Digest:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}
@end






@implementation NSNumber(dollar_ex)
-(NSString *) stringValueDollar
{
    double dvalue =  [self doubleValue];
    NSString *svalue = [NSNumber numberWithFloat:dvalue].stringValue;
    NSArray *arr = [svalue componentsSeparatedByString:@"."];
    if(arr && arr.count == 2){
        //整数部分
        NSMutableString *result = [NSMutableString stringWithString:[arr objectAtIndex:0]];
        //小数部分
        NSString *decimals = [arr objectAtIndex:1];
        if(decimals.length > 0)
        {
            if(decimals.length > 2)
                decimals = [decimals substringToIndex:2];
            [result appendString:@"."];
            [result appendString:decimals];
        }
        return result;
    }else{
        return svalue;
    }
}
@end

@implementation NSString (category)

- (NSString *)formatePosition
{
    NSString *str = [self deleteSpace];
    str = [[str componentsSeparatedByString:@"/"] lastObject];
    str = [[str componentsSeparatedByString:@">"] lastObject];
    return str;
}

@end

@implementation NSString (phoneNumber)
-(NSString *) deletePhone86AndSpace{
    NSString *prefix = @"";
    NSArray *has = @[@"+86",@"086",@"0086",@"+"];
    for (NSString *s in has) {
        if ([self hasPrefix:s]) {
            prefix = s;break;
        }
    }
    NSString * commonPhone = [self substringFromIndex:prefix.length];
    commonPhone = [commonPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    commonPhone = [commonPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    commonPhone = [commonPhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    commonPhone = [commonPhone stringByReplacingOccurrencesOfString:@")" withString:@""];
    return commonPhone;
}

-(NSNumber *) converToNumber
{
    NSString *phone = [self deletePhone86AndSpace];
    NSScanner* scan = [NSScanner scannerWithString:phone];
    unsigned long long val;
    if([scan scanUnsignedLongLong:&val] && [scan isAtEnd]){
        return [NSNumber numberWithUnsignedLongLong:[phone longLongValue]];
    }
    return nil;
}

-(NSString *) deletePhone86{
  
    NSString *prefix = nil;
    //86 +86 086 0086
    NSArray *has = @[@"86",@"-86",@"+86",@"086",@"0086"];
    for (NSString *s in has) {
        if ([self hasPrefix:s]) {
            prefix = s;break;
        }
    }
    if (prefix) {
        NSString *subs = [self substringFromIndex:prefix.length];
        if ([subs hasPrefix:@" "] || [subs hasPrefix:@"-"]) {
            return [[subs substringFromIndex:1] stringByReplacingOccurrencesOfString:@" " withString:@""];
        }else {
            return subs;
        }
    }
    return self;
}

- (NSString *)formatePhoneSpace
{
    NSString *commonPhone = nil;
    
    if (self.length == 13) {
        commonPhone = [self stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    }else if (self.length == 11) {
        NSMutableString *newMutString = [[NSMutableString alloc] initWithString:self];
        [newMutString insertString:@" " atIndex:7];
        [newMutString insertString:@" " atIndex:3];
        commonPhone = newMutString;
    }else {
        commonPhone = self;
    }
 
    return commonPhone;
}
- (BOOL)checkPhoneTreePrex{
    
    NSString *threeCodeReg1 = @"^13[0-9]";
    NSString *threeCodeReg2 = @"^15[0-9]";
    NSString *threeCodeReg3 = @"^17[0-9]";
    NSString *threeCodeReg4 = @"^18[0-9]";
    NSString *threeCodeReg5 = @"^0[1-2][0-9]";
    
    NSPredicate *regexReg1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",threeCodeReg1];
    NSPredicate *regexReg2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",threeCodeReg2];
    NSPredicate *regexReg3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",threeCodeReg3];
    NSPredicate *regexReg4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",threeCodeReg4];
    NSPredicate *regexReg5 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",threeCodeReg5];
    
    
    
    
    if ([regexReg1 evaluateWithObject:self] ||
        [regexReg2 evaluateWithObject:self] ||
        [regexReg3 evaluateWithObject:self] ||
        [regexReg4 evaluateWithObject:self] ||
        [regexReg5 evaluateWithObject:self]) {
        return YES;
    }else{
        return NO;
    }
    
}

- (NSString *)formatePhone
{
    NSString *commonPhone = nil;
    NSMutableString *newMutString = [[NSMutableString alloc] initWithString:self];
    NSString *thirdStr ;
    if (newMutString) {
        if (self.length == 11) {
            thirdStr  = [newMutString substringToIndex:3];
            if ([thirdStr checkPhoneTreePrex]) {
                [newMutString insertString:@"-" atIndex:3];
                [newMutString insertString:@"-" atIndex:8];
                
            }else{
                [newMutString insertString:@"-" atIndex:4];
                [newMutString insertString:@"-" atIndex:9];
            }
            commonPhone = newMutString;
        }else {
            commonPhone = self;
        }
    }
    return commonPhone;
}

- (NSString *)formateEmptyPhone
{
    NSString *commonPhone = nil;
    
    commonPhone = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    commonPhone = [commonPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return commonPhone;
}

- (BOOL)isLike86
{
    if ([self isEqualToString:@"86"]) {
        return YES;
    }else {
        return NO;
    }
}

- (NSString *)formateCity
{
    NSString *city = @"";
    
    if (self) {
        NSArray *array = [self componentsSeparatedByString:@" "];
        if ([array count] == 2) {
            if ([array[0] isEqualToString:array[1]]) {
                city = array[0];
            }else {
                city = self;
            }
        }else {
            city = self;
        }
    }
    
    return city;
}

- (NSString *)formateCityToCountry
{
    NSString *country = @"";
    
    if (self) {
        NSArray *array = [self componentsSeparatedByString:@" "];
        if ([array count] == 2) {
            if ([array[0] isEqualToString:array[1]]) {
                country = array[0];
            }else {
                country = array[1];
            }
        }else {
            country = self;
        }
    }
    
    return country;
}

- (NSString *)deleteSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)formateCountryCode
{
    NSString *s = [self substringWithRange:NSMakeRange(0, 1)];
    if ([s isEqualToString:@"+"]) {
        NSString *ns = [self substringWithRange:NSMakeRange(1, self.length - 1)];
        return ns;
    }else {
        return self;
    }
}

@end
