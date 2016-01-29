//
//  StorageManager.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "StorageManager.h"

#define kUserDefaults   [NSUserDefaults standardUserDefaults]

@implementation StorageManager




#pragma mark ------------------------存档------------读档-----------------
+ (id)objectForKey:(NSString *)keyName{
   
    return [kUserDefaults objectForKey:keyName];
}

+ (void)setObject:(id)value forKey:(NSString *)keyName{
    [kUserDefaults setObject:value forKey:keyName];
    [kUserDefaults synchronize];
    
}

+ (BOOL)boolForKey:(NSString *)keyName{
    
    return [kUserDefaults boolForKey:keyName];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)keyName{
    
    [kUserDefaults setBool:value forKey:keyName];
    [kUserDefaults synchronize];
}

@end
