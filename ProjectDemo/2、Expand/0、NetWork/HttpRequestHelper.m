//
//  HttpRequestHelper.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/18.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "HttpRequestHelper.h"
#import "NSString+JSONCategories.h"
#import "encdecutils.h"

#pragma mark -  宏定义
typedef NS_ENUM(NSInteger , FCRequestMethod) {
    FCRequestMethodGet      = 0,
    FCRequestMethodPost     = 1,
    FCRequestMethodHead     = 2,
    FCRequestMethodPut      = 3,
    FCRequestMethodDelete   = 4,
    FCRequestMethodPatch    = 5
};

static const NSTimeInterval kRequestTimeout = 15.0f;
static  NSString const *kLoginKey = @"login_key";
static  NSString const *kEncparam_key = @"encparam";
static  NSString const *kParameter_key = @"parameter";
static  NSString const *kRequestUrl_key = @"requestUrl";
static  NSString const *kRequestTag_key = @"requestTag";

#define BASE_URL            @"https://210.14.130.164:8443"
#define BASE_URLS           @"https://210.14.130.164:8443"


#pragma mark -


@interface HttpRequestHelper ()
{
    NSMutableArray      *_requestObjects;
    NSLock              *_reLock;
    dispatch_queue_t    _queue;
}

@property(nonatomic,strong) NSDictionary *errorInfo;

@end

#pragma mark -  @implementation
@implementation HttpRequestHelper

#pragma mark - request相关
- (void)addRequest:(RequestID *)Request{
    
    [_reLock lock];
    [_requestObjects addObject:Request];
    [_reLock unlock];
}

- (RequestID *)currentRequest:(AFHTTPRequestOperation *)requestObject{
    
    RequestID *rid = nil;
    [_reLock lock];
    if (_requestObjects.count > 0) {
        rid = [_requestObjects lastObject];
    }
    [_reLock unlock];
    return rid;
}



//- (void)cancelAllRequest{
//    
//        [_reLock lock];
//        for (RequestID *rid in _requestObjects) {
//            AFHTTPRequestOperation *afnRequestObject = rid.operation;
//            [afnRequestObject setCompletionBlockWithSuccess:nil failure:nil];
//            [afnRequestObject cancel];
//        }
//    
//        _delegate = nil;
//        [_requestObjects removeAllObjects];
//        [_reLock unlock];
//}





- (RequestID *)postWithPath:(NSString *)path
                    apiType:(ApiType)apiType
          parameter:(id)parameter{
    
   return [self requestWithMethod:FCRequestMethodPost apiType:apiType
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
            NSData *requestData = nil;
            if (parameter && [parameter isKindOfClass:[NSDictionary class]]) {
                NSString *bodyString = [parameter JSONString];
                requestData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
                if (getSchemeValue(apiType)) {
                    //进行加密
                }
                
                [formData appendPartWithFormData:requestData name:@"param"];
            }else if (parameter && [parameter isKindOfClass:[NSArray class]]){
                requestData = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
                
            }else if (parameter == nil){
            
            }
            [formData appendPartWithFormData:requestData name:@"param"];
       
   }];
}



#pragma mark - API总的网络请求
- (RequestID *)requestWithMethod:(FCRequestMethod)method
                     apiType:(ApiType)apiType
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block{
    
    // 1.创建http请求对象
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //1.0设置超时时间
    manager.requestSerializer.timeoutInterval = kRequestTimeout;
    
    //1.1设置请求和返回格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [HttpJson serializer];
    
    //1.2设置可接受的JSON类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //1.3设置请求头
    //获取token或KEY
    NSString *loginKey = nil;
    if (!STRISEMPTY(loginKey)) {
        [manager.requestSerializer setValue:loginKey forHTTPHeaderField:kLoginKey];
    }
    
    //特殊接口的处理
    if (ApiType_login == apiType) {
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:kEncparam_key];
    }

    //2、拼接请求参数
     NSMutableDictionary *allParameters = [NSMutableDictionary dictionary];
    
    //2.0获取请求路径参数
    NSString *requestUrlStr = getRequestURL(apiType);
    if (STRISEMPTY(requestUrlStr)) {
        return  nil;
    }
    
    //2.1是否加密的判断
    BOOL scheme = getSchemeValue(apiType);
    
    //2.2拼接URL
    NSString *fullRequestUrlStr = [NSString stringWithFormat:@"%@/%@",(scheme)?BASE_URLS:BASE_URL,requestUrlStr];

    
    //3、请求方法的处理
    NSMutableURLRequest *urlRequest;
    
    if (method == FCRequestMethodGet && block) {
        block((id<AFMultipartFormData>)allParameters);
    }
    
    if (method == FCRequestMethodPost) {
      urlRequest = [manager.requestSerializer requestWithMethod:@"GET" URLString:fullRequestUrlStr parameters:nil error:nil];
    }else if (method == FCRequestMethodGet){
        urlRequest = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:fullRequestUrlStr parameters:nil constructingBodyWithBlock:block error:nil];
    }
 
    //3.0 组装请求标识
    RequestID *requestID = [RequestID requestWithTag:apiType requestUrl:requestUrlStr];
    [self addRequest:requestID];
    
    //3.1发起网络请求
    AFHTTPRequestOperation *requestOperation = [manager HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
        [self requestFinished:responseObject requestID:requestID];
      
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
      
        [self requestFailedWithErrorObject:error requestID:requestID];
    }];
    requestID.requestOperation = requestOperation;
    
    //5、执行情况通知出去
    if (self.delegate && [self.delegate respondsToSelector:@selector(httpRequestStart:requestID:)]) {
        [self.delegate httpRequestStart:self requestID:requestID];
    }
    
    //6、数据加密的入口
    if (scheme) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        requestOperation.securityPolicy = securityPolicy;
    }
    
    //7、添加到队列中,准备执行
    [[manager operationQueue] addOperation:requestOperation];
    
    //8、将结果标识返回
    return requestID;
}

#pragma mark  请求完成执行的方法，包括成功或失败
- (void)requestFinished:(id)responseObject requestID:(RequestID *)requestID {
    if (_queue == nil) {
        _queue = dispatch_queue_create("httpQueue", nil);
    }
    __block __weak typeof(self) weakSelf = self;
    dispatch_async(_queue, ^{
        if (requestID.tag == ApiType_test) {
            
        }else{
            if ([responseObject isKindOfClass:[NSData class]]) {
                id resultDict = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:nil];
                DLog(@"接收到消息[%@]---json=%@",getRequestURL(requestID.tag),resultDict);
                
                //检查网络请求是否成功
                NSError *error = [self checkIsSuccess:resultDict];
                if (nil == error) {
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        
                        //进行数据解析
                        id result = [self analysisProtocol:resultDict requestID:requestID];
                        
                        //通知处理结果
                        [weakSelf notitfySuccessWithResponseObject:result requestID:requestID];
                    }
                }else{
                    [weakSelf notifyErrorObject:error requestID:requestID];
                }
            }
        }
        //取消请求操作
        [weakSelf cancelRequestWithRequestID:requestID];
    });
}

#pragma mark 请求失败执行的方法
- (void)requestFailedWithErrorObject:(NSError *)errorObject requestID:(RequestID *)requestID{
    
    //将数据返回给block
    if (requestID.resultBlock) {
        requestID.resultBlock(NO,errorObject);
    }
    
    //将数据返回给delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(httpRequestDidFailed:requestID:errorObject:)]) {
        [self.delegate httpRequestDidFailed:self requestID:requestID errorObject:errorObject];
    }
    //取消请求操作
    [self cancelRequestWithRequestID:requestID];
}

#pragma mark - 成功的回调
- (void)notitfySuccessWithResponseObject:(id)responseObject requestID:(RequestID *)requestID{
    
   __block __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //将数据返回给block
        if (requestID.resultBlock) {
            requestID.resultBlock(YES,responseObject);
        }
        
        //将数据返回给delegate
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpRequestDidFinish:requestID:successObject:)]) {
            [weakSelf.delegate httpRequestDidFinish:weakSelf requestID:requestID successObject:responseObject];
        }
    });
}

#pragma mark - 失败的回调
- (void)notifyErrorObject:(NSError *)errorObject requestID:(RequestID *)requestID{
    
    __block __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //将数据返回给block
        if (requestID.resultBlock) {
            requestID.resultBlock(NO,errorObject);
        }
        
        //将数据返回给delegate
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpRequestDidFailed:requestID:errorObject:)]) {
            [weakSelf.delegate httpRequestDidFailed:weakSelf requestID:requestID errorObject:errorObject];
        }
        
    });
}

#pragma mark - 返回数据的解析
- (id)analysisProtocol:(NSDictionary *)dict requestID:(RequestID *)requestID{
    
    @autoreleasepool {
        id resultData = [dict objectForKey:@"result"];
        NSNumber *encode = dict[@"encoded"];
        //加密、解密入口
        if (encode && encode.integerValue == 1) {
            
        }
        
        //取出要转换的model类，可以为空
        Class modelClassName = getModelClassName(requestID.tag);
        DLog(@"数据解析--modelName:%@  type= %ld \n API URL %@",modelClassName,requestID.tag,getRequestURL(requestID.tag));
        
        id obj = nil;
        //根据返回的modelclasss名字进行判断，有值则进行解析，否则，直接返回原数据
        if (modelClassName){
            if (nil == resultData &&
                [NSNull class] != resultData &&
                [resultData isKindOfClass:[NSDictionary class]]) {
                obj = [[modelClassName alloc]initWithDictionary:resultData];
            }
        }else{
            return resultData;
        }
    }
    return dict;
}

#pragma mark - 判断返回的错误码
- (id) checkIsSuccess:(NSDictionary *)dict{
    
    if (!dict) {
        return MAKE_ERROR(NET_ERROR, NET_ERROR_CODE);
    }
    
    //取出错误码
    NSNumber *errorCode = [dict valueForKey:@"error"];
    if (!errorCode) {
        return MAKE_ERROR(NET_ERROR, NET_ERROR_CODE);
    }
    
    if (errorCode.integerValue != 0) {
        return MAKE_ERROR([self errorTextWithCode:errorCode.integerValue], errorCode.integerValue);
    }
    
    id result = [dict objectForKey:@"result"];
    if (!result && errorCode.integerValue != 0) {
        return MAKE_ERROR(NET_ERROR, NET_ERROR_CODE);
    }
    
    return nil;
}

- (NSString *)errorTextWithCode:(NSInteger)errorCode{
    return self.errorInfo[[[NSNumber numberWithInteger:errorCode] stringValue] ];
}

#pragma mark - seter/geter
- (NSDictionary *)errorInfo{
    if (!_errorInfo) {
        _errorInfo = [ResourceManager readPlist:ERROR_FILE];
    }
    return _errorInfo;
}

#pragma mark - other
- (void)dealloc{
    [self cancelAllRequest];
    if (_queue) {
        _queue = nil;
    }
}

@end


#pragma mark - 加密、解密

//#pragma mark 加密
//static NSData *httpRequestEncdecutils_encode(NSData *sourceData){
//    
//    //获取secretkey
//    NSString *secretkey = nil;
//    if (STRISEMPTY(secretkey)) {
//        return sourceData;
//    }
//    
//    uint8_t *ebuf, key[43], *buf; int elen = 0;
//    const char *secretkeyChar = [secretkey UTF8String];
//    memcpy(key, secretkeyChar, 43);
// 
//    NSData *encodeData = nil;
//    if (sourceData == nil) {
//        elen = encdecutils_encode(nil, 0, key, 43, &ebuf);
//        encodeData = [NSData dataWithBytes:ebuf length:elen];
//    }else{
//        int klen = (int)secretkey.length;
//        int len = (int)sourceData.length;
//        buf = (uint8_t *)encdecutils_malloc((int)sourceData.length);
//        [sourceData getBytes:buf];
//        elen = encdecutils_encode(buf, len, key, klen, &ebuf);
//        encodeData = [NSData dataWithBytes:ebuf length:elen];
//        encdecutils_free(buf);
//    }
//  
//    encdecutils_free(ebuf);
//    return encodeData;
//   
//}
//
//#pragma mark 解密
//static NSDictionary *httpResponeEncdecutils_decode(NSString *responeStr){
//    
//    //获取secretkey
//    NSString *secretkey = nil;
//    if (STRISEMPTY(secretkey)) {
//        return nil;
//    }
//    int elen = (int)responeStr.length,dlen,klen = (int)secretkey.length;
//    uint8_t *ebuf = (uint8_t *)[responeStr UTF8String];
//    uint8_t key[43],*dbuf = nil;
//    const char *secretkeyChar = [secretkey UTF8String];
//    memcpy(key, secretkeyChar, klen);
//    dlen = encdecutils_decode(ebuf, elen, key, klen, &dbuf);
//    NSDictionary *responeDict = nil;
//    if (dlen > 0 && dbuf) {
//        NSData *data = [NSData dataWithBytes:dbuf length:dlen];
//        responeDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    }
//    if (dbuf) {
//        encdecutils_free(dbuf);
//    }
//    
//    
//    return responeDict;
//}
//


