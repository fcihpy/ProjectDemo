//
//  BaseEntity.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "BaseEntity.h"

static NSString * const MSG = @"msg";
static NSString * const STATUS = @"status";
static NSString * const RES = @"res";

@implementation BaseEntity


+ (BaseEntity *)parseResponeErrorJSON:(id)json{
    
    NSString *responeJsonStr = [NSString stringWithFormat:@"%@",json];
    NSData *jsonData = [responeJsonStr dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error)  return nil;
    if ([NSJSONSerialization isValidJSONObject:result]) {
        BaseEntity *baseEntity = [[BaseEntity alloc]init];
        baseEntity.status = (NSNumber *)[result objectForKey:STATUS];
        return nil;
    }
    
    return nil;
}


+ (BaseEntity *)parseResponeStatusJSON:(id)json{
    
    
    return nil;
}

@end
