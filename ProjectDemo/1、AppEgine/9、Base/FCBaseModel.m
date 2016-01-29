//
//  FCBaseModel.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/26.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "FCBaseModel.h"
#import <objc/runtime.h>

@implementation FCBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    NSError *error;
    if ([self validateValue:&value forKey:key error:&error]) {
        [super setValue:value forKey:key];
        
    }else{
        DLog(@"Error value for key [%@]",key);
        [super setValue:nil forKey:key];
    }
    if (error) {
        DLog(@"error is %@",error);
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setNilValueForKey:(NSString *)key{
    [self setValue:@"" forKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        NSUInteger count = 0;
        
        //获取类中所有成员变量名
        Ivar *ivarArry = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar ivar = ivarArry[i];
            const char *ivarName = ivar_getName(ivar);
            NSString *instanceName = [NSString stringWithUTF8String:ivarName];
            
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:instanceName];
            
            //利用kvc对属性赋值
            [self setValue:value forKey:instanceName];
        }
        free(ivarArry);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    NSInteger count = 0;
    
    //获取类中所有成员变量名
    Ivar *ivarArry = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarArry[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *instanceName = [NSString stringWithUTF8String:ivarName];

        //利用kvc取值
        id value = [self valueForKey:instanceName];
        [aCoder encodeObject:value forKey:instanceName];
    }
    free(ivarArry);
}

- (NSArray *)getPropertyKeys{
    
    NSUInteger count = 0;
    objc_property_t *propertyArry = class_copyPropertyList([self class], &count);
    NSMutableArray *keys = [[NSMutableArray alloc]initWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyArry[i];
        const char *propertyChar = property_getName(property);
        NSString *propertyName = [[NSString alloc]initWithCString:propertyChar encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(propertyArry);
    return keys;
}

- (NSArray *)getPropertyValues{
    return [[self convertToDictionary] allValues];
}

- (NSDictionary *)convertToDictionary{
    return [self dictionaryWithValuesForKeys:[self getPropertyKeys]];
}

- (NSString *)description{
    
     return [NSString stringWithFormat:@"%@",[self dictionaryWithValuesForKeys:[self getPropertyKeys]]];
}

@end
