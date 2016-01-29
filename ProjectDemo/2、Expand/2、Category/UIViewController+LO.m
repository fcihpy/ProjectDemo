//
//  UIViewController+LO.m
//  YM
//
//  Created by locojoy on 15/9/16.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UIViewController+LO.h"
#import <objc/runtime.h>
#import "ChatDefine.h"

static const void *HUDHintKey = &HUDHintKey;


@interface UIViewController ()
{
    MBProgressHUD   *_mbProgressHud;
}
@end

@implementation UIViewController (LO)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HUDHintKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HUDHintKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    
//    if(!_mbProgressHud){
//        _mbProgressHud = [[MBProgressHUD alloc] initWithView:view];
//        _mbProgressHud.mode = MBProgressHUDModeIndeterminate;//;
//        if(hint && hint.length > 0){
//            [_mbProgressHud setLabelText:hint];
//        }
//        [view addSubview:_mbProgressHud];
//    }
//    [_mbProgressHud show:YES];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = hint;
    [view addSubview:hud];
    [hud show:YES];
    [self setHUD:hud];
}

- (void)hideHud{
    
//    if(_mbProgressHud){
//        [_mbProgressHud hide:NO];
//        _mbProgressHud = nil;
//    }
    [[self HUD] hide:YES];
}

#pragma mark - -----hud--


- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}




@end
