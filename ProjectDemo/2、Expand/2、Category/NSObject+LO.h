//
//  NSObject+LO.h
//  YM
//
//  Created by locojoy on 15/10/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LO)



#pragma mark -  JSON解析

/**
 *  将JSON数据转换为founcation对象
 *
 */
+ (id)jsonToFouncation;


/**
 *  将founcation对象转换为JSON数据
 *
 */
+ (NSString *)jsonFromFouncation;


// 设置数据
- (void)setValues:(NSDictionary *)values;

- (void)setObjectIfNotNull:(id)anObject forKey:(id <NSCopying>)aKey;


@end
