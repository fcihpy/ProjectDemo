//
//  LoginView.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "FCBaseView.h"

@interface LoginView : FCBaseView <UITextFieldDelegate>

@property(strong,nonatomic)UITextField  *userNameField;
@property(strong,nonatomic)UITextField  *passwordField;
@property(strong,nonatomic)NSNumber     *isConnected;
@property(strong,nonatomic)UIButton     *loginButton;

@property(copy,nonatomic) void(^loginClick)(NSString* username ,NSString* password,LoginView *loginView);

@end
