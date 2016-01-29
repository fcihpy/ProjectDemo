//
//  LoginHandler.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "BaseHandler.h"
@class LoginView;

@interface LoginHandler : BaseHandler


/**
 *  用户登录业务逻辑处理
 *
 *  @param username  帐号
 *  @param password  密码
 *  @param view
 *  @param success
 *  @param failed
 */
- (void)excuteLoginTaskWIthUserName:(NSString *)username
                             passwd:(NSString *)passwd
                             inView:(LoginView *)inView
                       successBlock:(SuccessBlock)successBlock
                        failedBlock:(FailedBlock)failedBlock;

@end
