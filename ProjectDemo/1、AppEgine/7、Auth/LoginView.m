//
//  LoginView.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "LoginView.h"
#import "Constants.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)createView{
    
    UILabel *userLable = [[UILabel alloc] init];
    userLable.text = @"账号：";
//    userLable.textColor = [AppUtils colorWithHexString:@"121212"];
    userLable.font = FONT(FONT_SIZE);
    [userLable sizeToFit];
    [self addSubview:userLable];
    
    [userLable setTranslatesAutoresizingMaskIntoConstraints:NO];
    [userLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.mas_top).offset(110);
        make.left.equalTo(self.mas_left).offset(25);
    }];
    
    UIImageView *lineImageView = [[UIImageView alloc] init];
//    lineImageView.backgroundColor = [AppUtils colorWithHexString:@"121212"];
    [self addSubview:lineImageView];
    
    [lineImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(userLable.mas_bottom).offset(7.5);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@0.5);
    }];
    
    self.userNameField = [[UITextField alloc] init];
    self.userNameField.delegate = self;
    self.userNameField.text = @"";
    self.userNameField.placeholder = @"请输入手机号";
    self.userNameField.backgroundColor = [UIColor clearColor];
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameField.font = FONT(FONT_SIZE);
    self.userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.userNameField.textColor = [UIColor whiteColor];
    [self.userNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.userNameField];
    
    [self.userNameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(userLable.mas_left).offset(50);
        make.bottom.equalTo(lineImageView.mas_top).offset(-2);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@30);
    }];
    
    UILabel *passwordLable = [[UILabel alloc] init];
    passwordLable.text = @"密码：";
//    passwordLable.textColor = [AppUtils colorWithHexString:@"121212"];
    passwordLable.font = FONT(FONT_SIZE);
    [passwordLable sizeToFit];
    [self addSubview:passwordLable];
    
    [passwordLable setTranslatesAutoresizingMaskIntoConstraints:NO];
    [passwordLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(lineImageView.mas_top).offset(33);
        make.left.equalTo(self.mas_left).offset(25);
    }];
    
    lineImageView = [[UIImageView alloc] init];
//    lineImageView.backgroundColor = [AppUtils colorWithHexString:@"121212"];
    [self addSubview:lineImageView];
    
    [lineImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(passwordLable.mas_bottom).offset(7.5);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@0.5);
    }];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.delegate = self;
    self.passwordField.text = @"";
    self.passwordField.placeholder = @"请输入密码";
    self.passwordField.backgroundColor = [UIColor clearColor];
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.font = FONT(FONT_SIZE);
    self.passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordField.secureTextEntry = YES;
    [self.passwordField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.passwordField.textColor = [UIColor whiteColor];
    [self addSubview:self.passwordField];
    
    [self.passwordField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(passwordLable.mas_left).offset(50);
        make.bottom.equalTo(lineImageView.mas_top).offset(-2);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@30);
    }];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//    [self.loginButton setTitleColor:[AppUtils colorWithHexString:@"121212"] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = FONT(16);
//    [self.loginButton setBackgroundImage:IMAGE(@"normal") forState:UIControlStateNormal];
//    [self.loginButton setBackgroundImage:IMAGE(@"disable") forState:UIControlStateDisabled];
//    [self.loginButton setBackgroundImage:IMAGE(@"highlight") forState:UIControlStateHighlighted];
    [self addSubview:self.loginButton];

    [self.loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(lineImageView.mas_bottom).offset(47);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@44);
    }];
}


//点击键盘外面 键盘收回
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITapGestureRecognizer*tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done:)];
    tapGestureRecognizer.numberOfTapsRequired =1;
    [self addGestureRecognizer:tapGestureRecognizer];
    return YES;
}

- (void) textFieldDidChange:(id) sender {
    UITextField *textfield = (UITextField*)sender;
    if (self.passwordField.text.length>0 && self.userNameField.text.length>0){
        self.isConnected = [NSNumber numberWithBool:YES];
    }
    if (textfield == self.userNameField) {
        self.passwordField.text = @"";
        self.isConnected = [NSNumber numberWithBool:NO];
    }
   
}

-(void)done:(id)sender
{
    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.frame.size.height - 216.0);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if(offset > 0)
        self.frame = CGRectMake(0.0f, -offset, self.frame.size.width, self.frame.size.height);
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}



@end
