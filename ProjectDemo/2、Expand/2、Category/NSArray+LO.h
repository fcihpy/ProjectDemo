//
//  NSArray+LO.h
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LO)

/**
 *  多关键字排序 ascend :YES-表示升序  NO:表示降序
 *
 */
- (NSArray *)sortedArrayUsingKeys:(NSArray *)keys ascending:(BOOL)ascend;


/**
 *  两俩匹配
 *
 */
- (NSArray *)arrpiforSource;


- (NSArray *)sortArryByTag;

@end
