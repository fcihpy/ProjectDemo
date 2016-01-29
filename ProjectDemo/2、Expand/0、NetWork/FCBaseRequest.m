//
//  FCBaseRequest.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "FCBaseRequest.h"

@implementation FCBaseRequest

#pragma mark - 由子类继承来覆盖默认值的方法

- (void)requestCompleteFilter{
    
}

- (void)requestFailedFilter{
    
}

- (NSString *)requestUrl{
    return @"";
}

- (NSString *)cdnUrl{
    return @"";
}

- (NSString *)baseUrl{
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval{
    return 60;
}

- (id)requestArgument{
    return nil;
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument{
    return argument;
}

- (FCRequestMethod)requestMethod{
    return FCRequestMethodPost;
}

- (FCRequestSerializerType)requestSerializerType{
    return FCRequestSerializerTypeHTTP;
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    return nil;
}

- (NSURLRequest *)buildCustomUrlRequest{
    return nil;
}

- (BOOL)useCDN{
    return NO;
}

- (id)jsonValidator{
    return nil;
}

- (BOOL)statusCodeValidator{
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >=200 && statusCode <=299) {
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)resumableDownloadPath{
    return nil;
}

- (AFConstructingBlock)constructingBodyBlock{
    return nil;
}

- (AFDownloadProgressBlock)resumableDownloadProgressBlock{
    return  nil;
}

#pragma mark - queue operation

- (void)start{
  
}

- (void)stop{
    
    
}

- (BOOL)isExecuting{
    return self.requestOperation.isExecuting;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(FCBaseRequest *))success failure:(void (^)(FCBaseRequest *))failure{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(FCBaseRequest *))success failure:(void (^)(FCBaseRequest *))failure{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock{
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (NSString *)responseString{
    return self.requestOperation.responseString;
}

- (id)responseJSONObject{
    return self.requestOperation.responseObject;
}

- (NSInteger)responseStatusCode{
    return self.requestOperation.response.statusCode;
}

- (NSDictionary *)responseHeaders{
    return self.requestOperation.response.allHeaderFields;
}



#pragma mark - Request Accessoies
- (void)addAccessory:(id<FCRequestAccessory>)accessory{
    if (self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}


@end
