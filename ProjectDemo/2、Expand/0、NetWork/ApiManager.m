//
//  ApiManager.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/2.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "ApiManager.h"
#import "HttpHelper.h"


//static HttpHelper *_helper = [[HttpHelper alloc]init];



@interface ApiManager ()
{
    NSInteger       _nextID;

}

@end

@implementation ApiManager

static ApiManager *_instance = nil;

+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (instancetype)init{
    if (self = [super init]) {
        

        
    }
    return  self;
}

//各接口信息

//+ (RequestID *)LoginWithUserName:(NSString *)username
//                        passwd:(NSString *)passwd
//                     loginType:(LoginType)loginType{
//    return [[[self alloc]init] httpRequestAsyncPostWithApiType:ApiType_login
//                                       parameter:@{@"username":username,
//                                                   @"passwd":passwd}];
//}



@end
