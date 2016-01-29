//
//  BaseHandler.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "BaseHandler.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define SERVER_HOST @""
@implementation BaseHandler


+ (NSString *)requestUrlWithPath:(NSString *)path
{
    return [@"http://" stringByAppendingString:[SERVER_HOST stringByAppendingString:path]];
}


#pragma mark  弹出网络错误提示框
+ (void)showExceptionDialog
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:@"网络异常，请检查网络连接"
                               delegate:self
                      cancelButtonTitle:@"好的"
                      otherButtonTitles:nil, nil] show];
}
#pragma mark 显示错误信息
//- (void)showHUD:(NSString*)title inView:(LoginView*)view{
//    
//    // UIWindow *window =  [UIApplication sharedApplication].keyWindow;
//    
//    _hud = [[MBProgressHUD alloc] initWithView:view];
//    _hud.color = [[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0.7];
//    _hud.labelText = title;
//    [view addSubview:_hud];
//    _hud.delegate = self;
//    _hud.margin = 10;
//    [_hud show:YES];
//    
//}
//- (void)hudWasHidden{
//    if (_hud != nil) {
//        [_hud removeFromSuperview];
//        _hud = nil;
//    }
//}

@end
