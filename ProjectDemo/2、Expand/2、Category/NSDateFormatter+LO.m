//
//  NSDateFormatter+LO.m
//  YM
//
//  Created by locojoy on 15/10/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "NSDateFormatter+LO.h"

@implementation NSDateFormatter (LO)


+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
