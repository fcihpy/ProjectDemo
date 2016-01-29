//
//  LOEnumMacro.h
//  YM
//
//  Created by locojoy on 15/10/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#ifndef YM_LOEnumMacro_h
#define YM_LOEnumMacro_h

//typedef NS_ENUM(NSInteger, HttpLoginType){
//    user_id = 0,   //id用户id
//    user_phoneNumber,  //手机号码
//    user_code,        //卓越通讯录号
//    user_email,       //绑定邮箱
//};
//
//typedef NS_ENUM(NSInteger, VerifyType) {
//    verify_register = 1,  //1 注册验证
//    verity_binding,       //绑定验证
//    verity_password,      //找回密码
//};




typedef NS_ENUM(NSInteger, HttpRequestType) {
    HttpRequestTypePost,
    HttpRequestTypeGet,
};

#endif
