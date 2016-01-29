//
//  FCNetworkConfig.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//
/**
 统一设置网络请求的服务器和 CDN 的地址。
 管理网络请求的 YTKUrlFilterProtocol 实例
 */

#import <Foundation/Foundation.h>
#import "FCBaseRequest.h"

@class FCNetworkConfig;

@protocol FCUrlFilterProtocol <NSObject>
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(FCBaseRequest *)request;
@end

@protocol FCCacheDirPathFilterProtocol <NSObject>
- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(FCBaseRequest *)request;
@end

@interface FCNetworkConfig : NSObject

@property (strong, nonatomic) NSString          *baseUrl;
@property (strong, nonatomic) NSString          *cdnUrl;
@property (strong, nonatomic, readonly) NSArray *urlFilters;
@property (strong, nonatomic, readonly) NSArray *cacheDirPathFilters;

+ (FCNetworkConfig *)sharedInstance;

- (void)addUrlFilters:(id<FCUrlFilterProtocol>)filter;
- (void)addCacheDirPathFilter:(id <FCCacheDirPathFilterProtocol>)filter;

@end
