//
//  UIViewController+LO.h
//  YM
//
//  Created by locojoy on 15/9/16.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface UIViewController (LO)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;


- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;


@end
