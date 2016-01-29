//
//  HttpRequestHelper.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/18.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "RequestID.h"
#import "ApiInfo.h"
#import "FCError.h"


@class HttpRequestHelper;

@protocol HttpRequestDelegate <NSObject>

@required
/*!
 @method        httpRequestDidFinish
 @abstract      请求完成（请求有返回）后的回调方法
 @discussion    代理类中实现
 @param         receiveMsg  HttpMessage对象
 */
- (void)httpRequestDidFinish:(HttpRequestHelper *)requestHelper
                   requestID:(RequestID *)requestID
               successObject:(id)successObject;

/*!
 @method        httpRequestDidFailed
 @abstract      请求失败（超时，网络未链接等错误）后的回调方法
 @discussion    代理类中实现
 @param         receiveMsg  HttpMessage对象
 */
- (void)httpRequestDidFailed:(HttpRequestHelper *)requestHelper
                   requestID:(RequestID *)requestID
                 errorObject:(NSError *)errorObject;

/*!
 @method        httpRequestStart
 @abstract      请求开始的回调方法
 @discussion    代理类中实现
 @param         receiveMsg  HttpMessage对象
 */
- (void)httpRequestStart:(HttpRequestHelper *)requestHelper
               requestID:(RequestID *)requestID;

@end



@interface HttpRequestHelper : NSObject

//请求结果的回调
@property (nonatomic, copy) void (^successCompletionBlock)(id responseObject);
@property (nonatomic, copy) void (^failureCompletionBlock)(NSError *error);

@property (nonatomic,weak) id<HttpRequestDelegate>delegate;


//请求标识的操作
- (void)addRequest:(RequestID *)request;
- (void)cancelRequestWithRequestID:(RequestID *)requestID;
- (void)cancelAllRequest;


+ (HttpRequestHelper *)shareInstance;

//POST请求
+ (void)postWithPath:(NSString *)path
              parameters:(NSDictionary *)parameters
        successBlock:(void (^)(id responseObject))successBlock
        failureBlock:(void (^)(NSError *error))failureBlock;

//GET请求
+ (void)getWithPath:(NSString *)path
             parameters:(NSDictionary *)parameters
       successBlock:(void (^)(id responseObject))successBlock
       failureBlock:(void (^)(NSError *error))failureBlock;

//请求标识的操作
- (void)addRequest:(RequestID *)request;
- (void)cancelRequestWithRequest:(RequestID *)request;
- (void)cancelAllRequest;

@end
