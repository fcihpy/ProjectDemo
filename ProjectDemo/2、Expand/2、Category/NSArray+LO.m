//
//  NSArray+LO.m
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "NSArray+LO.h"

@implementation NSArray (LO)


- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *arrStr = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    //遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [arrStr appendFormat:@"\t%@", obj];
        
        if (idx < self.count - 1) {
            [arrStr appendString:@",\n"];
        }
    }];
    
    [arrStr appendString:@"\n)"];
    
    return arrStr;
    
}

#pragma mark - 多关键字排序
- (NSArray *) sortedArrayUsingKeys:(NSArray *)keys ascending:(BOOL)ascend
{
    NSMutableArray *tempArry = [[NSMutableArray alloc] init];
    for (NSString *key in keys) {
        NSSortDescriptor *ptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascend];
        [tempArry addObject:ptor];
    }
    return [self sortedArrayUsingDescriptors:tempArry];
}

//两俩匹配
- (NSArray *) arrpiforSource
{
    NSMutableArray *ra = [[NSMutableArray alloc] init];
    NSInteger len = [self count];
    for (NSInteger i = 0; i < len; i++) {
        for (NSInteger j = i+1; j < len; j++) {
            NSRange range = NSMakeRange(i, j);
            NSValue *value = [NSValue valueWithRange:range];
            [ra addObject:value];
        }
    }
    return ra;
}


//- (NSArray *)sortArryByTag{
//    return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        
//        if ([obj1 respondsToSelector:@selector(tag)] && [obj2 respondsToSelector:@selector(tag)]) {
//            if ([obj1 tag] < [obj2 tag]) return NSOrderedAscending;
//            
//            else if ([obj1 tag] > [obj2 tag]) return NSOrderedDescending;
//            
//            else return NSOrderedSame;
//        }else return NSOrderedSame;
//    }];
//}


@end
