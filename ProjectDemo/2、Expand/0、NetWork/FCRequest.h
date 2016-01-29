//
//  FCRequest.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "FCBaseRequest.h"

@interface FCRequest : FCBaseRequest


/**
 * 返回当前缓存的对象
 */
- (id)cacheJson;

/**
* 是否当前的数据从缓存获得
*/
- (BOOL)isDataFromCache;

/**
* 是否当前缓存已经过期，需要更新
*/
- (BOOL)isCacheVersionExpired;

/**
* 强制更新缓存
*/
- (void)startWithoutCache;

/**
* 手动将其他请求的JsonResponse写入该请求的缓存
*/
- (void)saveJsonResponeseToCacheFile:(id)jsonResponese;

//以下方法可以由子类覆盖
- (NSInteger)cacheTimerInSeconds;
- (long long)cacheVersion;
- (id)cacheSensitiveData;

@end
