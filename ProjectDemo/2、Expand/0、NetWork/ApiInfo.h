//
//  ApiInfo.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/3.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConst.h"


typedef struct  _ApiInfo{
    char            *modelClassName;     //解析后的model类名，如果为空，则保持原来的字典数据格式
    char            *requestURLstr; //API请求的URL
    ApiType         apiType;        //API接口的类别
    BOOL            scheme;         //是否加密
}ApiInfo;



/**
 *  根据接口类别，获得要解析的model名
 *
 */
const extern Class getModelClassName(ApiType type);

/**
 *  根据接口类别，获得要请求的URL
 *
 */
const extern NSString *getRequestURL(ApiType type);

/**
 *  根据接口类别，获得要请求的加密状态
 *
 */
const extern BOOL *getSchemeValue(ApiType type);