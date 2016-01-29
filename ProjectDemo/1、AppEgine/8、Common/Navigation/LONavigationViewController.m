//
//  LONavigationViewController.m
//  YM
//
//  Created by t2 on 15/3/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "LONavigationViewController.h"
#include "LOHelp.h"
#import "UIImage+Resize.h"

@interface LONavigationViewController ()

@property (nonatomic, strong) UIView *overLayer;
@property (nonatomic, assign) BOOL isHidden;

@end

@implementation LONavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController * v = [super popViewControllerAnimated:animated];
    if (v && [v respondsToSelector:@selector(backAction:)]) {
        [v performSelector:@selector(backAction:) withObject:nil];
    }
    return v;
}

+ (LONavigationViewController *)navigationController:(UIViewController *)rootViewController{
    
    LONavigationViewController *nav =[[LONavigationViewController alloc] initWithRootViewController:rootViewController];
    CGSize size  = nav.navigationBar.frame.size;
    if (IS_IOS7) {
        size.height += ([[UIApplication sharedApplication] statusBarFrame].size.height);
    }
//    UIImage *bgImage = [UIImage imageColor:THEMA2_COLOR size:size];
    nav.navigationBar.barStyle = UIBarStyleDefault;
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObject:C1_COLOR forKey:UITextAttributeTextColor];
    [dict setObject:C1_COLOR forKey:UITextAttributeTextShadowColor];
    nav.navigationBar.translucent = NO;

    [nav.navigationBar setBarTintColor:B3_COLOR];
    nav.navigationBar.tintColor = C1_COLOR;
    nav.navigationBar.titleTextAttributes = dict;
    return nav;
}


#pragma mark - hidden or show navi bar

- (void)createStatusBarView
{
    if (!_overLayer) {
        self.overLayer = [[UIView alloc] initWithFrame:self.navigationBar.bounds];
        self.overLayer.alpha = 0;
        self.overLayer.backgroundColor = THEMA2_COLOR;
        [self.navigationBar addSubview:self.overLayer];
        [self.navigationBar bringSubviewToFront:self.overLayer];
    }
}

- (void)showFullNaviBar:(UIScrollView *)scrollView
{
#if 0
    if (_isHidden) {
        [UIView animateWithDuration:0.01 animations:^{
            CGRect frame = self.navigationBar.frame;
            frame.origin.y = 20;
            self.navigationBar.frame = frame;
            
            frame = self.overLayer.frame;
            frame.origin.y -= 20;
            self.overLayer.frame = frame;
            
            frame = scrollView.frame;
            frame.origin.y = 0;
            frame.size.height -= 44;
            scrollView.frame = frame;
        } completion:^(BOOL finished) {
            self.overLayer.alpha = 0;
            [self.overLayer removeFromSuperview];
            self.overLayer = nil;
        }];

        self.isHidden = NO;
    }
#endif
}

- (void)dismissNaviBar:(UIScrollView *)scrollView
{
#if 0
    if (!_isHidden) {
        [self createStatusBarView];

        [UIView animateWithDuration:0.01 animations:^{
            CGRect frame = self.navigationBar.frame;
            frame.origin.y = -24;
            self.navigationBar.frame = frame;
            
            frame = scrollView.frame;
            frame.origin.y -= 44;
            frame.size.height += 44;
            scrollView.frame = frame;
        } completion:^(BOOL finished) {
            self.overLayer.alpha = 1;
            
            CGRect frame = self.navigationBar.frame;
            frame.origin.y -= 20;
            self.navigationBar.frame = frame;
            
            frame = self.overLayer.frame;
            frame.origin.y += 20;
            self.overLayer.frame = frame;
        }];
        
        self.isHidden = YES;
    }
#endif
}

@end

#define ios7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?YES:NO)



@implementation UINavigationItem (correct_offset)

- (void)dismissRightBarButtonItem
{
    if (ios7) {
        [self setRightBarButtonItems:nil];
    }else{
        [self setRightBarButtonItem:nil];
    }
}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    if (ios7) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem,nil]];
    } else {
        [self setLeftBarButtonItem:leftBarButtonItem];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if (ios7) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem,nil]];
    } else {
        [self setRightBarButtonItem:rightBarButtonItem];
    }
}

-(void) addLeftItemString:(NSString *) leftString target:(id)target action:(SEL) action
{
    UIBarButtonItem* (^BarbuttonBlock)(NSString *,id,SEL) = ^(NSString *text,id tars,SEL action){
        UIFont *font = [UIFont systemFontOfSize:16.f];
        CGSize size = STR_FONT_SIZE(font,text);
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width+6.f, 44)];
        [button setTitle:text forState:UIControlStateNormal];
        button.titleLabel.font = font;
        [button setTitleColor:C1_COLOR forState:UIControlStateNormal];
        [button addTarget:tars action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        return item;;
    };
    
    UIBarButtonItem *barButtonItem = BarbuttonBlock(leftString,target,action);//[[UIBarButtonItem alloc] initWithTitle:leftString style:UIBarButtonItemStyleDone target:target action:action];
    [self addLeftBarButtonItem:barButtonItem];
    
    //self.leftBarButtonItem = barButtonItem;

}

-(void) addRightItemString:(NSString *) rightString target:(id)target action:(SEL) action
{
    UIBarButtonItem* (^BarbuttonBlock)(NSString *,id,SEL) = ^(NSString *text,id tars,SEL actionp){
        UIFont *font = [UIFont systemFontOfSize:16.f];
        CGSize size = STR_FONT_SIZE(font,text);
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width+6.f, 40)];
        [button setTitle:text forState:UIControlStateNormal];
        button.titleLabel.font = font;
        [button setTitleColor:C1_COLOR forState:UIControlStateNormal];
        [button addTarget:tars action:actionp forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        return item;;
    };
    
    UIBarButtonItem *barButtonItem =BarbuttonBlock(rightString,target,action);
    [self addRightBarButtonItem:barButtonItem];
    //[[UIBarButtonItem alloc] initWithTitle:rightString style:UIBarButtonItemStyleDone target:target action:action];
    //self.rightBarButtonItem = barButtonItem;
}

@end


@implementation UINavigationBar(setting)


-(void) setBarWith:(UIColor *)titleColor tintColor:(UIColor *)tintColor bgColor:(UIColor *)bgColor
{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObject:titleColor forKey:UITextAttributeTextShadowColor];
    [dict setObject:titleColor forKey:UITextAttributeTextColor];
    self.tintColor = tintColor;
    self.barTintColor = bgColor;
    [self setTitleTextAttributes:dict];
}

@end
