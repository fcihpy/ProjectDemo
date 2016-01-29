//
//  LONavigationViewController.h
//  YM
//
//  Created by t2 on 15/3/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LONavigationViewController : UINavigationController

+(LONavigationViewController *) navigationController:(UIViewController *)rootViewController;
- (void)showFullNaviBar:(UIScrollView *)scrollView;
- (void)dismissNaviBar:(UIScrollView *)scrollView;

@end


@interface UINavigationItem (correct_offset)

- (void)dismissRightBarButtonItem;
- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;

-(void) addLeftItemString:(NSString *) leftString target:(id)target action:(SEL) action;
-(void) addRightItemString:(NSString *) rightString target:(id)target action:(SEL) action;
@end

@interface UINavigationBar (setting)
-(void) setBarWith:(UIColor *)titleColor tintColor:(UIColor *)tintColor bgColor:(UIColor *)bgColor;
@end