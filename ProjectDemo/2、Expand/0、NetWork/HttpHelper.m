////
////  HttpRequest.m
////  BaseProjectDemo
////
////  Created by locojoy on 15/10/26.
////  Copyright (c) 2015年 fcihpy. All rights reserved.
////
//
//#import "HttpHelper.h"
//#import "FCError.h"
//#import "ApiInfo.h"
//#import "NSString+JSONCategories.h"
//
//#define kLoginKey @"login_key"
//#define kEncparam @"encparam"
//#define kParameter @"parameter"
//
//@interface HttpHelper()
//{
//    dispatch_queue_t _queue;
//    NSLock           *_relock;
//    NSMutableArray   *_requestObjects;
//    NSInteger        _nextID;
//    NSDictionary     *_errorInfo;
//}
//@property(nonatomic,strong) AFHTTPSessionManager *manager;
//@end
//
//
//@implementation HttpHelper
//
//- (instancetype)init{
//    if (self = [super init]) {
//        self.manager = [AFHTTPSessionManager manager];
//        
//        //请求参数序列化类型
//        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        
//        //响应结果序列化类型
//        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    }
//    return self;
//}
//
//+ (HttpHelper *)defaultHttpHelper{
//    static HttpHelper *_instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc]init];
//    });
//    return _instance;
//}
//
//#pragma mark - request相关
//- (void)addRequest:(RequestID *)Request{
//    
//    [_relock lock];
//    [_requestObjects addObject:Request];
//    [_relock unlock];
//}
//
//- (RequestID *)currentRequest:(AFHTTPRequestOperation *)requestObject{
//    
//    RequestID *rid = nil;
//    [_relock lock];
//    if (_requestObjects.count > 0) {
//        rid = [_requestObjects lastObject];
//    }
//    [_relock unlock];
//    return rid;
//}
//
//- (RequestID *)findRequest:(AFHTTPRequestOperation *)requestOperation{
//    
////    NSString *name = requestOperation.userInfo[@"name"];
////    NSNumber *idtag = requestOperation.userInfo[@"idtag"];
////    
////    for (RequestID *request in _requestObjects) {
////        if ([request.name isEqualToString:name] &&
////            request.type == requestOperation.tag &&
////            [idtag isEqualToNumber:request.idTag]) {
////            
////            return request;
////        }
////    }
//    return nil;
//}
//
//- (void)cancelAllRequest{
//    
////    [_relock lock];
////    for (RequestID *rid in _requestObjects) {
////        AFHTTPRequestOperation *afnRequestObject = rid.operation;
////        [afnRequestObject setCompletionBlockWithSuccess:nil failure:nil];
////        [afnRequestObject cancel];
////    }
////    
////    _delegate = nil;
////    [_requestObjects removeAllObjects];
////    [_relock unlock];
//}
//
//#pragma mark - 初始化实例
//- (instancetype)initHttpRequestWithDelegate:(id<HttpRequestDelegate>)httpRequestDelegate{
//    
//    if (self = [super init]) {
//        _nextID = 0;
//        _requestObjects = [[NSMutableArray alloc]init];
//        _relock = [[NSLock alloc] init];
//        _delegate = httpRequestDelegate;
//        _errorInfo = [ResourceManager readPlist:ERROR_FILE];
//    }
//    return self;
//}
//
//+ (instancetype)httpRequestWithDelegate:(id<HttpRequestDelegate>)httpRequestDelegate{
//    
//    return [[[self class] alloc]initHttpRequestWithDelegate:httpRequestDelegate];
//}
//
//#pragma mark - 请求方法
//- (id)httpRequestWithGet:(NSUInteger)type param:(NSDictionary *)param{
//    
//    return param;
//}
//
//- (id)httpRequestWithPost:(NSUInteger)type param:(id)param{
//    
//    return param;
//}
//
//#pragma mark - request请求周期
//
//#pragma mark - 对外开放的网络请求接口
//- (RequestID *)httpRequestAsyncPostWithApiType:(ApiType)apiType parameter:(id)parameter{
//    
//    return [self httpRequestWithHttpMothd:@"POST"
//                                  ApiType:apiType
//                constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                    
//                    if (parameter && [parameter isKindOfClass:[NSDictionary class]]) {
//                        
//                        NSString *bodyStr = [parameter JSONString];
//                        NSData *jsonData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//                        [formData appendPartWithFormData:jsonData name:kParameter];
//                        DLog(@"post[%ld] body:%@",apiType,bodyStr);
//                        
//                    }else if (parameter && [parameter isKindOfClass:[NSArray class]]){
//                        
//                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
//                        [formData appendPartWithFormData:jsonData name:kParameter];
//                        
//                    }else if (parameter == nil){
//                        
//                    }
//                    
//                }];
//}
//
//#pragma mark - 总的网络请求
//- (RequestID *)httpRequestWithHttpMothd:(NSString *)httpMethod
//                              ApiType:(ApiType)apiType
//            constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block{
//    
//    NSString *requestUrlStr = getRequestURL(apiType);
//    if (STRISEMPTY(requestUrlStr)) {
//        return  nil;
//    }
//    
//    BOOL scheme = getSchemeValue(apiType);
//    
//    NSString *fullRequestUrlStr = [NSString stringWithFormat:@"%@/%@",(scheme)?BASE_URLS:BASE_URL,requestUrlStr];
//    
//    //特殊接口的处理
//    if (apiType == ApiType_test) {
//        
//    }
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *loginKey = nil;
//    
//    if (!STRISEMPTY(loginKey)) {
//        [manager.requestSerializer setValue:loginKey forHTTPHeaderField:kLoginKey];
//    }else{
//        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:kEncparam];
//    }
//    
//    //设置请求和返回格式
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [HttpJson serializer];
//    
//    //设置可接受的JSON类型
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    NSDictionary *parameter = nil;
//    if ([httpMethod isEqualToString:@"GET"] && block) {
//        block((id<AFMultipartFormData>)parameter);
//    }
//    
//    //判断请求的方法是get还是Post
//    NSMutableURLRequest *urlRequest = ([httpMethod isEqualToString:@"POST"])?[manager.requestSerializer multipartFormRequestWithMethod:httpMethod URLString:fullRequestUrlStr parameters:nil constructingBodyWithBlock:block error:nil]:[manager.requestSerializer requestWithMethod:httpMethod URLString:fullRequestUrlStr parameters:nil error:nil];
//    
//    //发起网络请求
//    AFHTTPRequestOperation *requestOperation = [manager HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        [self requestFinshed:operation];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [self requestFailed:operation];
//    }];
//    requestOperation.tag = apiType;
//    
//    //组装请求标识
//    RequestID *request = [Request requestWithApiType:apiType operation:requestOperation idTag:_nextID ++];
//    
//    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(httpStartRequest:request:)]) {
//        [self.delegate httpStartRequest:self request:request];
//    }
//    request.name = requestUrlStr;
//    requestOperation.userInfo = @{@"name":requestUrlStr,@"idTag":request.idTag};
//    
//    [self addRequest:request];
//    
//    //数据加密的入口
//    if (scheme) {
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        securityPolicy.allowInvalidCertificates = YES;
//        requestOperation.securityPolicy = securityPolicy;
//    }
//    
//    [[manager operationQueue] addOperation:requestOperation];
//    return request;
//}
//
//#pragma mark - 请求结束
//- (void)requestFinshed:(AFHTTPRequestOperation *)requestOperation{
//    
//    if (!_queue) {
//        _queue = dispatch_queue_create("httpQueue", nil);
//    }
//    __weak typeof(self) weakSelf = self;
//    dispatch_async(_queue, ^{
//        RequestID *reuqest = [weakSelf findRequest:requestOperation];
//        
//        NSString *responeStr = [requestOperation responseString];
//        NSData *responeData = [responeStr dataUsingEncoding:requestOperation.responseStringEncoding];
//        
//        //解析为json格式
//        NSDictionary *responeDict = [NSJSONSerialization JSONObjectWithData:responeData options:0 error:nil];
//        
//        FCError *error = [self checkIsSuccess:responeDict type:reuqest.type];
//        if (nil == error) {
//            [weakSelf notifySuccessObject:[weakSelf analysisProtocol:responeDict type:reuqest.type] request:reuqest];
//            
//        }else{
//            [weakSelf notifyErrorObject:error request:reuqest];
//        }
//        DLog(@"接收消息[%@] -- json= %@",getRequestURL(reuqest.type),responeStr);
//        
//        [weakSelf cancelAllRequest];
//    });
//}
//
//#pragma mark - 请求失败
//- (void)requestFailed:(AFHTTPRequestOperation *)requestOperation{
//    
//    RequestID *request  = [self findRequest:requestOperation];
//    
//    FCError *error = MAKE_ERROR(NET_TIMEOUT, NET_ERROR_CODE);
//    
//    //将数据返回给block
//    if (request.resultBlock) {
//        request.resultBlock(NO,error);
//    }
//    
//    //将数据返回给delegate
//    if (self.delegate && [self.delegate respondsToSelector:@selector(httpFaileRequest:request:errorObject:)]) {
//        [self.delegate httpFaileRequest:self request:request errorObject:error];
//    }
//    
//    
//}
//
//#pragma mark - 成功的回调
//- (void)notifySuccessObject:(id)successObject request:(RequestID *)request{
//    
//    __block __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        //将数据返回给block
//        if (request.resultBlock) {
//            request.resultBlock(YES,successObject);
//        }
//        
//        //将数据返回给delegate
//        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpFinishRequest:request:successObject:)]) {
//            [weakSelf.delegate httpFinishRequest:weakSelf request:request successObject:successObject];
//        }
//    });
//}
//
//#pragma mark - 失败的回调
//- (void)notifyErrorObject:(FCError *)errorObject request:(RequestID *)request{
//    
//    __block __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        //将数据返回给block
//        if (request.resultBlock) {
//            request.resultBlock(NO,errorObject);
//        }
//        
//        //将数据返回给delegate
//        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpFaileRequest:request:errorObject:)]) {
//            [weakSelf.delegate httpFaileRequest:weakSelf request:request errorObject:errorObject];
//        }
//        
//    });
//}
//
//#pragma mark - 返回数据的解析
//- (id)analysisProtocol:(NSDictionary *)dict type:(NSUInteger)type{
//    
//    @autoreleasepool {
//        
//        id responeData = [dict objectForKey:@"result"];
//        NSNumber *encode = dict[@"encoded"];
//        //加密、解密入口
//        if (encode && encode.integerValue == 1) {
//            
//        }
//        
//        Class modelClassName = getModelClassName(type);
//        DLog(@"数据解析--modelName:%@  type= %ld \n API URL %@",modelClassName,type,getRequestURL(type));
//        
//        id obj = nil;
//        if (modelClassName) {
//            switch (type) {
//                default:
//                    if (responeData &&
//                        responeData != [NSNull class] &&
//                        [responeData isKindOfClass:[NSDictionary class]]) {
//                        obj = [[modelClassName alloc] initWithDictionary:responeData];
//                    }
//                    
//                    if (obj) {
//                        return obj;
//                    }else{
//                        return dict;
//                    }
//                    
//                    break;
//            }
//        }else{
//            return responeData;
//        }
//    }
//   
//    return dict;
//}
//
//#pragma mark - 判断返回的错误码
//- (id) checkIsSuccess:(NSDictionary *)dict{
//    
//    if (!dict) {
//        return MAKE_ERROR(NET_ERROR, NET_ERROR_CODE);
//    }
//    
//    NSNumber *errorCode = [dict valueForKey:@"error"];
//    if (!errorCode) {
//        return MAKE_ERROR(NET_ERROR, NET_ERROR_CODE);
//    }
//    
//    if (errorCode.integerValue != 0) {
//        return MAKE_ERROR([self errorTextWithCode:errorCode.integerValue], errorCode.integerValue);
//    }
//    
//    id result = [dict objectForKey:@"result"];
//    if (!result && errorCode.integerValue != 0) {
//        return MAKE_ERROR(NET_ERROR, NET_ERROR_CODE);
//    }
//    
//    return nil;
//}
//
//- (NSString *)errorTextWithCode:(NSInteger)errorCode{
//    return _errorInfo[[[NSNumber numberWithInteger:errorCode] stringValue] ];
//}
//
//#pragma mark - 上传
//
//
//
//#pragma mark - 下载
//
//
//- (void)dealloc{
//    
//    [self cancelAllRequest];
//    if (_queue) {
//        _queue = nil;
//    }
//}
//
//- (void)requestWithPath:(NSString *)aPath
//                 method:(NSInteger)aMethod
//             parameters:(id)aParameters
//         prepareExecute:(PrepareExecuteBlock)aPrepareExecute
//            sucessBlock:(void (^)(NSURLSessionDataTask *, id))aSucessBlock
//           failureBlock:(void (^)(NSURLSessionDataTask *, NSError *))aFailureBlock{
//    
//    //判断网络情况,有链接：执行请求；无链接：弹出提示）
//    if ([FCUitility isConnectionAvailable]) {
//        //预处理（显示加载信息啥的）
//        if (aPrepareExecute) {
//            aPrepareExecute();
//        }
//        switch (aMethod) {
//            case FCHttpRequestTypeGet:
//            {
//                
//            }
//                break;
//            case FCHttpRequestTypePOST:
//            {
//                
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }else{
//        //网络错误咯
////        [self showExceptionDialog];
//        //发出网络异常通知广播
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
//
//    }
//}
//
//@end
