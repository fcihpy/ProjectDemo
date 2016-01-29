//
//  NSObject+LO.m
//  YM
//
//  Created by locojoy on 15/10/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "NSObject+LO.h"

@implementation NSObject (LO)

#pragma mark 将JSON数据转换为founcation对象
+ (id)jsonToFouncation{
    
    __autoreleasing NSError *error = nil;
    id result = nil;
    NSData *jsonData = nil;
    if ([self isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([self isKindOfClass:[NSData class]] ){
        jsonData = (NSData *)self;
    }
    result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

#pragma mark 将founcation对象转换为JSON数据
+ (NSString *)jsonFromFouncation{
    
    NSString *jsonStr = nil;
    NSError *error = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
        if (error != nil) {
            return nil;
        }
        if (jsonData) {
            jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    return jsonStr;
}


- (void)setValues:(NSDictionary *)values
{
//    Class c = [self class];
//    
//    while (c) {
//        // 1.获得所有的成员变量
//        unsigned int outCount = 0;
//        Ivar *ivars = class_copyIvarList(c, &outCount);
//        
//        for (int i = 0; i<outCount; i++) {
//            Ivar ivar = ivars[i];
//            
//            // 2.属性名
//            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
//            
//            // 删除最前面的_
//            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
//            
//            // 3.取出属性值
//            NSString *key = name;
//            if ([key isEqualToString:@"desc"]) {
//                key = @"description";
//            }
//            if ([key isEqualToString:@"ID"]) {
//                key = @"id";
//            }
//            id value = values[key];
//            if (!value) continue;
//            
//            // 4.SEL
//            // 首字母
//            NSString *cap = [name substringToIndex:1];
//            // 变大写
//            cap = cap.uppercaseString;
//            // 将大写字母调换掉原首字母
//            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:cap];
//            // 拼接set
//            [name insertString:@"set" atIndex:0];
//            // 拼接冒号:
//            [name appendString:@":"];
//            SEL selector = NSSelectorFromString(name);
//            
//            // 5.属性类型
//            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
//            
//            if ([type hasPrefix:@"@"]) { // 对象类型
//                objc_msgSend(self, selector, value);
//            } else  { // 非对象类型
//                if ([type isEqualToString:@"d"]) {
//                    objc_msgSend(self, selector, [value doubleValue]);
//                } else if ([type isEqualToString:@"f"]) {
//                    objc_msgSend(self, selector, [value floatValue]);
//                } else if ([type isEqualToString:@"i"]) {
//                    objc_msgSend(self, selector, [value intValue]);
//                }  else {
//                    objc_msgSend(self, selector, [value longLongValue]);
//                }
//            }
//        }
//        
//        c = class_getSuperclass(c);
//    }
}


- (void)setObjectIfNotNull:(id)anObject forKey:(id <NSCopying>)aKey {
    if ([self isKindOfClass:[NSMutableDictionary class]] && anObject) {
        [((NSMutableDictionary *) self) setObject:anObject forKey:aKey];
    }
}


@end
