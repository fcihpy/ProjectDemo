//
//  FCUitility.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-1.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FCUitility : NSObject

#pragma mark 是否有摄像头
+(BOOL)isSupportCamera;

+ (void)showAlertMessage:(NSString *)message Title:(NSString *)title;

//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName;


+(UIImage *)getImageFromContentsPath:(NSString *)relativepath ;

+ (NSString *)getResourceOfPath:(NSString *)filename;

+ (BOOL)IsFileExist:(NSString *)filename;

+(BOOL)playMusic:(NSString *)musicname;

+ (id)loadNib:(NSString *)nibName;

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;

//////////





///////////////////////////////////////////////////////



+ (void)addBorderLine:(UIView *)view position:(NSString *)position;
+ (void)addBorderLine:(UIView *)view position:(NSString *)position clearBorderBeofreAdd:(bool)clearBorderBeforeAdd;

+ (void)addBorderLine:(UIView *)view position:(NSString *)position size:(float)size clearBorderBeofreAdd:(bool)clearBorderBeforeAdd;

+ (void)removeBorderLine:(UIView *)view;

+ (void)addSingleEvent:(UIView *)view target:(id)target action:(SEL)action;


+ (BOOL)isConnectionAvailable;
@end

/**
 * A convenient way to show a UIAlertView with a message.
 */
void FCAlert(NSString *message);

/**
 * Same as TTAlert but the alert view has no title.
 */
void FCAlertNoTitle(NSString *message);

/**
 * @return device full model name in human readable strings
 */
NSString* FCDeviceModelName();


/**
 * @return TRUE if the device is iPad.
 */
BOOL IsPad();


/**
 * @返回YES 键盘是可视化的
 */
BOOL IsKeyboardVisible();

/**
* @返回YES，设备支持iPhone
*/
BOOL IsPhoneSupported();


/**
 * @返回当前设备方向
 */
UIDeviceOrientation WXHLDeviceOrientation();


#pragma mark - ----获取手机信息
#pragma mark  获取手机品牌

NSString* getPhoneBrand();

#pragma mark  获取手机系统
NSString* getPhoneOS();

#pragma mark  获取手机型号
NSString* getPhoneDevice();

#pragma mark 获取APP version
NSString* getAPPVersion();



//功能性确认
#pragma mark 是否支持定位


#pragma mark 是否是IPAD
#pragma mark 是否是iphone









