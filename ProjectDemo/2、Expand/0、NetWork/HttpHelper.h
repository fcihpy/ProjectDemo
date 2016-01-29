////
////  HttpRequest.h
////  BaseProjectDemo
////
////  Created by locojoy on 15/10/26.
////  Copyright (c) 2015年 fcihpy. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "HttpConst.h"
//
//@class RequestID;
//@class Request;
//@class FCError;
//@class HttpHelper;
//
//@protocol HttpRequestDelegate <NSObject>
//
//@required
///*!
// @method        httpRequestDidFinish
// @abstract      请求完成（请求有返回）后的回调方法
// @discussion    代理类中实现
// @param         receiveMsg  HttpMessage对象
// */
//- (void)httpRequestDidFinish:(HttpHelper *)requestObject
//                requestID:(RequestID *)requestID
//            successObject:(id)successObject;
//
///*!
// @method        httpRequestDidFailed
// @abstract      请求失败（超时，网络未链接等错误）后的回调方法
// @discussion    代理类中实现
// @param         receiveMsg  HttpMessage对象
// */
//- (void)httpRequestDidFailed:(HttpHelper *)requestObject
//                requestID:(RequestID *)requestID
//             errorObject:(FCError *)errorObject;
//
///*!
// @method        httpRequestStart
// @abstract      请求开始的回调方法
// @discussion    代理类中实现
// @param         receiveMsg  HttpMessage对象
// */
//- (void)httpRequestStart:(HttpHelper *)requestObject
//               requestID:(RequestID *)requestID;
//
//@end
//
//typedef NS_ENUM(NSInteger,FCHttpRequestType) {
//    FCHttpRequestTypeGet        = 0,
//    FCHttpRequestTypePOST       = 1,
//    FCHttpRequestTypeDelegate   = 2,
//    
//};
//
///**
// *  请求开始前预处理Block
// */
//typedef void(^PrepareExecuteBlock)(void);
//
//@interface HttpHelper : NSObject
//
//@property(nonatomic,weak)id<HttpRequestDelegate>    delegate;
//
//@property(nonatomic,strong)NSDictionary             *userInfo;
//
////获取实例方法
//+ (HttpHelper *)httpRequestWithDelegate:(id<HttpRequestDelegate>)httpRequestDelegate;
//- (HttpHelper *)initHttpRequestWithDelegate:(id<HttpRequestDelegate>)httpRequestDelegate;
//+ (HttpHelper *)defaultHttpHelper;
//
////获取某个请求标识
//- (Request *)findRequest:(AFHTTPRequestOperation *)requestOperation;
//- (Request *)currentRequest:(AFHTTPRequestOperation *)requestOperation;
//
////请求标识的操作
//- (void)addRequest:(RequestID *)request;
//- (void)cancelRequestWithRequest:(RequestID *)request;
//- (void)cancelAllRequest;
//
////请求成功或失败
//- (void)requestFinshed:(AFHTTPRequestOperation *)requestOperation;
//- (void)requestFailed:(AFHTTPRequestOperation *)requestOperation;
//
////返回数据解析
//- (void)analysisRespone:(AFHTTPRequestOperation *)requestObject;
//- (id)analysisProtocol:(NSDictionary *)dict type:(NSUInteger)type;
//
//- (id)httpRequestWithPost:(NSUInteger)type param:(id)param;
//- (id)httpRequestWithGet:(NSUInteger)type param:(NSDictionary *)param;
//
////请求成功或失败的通知方法
//- (void)notifySuccessObject:(id)successObject request:(RequestID *)request;
//- (void)notifyErrorObject:(FCError *)errorObject request:(RequestID *)request;
//
////检查返回结果有效性
//- (id) checkIsSuccess:(NSDictionary *)dict type:(NSUInteger)type;
//- (NSString *)errorTextWithCode:(NSInteger)errorCode;
//
//- (Request *)httpRequestAsyncPostWithApiType:(ApiType)apiType parameter:(id)parameter;
//
////以下方法由子类继承来覆盖默认值
//
//
///**
// *  HTTP请求（GET、POST、DELETE、PUT）
// *
// *  @param path
// *  @param method     RESTFul请求类型
// *  @param parameters 请求参数
// *  @param prepare    请求前预处理块
// *  @param success    请求成功处理块
// *  @param failure    请求失败处理块
// */
//- (void)requestWithPath:(NSString *)aPath
//                 method:(NSInteger)aMethod
//             parameters:(id)aParameters
//         prepareExecute:(PrepareExecuteBlock)aPrepareExecute
//                 sucessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))aSucessBlock
//                failureBlock:(void (^)(NSURLSessionDataTask *task, NSError *error))aFailureBlock;
//
//
//@end
