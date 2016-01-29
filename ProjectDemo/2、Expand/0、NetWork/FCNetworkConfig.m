//
//  FCNetworkConfig.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "FCNetworkConfig.h"

@implementation FCNetworkConfig
{
    NSMutableArray *_urlFilters;
    NSMutableArray *_cacheDirPathFilters;
}


+ (FCNetworkConfig *)sharedInstance{
    static FCNetworkConfig *_instance= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init{
    if (self = [super init]) {
        _urlFilters = [NSMutableArray array];
        _cacheDirPathFilters = [NSMutableArray array];
    }
    return self;
}

- (void)addUrlFilters:(id<FCUrlFilterProtocol>)filter{
    [_urlFilters addObjectsFromArray:filter];
}

- (void)addCacheDirPathFilter:(id<FCCacheDirPathFilterProtocol>)filter{
    [_cacheDirPathFilters addObject:filter];
}

- (NSArray *)urlFilters{
    return [_urlFilters copy];
}

- (NSArray *)cacheDirPathFilters{
    return [_cacheDirPathFilters copy];
}

@end
