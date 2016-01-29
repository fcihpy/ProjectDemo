//
//  StorageManager.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManager : NSObject


#pragma mark ------------------------存档------------读档-----------------

+ (id)objectForKey:(NSString *)keyName;
+ (void)setObject:(id)value forKey:(NSString *)keyName;

+ (BOOL)boolForKey:(NSString *)keyName;
+ (void)setBool:(BOOL)value forKey:(NSString *)keyName;


@end
