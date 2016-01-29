//
//  RequestID.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

/**
  网络请求的标识
 */

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ApiInfo.h"
typedef void(^ResultBolck)(BOOL isSuccess,id object);

@class  RequestID;

@interface RequestID : NSObject

//客户端请求信息
@property(nonatomic,strong)AFHTTPRequestOperation           *requestOperation;  //请求的消息体
@property(nonatomic,copy)NSString                           *requestUrl;        //请求的url
@property(nonatomic,assign)NSInteger                         tag;               //请求的标识,与APItype值一致

//回调方法
@property(nonatomic,copy)ResultBolck                        resultBlock;       //请求的block回调

//服务端响应信息
//@property (nonatomic, copy) NSString                        *errorCode;         // 错误码
//@property (nonatomic, copy) NSString                        *responseString;    // 响应信息
//@property (nonatomic, strong) NSDictionary                  *jasonItems;
//@property (nonatomic, assign) BOOL                          canMultipleConcurrent;   //请求是否可以多个并行
//@property (nonatomic, strong) NSMutableArray                *addedCookies;
//@property (nonatomic, assign) NSInteger                     responseStatusCode;
//@property (nonatomic, strong) NSError                       *error;
//@property (nonatomic, strong) NSMutableDictionary           *additionValues;
////@property (nonatomic, assign) FCRequestMethod               requestMethod;
//@property (nonatomic, strong) NSData                        *postData;         // 二进制流 如 图片数据
//
//

////@property (nonatomic, weak) id<HttpResponseDelegate>        delegate;          //请求的delegate回调
//
//
//
//@property (nonatomic, assign) CGFloat  timeout;

//- (void)setResultBlock:(void (^)(BOOL isSuccess,id object))resultBlock;
//+ (instancetype)requestWithApiType:(NSUInteger)apiType operation:(id)operation idTag:(NSUInteger)tag;
+ (instancetype)requestWithTag:(NSInteger)tag requestUrl:(NSString *)requestUrl;

/*!
 @method        initWithDelegate:requestUrl:postDataDic:cmdCode:
 @abstract      初始化方法，参数为必须字段
 @param         delegate  接收回调方法的代理
 @param         url       发送请求的url
 @param         postDic   发送请求的参数
 @param         apiType   该请求的唯一标识
 @result        RequestID 对象
 */
//- (id)initWithDelegate:(id<HttpResponseDelegate>)delegate
//            requestUrl:(NSString *)url
//           postDataDict:(NSDictionary *)postDict
//               apiType:(ApiType)apiType;

/*!
 @method        cancelDelegate
 @abstract      取消代理，并取消对应的AFNHTTP请求
 */
//- (void)cancelDelegate;


@end
