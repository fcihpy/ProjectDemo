//
//  FCBaseRequest.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking+Ext/AFDownloadRequestOperation.h>


typedef NS_ENUM(NSInteger , FCRequestMethod) {
    FCRequestMethodGet      = 0,
    FCRequestMethodPost     = 1,
    FCRequestMethodHead     = 2,
    FCRequestMethodPut      = 3,
    FCRequestMethodDelete   = 4,
    FCRequestMethodPatch    = 5
};

typedef NS_ENUM(NSInteger , FCRequestSerializerType) {
    FCRequestSerializerTypeHTTP = 0,
    FCRequestSerializerTypeJSON = 1,
};

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);
typedef void (^AFDownloadProgressBlock)(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile);


@class FCBaseRequest;

@protocol FCRequestDelegate <NSObject>

@optional

- (void)requestDidFinished:(FCBaseRequest *)request;
- (void)requestDidFailed:(FCBaseRequest *)request;
- (void)clearAllRequest;

@end

@protocol FCRequestAccessory <NSObject>

@optional

- (void)requestWillStart:(id)request;
- (void)requestWillStop:(id)request;
- (void)requestDidStop:(id)request;

@end

@interface FCBaseRequest : NSObject

@property (nonatomic, assign) NSInteger                 tag;
@property (nonatomic, strong) NSDictionary              *userInfo;
@property (nonatomic, strong) AFHTTPRequestOperation    *requestOperation;
@property (nonatomic, weak) id<FCRequestDelegate>       delegate;
@property (nonatomic, strong, readonly) NSDictionary    *responseHeaders;
@property (nonatomic, strong, readonly) NSString        *responseString;
@property (nonatomic, strong, readonly) id              responseJSONObject;
@property (nonatomic, readonly) NSInteger               responseStatusCode;
@property (nonatomic, strong) NSMutableArray            *requestAccessories;

@property (nonatomic, copy) void (^successCompletionBlock)(FCBaseRequest *);
@property (nonatomic, copy) void (^failureCompletionBlock)(FCBaseRequest *);

- (void)start;
- (void)stop;
- (BOOL)isExecuting;

// block回调
- (void)startWithCompletionBlockWithSuccess:(void (^)(FCBaseRequest *request))success
                                    failure:(void (^)(FCBaseRequest *request))failure;

- (void)setCompletionBlockWithSuccess:(void (^)(FCBaseRequest *request))success
                              failure:(void (^)(FCBaseRequest *request))failure;

// 把block置nil来打破循环引用
- (void)clearCompletionBlock;

///Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<FCRequestAccessory>)accessory;

//以下方法由子类继承来覆盖默认值

/**
 *  请求成功的回调
 */
- (void)requestCompleteFilter;

/**
 *  请求失败的回调
 */
- (void)requestFailedFilter;

/**
 *  请求的URL
 */
- (NSString *)requestUrl;

/**
 *  请求的CdnURL
 */
- (NSString *)cdnUrl;

/**
 *  请求的BaseURL
 */
- (NSString *)baseUrl;

/**
 *   请求的连接超时时间，默认为60秒
 */
- (NSTimeInterval)requestTimeoutInterval;

/**
 *  请求的参数列表
 */
- (id)requestArgument;

/**
 *  用于在cache结束，计算cache文件名时，忽略掉一些指定的参数
 */
- (id)cacheFileNameFilterForRequestArgument:(id)argument;

/**
 *  Http请求的方法
 */
- (FCRequestMethod)requestMethod;

/**
 *  请求的SerializerType
 */
- (FCRequestSerializerType)requestSerializerType;

/**
 *  在HTTP报头添加的自定义参数
 */
- (NSDictionary *)requestHeaderFieldValueDictionary;

/**
 *  是否使用CDN的host地址
 */
- (BOOL)useCDN;

/**
 *  用于检查JSON是否合法的对象
 */
- (id)jsonValidator;

/**
 *  用于检查Status Code是否正常的方法
 */
- (BOOL)statusCodeValidator;

/**
 *  当POST的内容带有文件等富文本时使用
 */
- (AFConstructingBlock)constructingBodyBlock;

/**
 *  当需要断点续传时，指定续传的地址
 */
- (NSString *)resumableDownloadPath;

/**
 *  当需要断点续传时，获得下载进度的回调
 */
- (AFDownloadProgressBlock)resumableDownloadProgressBlock;

/**
 *  构建自定义的UrlRequest，若这个方法返回非nil对象，
 * 会忽略requestUrl, requestArgument, requestMethod, requestSerializerTyp
 */
- (NSURLRequest *)buildCustomUrlRequest;




@end
