//
//  ApiManager.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/2.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//
/**
 
    与业务相关的各个网络接口的集中管理
 */

#import <Foundation/Foundation.h>
#import "RequestID.h"

typedef NS_ENUM(NSInteger, LoginType){
    LoginType_id                    = 0, //id用户id
    LoginTypeMobile                 = 1, //手机号码
    LoginTypeCode                   = 2, //通讯录号
    LoginTypeEmail                  = 3, //绑定邮箱
};


@interface ApiManager : NSObject

+ (instancetype)defaultManager;


/** 登录 */
+ (RequestID *)LoginWithUserName:(NSString *)username
                        passwd:(NSString *)passwd
                     loginType:(LoginType)loginType;

/** 退出登录 */
+ (RequestID *)logOut;

@end
