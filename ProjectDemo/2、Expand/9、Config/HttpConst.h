//
//  httpConst.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/2.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#ifndef BaseProjectDemo_HttpConst_h
#define BaseProjectDemo_HttpConst_h

static float const httpRequestTimeout = 35.0f;

//http请求类型
typedef NS_ENUM(NSInteger, RequestMeThod) {
    RequestMeThodPost       = 0,
    RequestMeThodGet        = 1,
    RequestMeThodStream     = 2,
};


//API接口类型
typedef NS_ENUM(NSInteger, ApiType) {
    ApiType_BEGIN = -1,
    
    //登录、注册
    ApiType_login                    =  0x0001,            //登录
    ApiType_logout                   =  0x0002,
    
    //个人信息
    
    //绩效信息
    
    ApiType_test                    = 0x9000,
    
    APITYPE_END,
};

#import <AFNetworking/AFNetworking.h>
#import "HttpJson.h"
#import "Request.h"


#define BASE_URL            @"https://210.14.130.164:8443"
#define BASE_URLS           @"https://210.14.130.164:8443"
#define kApiInfoKey         @"apiInfoKey"

#endif
