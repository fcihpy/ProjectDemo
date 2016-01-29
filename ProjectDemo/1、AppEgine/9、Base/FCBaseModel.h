//
//  FCBaseModel.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/26.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FCBaseModel : NSObject<NSCopying, NSCoding>

/**
 *  获得Model中所keys
 */
- (NSArray *)getPropertyKeys;

/**
 *  获得Model中所Values
 */
- (NSArray *)getPropertyValues;

/**
 *  将model转换为NSDict
 */
- (NSDictionary *)convertToDictionary;

/**
 *  初始化一个model，数据源是dict
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 *  获得Model中所对应的表名,返回对应表名的NSString
 */




@end
