//
//  ApiInfo.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/3.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "ApiInfo.h"



#pragma mark - 全局实例化所有的接口信息
static ApiInfo f_ApiInfoArry[] = {
    {"LoginResult","/imweb/app/user/logindetail",ApiType_login,NO},
    {nil,"/imweb/app/user/logout",ApiType_logout,NO},
};

const int apiInfoCount = sizeof(f_ApiInfoArry) / sizeof(ApiInfo);


#pragma mark - 根据接口类别，获得要解析的model名
const extern Class getModelClassName(ApiType type){
    
    for (int i = ApiType_BEGIN + 0; i < APITYPE_END; i ++) {
        if (type == f_ApiInfoArry[i].apiType &&
            f_ApiInfoArry[i].modelClassName) {
            NSString *modelNameStr = [NSString stringWithUTF8String:f_ApiInfoArry[i].modelClassName];
            return NSClassFromString(modelNameStr);
        }
    }
    return nil;
}


#pragma mark - 根据接口类别，获得要请求的URL
const extern NSString *getRequestURL(ApiType type){
    
    
    for (int i = 0; i < apiInfoCount; i ++) {
        if (type == f_ApiInfoArry[i].apiType &&
            f_ApiInfoArry[i].requestURLstr) {
            return [NSString stringWithUTF8String:f_ApiInfoArry[i].requestURLstr];
        }
    }
    return nil;
}

#pragma mark - 根据接口类别，确定是否加密
const extern BOOL *getSchemeValue(ApiType type){
    
    for (int i = 0; i < apiInfoCount; i ++) {
        if (type == f_ApiInfoArry[i].apiType &&
            f_ApiInfoArry[i].scheme) {
            return &f_ApiInfoArry[i].scheme;
        }
    }
    return nil;
}
