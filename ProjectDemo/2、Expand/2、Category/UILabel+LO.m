//
//  UILabel+LO.m
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UILabel+LO.h"
#import "LOHelp.h"

@implementation UILabel (LO)


-(void) setSubText:(NSString *)text subs:(NSArray *)subText withColor:(UIColor *)color{
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:text];
    for (id obj in subText) {
        NSString *strSub = nil;
        if ([obj isKindOfClass:[NSNumber class]]) {
            strSub = [NSString stringWithFormat:@"%@", obj];
        }else if ([obj isKindOfClass:[NSString class]]) {
            strSub = obj;
        }
        
        if (IS_NOT_EMPTY(strSub)) {
            NSRange range = [text rangeOfString:strSub];
            if (range.location != NSNotFound) {
                [newString addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
        }
    }
    self.attributedText = newString;
}

-(void) setSubText:(NSString *)text subs:(NSArray *)subText  withFont:(UIFont *)font withColor:(UIColor *)color
{
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSString *strSub in subText) {
        NSRange range = [text rangeOfString:strSub];
        if (range.location != NSNotFound) {
            [newString addAttribute:NSForegroundColorAttributeName value:color range:range];
            [newString addAttribute:NSFontAttributeName value:font range:range];
        }
    }
    self.attributedText = newString;
}

-(void) setSubWithRanges:(NSString *)text ranges:(NSArray *) ranges withColor:(UIColor *)color
{
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSValue *value in ranges) {
        NSRange range = [value rangeValue];
        if (range.location != NSNotFound) {
            [newString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    self.attributedText = newString;
}
//这儿最好的办法是 使用 正则表达式进行 过滤出来，但是 正则记不清怎么写了 暂且不用吧 写吧
-(void) setTextWithName:(NSString *)text color:(UIColor *)color
{
    NSString *begin = @"[@]";
    NSString *end = @"[$]";
    NSRange range =  [text rangeOfString:begin];
    NSRange er = [text rangeOfString:end];
    NSMutableArray *subArr = [NSMutableArray array];
    NSMutableString *srcString = [[NSMutableString alloc] initWithString:text];
    while (range.location != NSNotFound && er.location != NSNotFound) {
        NSRange subRnage = NSMakeRange(range.location+range.length, er.location - (range.location+range.length));
        if (subRnage.location + subRnage.length >= [srcString length]) {
            
        }
        NSString *substring = [srcString substringWithRange:subRnage];
        [subArr addObject:substring];
        NSRange delRange = NSMakeRange(subRnage.location - [begin length], subRnage.length+begin.length+end.length);
        if (subRnage.location + subRnage.length >= [srcString length]) {
            
        }
        [srcString deleteCharactersInRange:delRange];
        range =  [srcString rangeOfString:begin];
        er = [srcString rangeOfString:end];
    }
    
    NSMutableString *newString = [[NSMutableString alloc] initWithString:text];
    [newString  replaceOccurrencesOfString:begin withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [newString  replaceOccurrencesOfString:end withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [self setSubText:newString subs:subArr withColor:color];
}

-(NSString *) setTextWithNamenew:(NSString *)text color:(UIColor *)color
{
    NSString *begin = @"[@]";
    NSString *end = @"[$]";
    NSRange range =  [text rangeOfString:begin];
    NSRange er = [text rangeOfString:end];
    NSMutableArray *subArr = [NSMutableArray array];
    NSMutableString *srcString = [[NSMutableString alloc] initWithString:text];
    while (range.location != NSNotFound && er.location != NSNotFound) {
        NSRange subRnage = NSMakeRange(range.location+range.length, er.location - (range.location+range.length));
        if (subRnage.location + subRnage.length >= [srcString length]) {
            
        }
        NSString *substring = [srcString substringWithRange:subRnage];
        [subArr addObject:substring];
        NSRange delRange = NSMakeRange(subRnage.location - [begin length], subRnage.length+begin.length+end.length);
        if (subRnage.location + subRnage.length >= [srcString length]) {
            
        }
        [srcString deleteCharactersInRange:delRange];
        range =  [srcString rangeOfString:begin];
        er = [srcString rangeOfString:end];
    }
    
    NSMutableString *newString = [[NSMutableString alloc] initWithString:text];
    [newString  replaceOccurrencesOfString:begin withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [newString  replaceOccurrencesOfString:end withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [self setSubText:newString subs:subArr withColor:color];
    return newString;
}

// 得到字符串 中 从bgString 到endString 之间的 坐标
+(NSArray *) stringByRangesOfString:(NSString *)source begin:(NSString *)bgString end:(NSString *)endString
{
    NSMutableString *tmpString = [[NSMutableString alloc] initWithString:source];
    NSRange range =  [tmpString rangeOfString:bgString];
    NSRange er = [tmpString rangeOfString:endString];
    NSMutableArray *subRanges = [[NSMutableArray alloc] init];
    
    NSInteger delleng = 0;
    while (range.location != NSNotFound && er.location != NSNotFound){
        
        NSRange subRnage = NSMakeRange(range.location + delleng,er.location - (range.location+range.length));
        NSValue *value = [NSValue valueWithRange:subRnage];
        [subRanges addObject:value];
        
        [tmpString deleteCharactersInRange:range];
        [tmpString deleteCharactersInRange:NSMakeRange(er.location - range.length, er.length)];
        //delleng =  range.length + er.length;
        range =  [tmpString rangeOfString:bgString];
        er = [tmpString rangeOfString:endString];
        
    }
    return subRanges;
}

-(void) setTextWithNameRange:(NSString *)text color:(UIColor *)color
{
    NSString *begin = @"[@]";
    NSString *end = @"[$]";
    
    NSArray *arr = [[self class] stringByRangesOfString:text begin:begin end:end];
    
    NSMutableString *newString = [[NSMutableString alloc] initWithString:text];
    [newString  replaceOccurrencesOfString:begin withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [newString  replaceOccurrencesOfString:end withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [self setSubWithRanges:newString ranges:arr withColor:color];
    
#if 0
    NSString *begin = @"[@]";
    NSString *end = @"[$]";
    NSRange range =  [text rangeOfComposedCharacterSequenceAtIndex:begin];
    NSRange er = [text rangeOfString:end];
    NSMutableArray *subArr = [NSMutableArray array];
    NSMutableString *srcString = [[NSMutableString alloc] initWithString:text];
    while (range.location != NSNotFound && er.location != NSNotFound) {
        NSRange subRnage = NSMakeRange(range.location+range.length, er.location - (range.location+range.length));
        if (subRnage.location + subRnage.length >= [srcString length]) {
            
        }
        
        [subArr addObject:[NSValue valueWithRange:NSMakeRange(subRnage.location - i + delleng, subRnage.length)]];
        range =  [srcString rangeOfString:begin];
        er = [srcString rangeOfString:end];
    }
    
    NSMutableString *newString = [[NSMutableString alloc] initWithString:text];
    [newString  replaceOccurrencesOfString:begin withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    [newString  replaceOccurrencesOfString:end withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, newString.length)];
    // [self setSubText:newString subs:subArr withColor:color];
    
    [self setSubWithRanges:newString ranges:subArr withColor:color];
#endif
}




@end
