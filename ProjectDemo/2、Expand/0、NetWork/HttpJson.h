//
//  HttpJson.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/27.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
/*
  此类目的:减化json解析的步骤
 由于AFHTTPResponseSerializer 使用系统内置的nsjson方法解析，但NSJOSN只能解析UTF-8的数据，所以流程是把：
 返回的数据--解析成utf-8,p 这时会尝试HTTP返回的编码和自己设置的stringEnCoding去把数据转化成nsstring，
 再把nsstring用utf-8转成nsdata，再用nsjsonSeria解析成对象返回，如果可以确定服务端返回的是UTF-8，
 可以直接写个继承AFHTTPResponseSerializer的类，
 */

#import <AFNetworking/AFNetworking.h>

@interface HttpJson : AFHTTPResponseSerializer

@end
