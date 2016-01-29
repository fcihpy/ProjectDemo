//
//  AppDelegate.m
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/17.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "AppDelegate.h"
//#import "AppDelegate+AliPay.h"
//#import "AppDelegate+JPush.h"
//#import "AppDelegate+UMeng.h"

#import "ApiManager.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    MainController *mainVC = [[MainController alloc]init];
//    FCNavigationController *nav = [[FCNavigationController alloc]initWithRootViewController:mainVC];
//    
//    self.window.rootViewController = nav;
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor grayColor];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
   
    
    [self.window setRootViewController:nav];
//    [self loginStateChange];
    
   

    
//     ([[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"]])
    
    [self.window makeKeyAndVisible];
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)loginStateChange{
//    
//    FCNavigationController *nav = nil;
//    MainController *mainVC  = nil;
//    
//    
//    BOOL isAutoLogin = YES;
//    BOOL loginSuccess = nil;
//    
//    
//    NSString *versionKey = (NSString *)kCFBundleVersionKey;
//    
//    // 1.从Info.plist中取出版本号
//    NSString *currentversion = [NSBundle mainBundle].infoDictionary[versionKey];
//    
//    // 2.从沙盒中取出上次存储的版本号
//    NSString *savedversion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
//    
//    if ([currentversion isEqualToString:savedversion]) {   // 不是第一次使用这个版本
//        
//         if (isAutoLogin || loginSuccess) {//登陆成功或已经登录时，加载主窗口控制器
//             
//             
//             mainVC = [[MainController alloc] init];
//             
//             nav = [[FCNavigationController alloc] initWithRootViewController:mainVC];
//             
//             [nav setNavigationBarHidden:NO];
//             
//         }else{     //登陆失败加载登陆页面控制器
//             
//             mainVC = nil;
//             
//             //设置状态栏的样式
//             [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//             
//             LoginController *loginVC = [[LoginController alloc] init];
//             nav = [[FCNavigationController alloc] initWithRootViewController:loginVC];
//             
//             nav.navigationBarHidden = YES;
//   
//         }
//        
//        self.window.rootViewController = nav;
//        
//    }else{               // 版本号不一样：证明是第一次使用新版本
//
//        // 将新版本号写入沙盒
//        [mUserDefaults setObject:currentversion forKey:versionKey];
//        [mUserDefaults synchronize];
//        
//        // 显示版本新特性界面
//        // 显示状态栏
//        mApplication.statusBarHidden = YES;
//        
//        //设置状态栏的样式
//        [mApplication setStatusBarStyle:UIStatusBarStyleLightContent];
//        
//        NewFeatureController *newfeeatureVC = [[NewFeatureController alloc]init];
//        
//        self.window.rootViewController = newfeeatureVC;
//    }
//    
    
}

@end
