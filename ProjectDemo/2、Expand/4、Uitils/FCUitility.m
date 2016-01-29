//
//  FCUitility.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-1.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "FCUitility.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import <AVFoundation/AVFoundation.h>
#import <Reachability/Reachability.h>

@implementation FCUitility


+(BOOL)isSupportCamera{
    NSArray *CameraDevice = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in CameraDevice) {
        if (device.position == AVCaptureDevicePositionFront) {
            return YES;
        }
    }
    return NO;
}

+ (void)showAlertMessage:(NSString *)message Title:(NSString *)title{
    UIAlertView * myview = [[UIAlertView alloc] initWithTitle:title message:message  delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [myview show];
}

//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName{
    //获取docment路径
//    NSString *docments = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    

    NSString *docmentPath  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [docmentPath stringByAppendingPathComponent:fileName];
}

+ (NSString *)getResourceOfPath:(NSString *)filename{
    return  [[NSBundle mainBundle] pathForResource:filename ofType:nil];
}

+ (BOOL)IsFileExist:(NSString *)filename{
    return [[NSFileManager defaultManager] fileExistsAtPath:filename];
}

+(BOOL)playMusic:(NSString *)musicname
{
    @try {
        NSString *path = [[NSBundle mainBundle] pathForResource:musicname ofType:nil];
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        player.numberOfLoops = 0;
        [player play];
    }
    @catch (NSException * e) {
        return FALSE;
    }
    return TRUE;
}

+ (id)loadNib:(NSString *)nibName{
    NSArray *nibViews =  [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    for ( id object in nibViews) {
        if ([object isKindOfClass:NSClassFromString(nibName)]) {
            return object;
        }
    }
    
    if (nibViews) {
        return nibViews[0];
    }
    return nil;
}

+(UIImage *)getImageFromContentsPath:(NSString *)relativepath {
    return [UIImage imageWithContentsOfFile: [self getResourceOfPath:relativepath]];
}

//////////////////////////////
+ (void)addBorderLine:(UIView *)view position:(NSString *)position {
    [self addBorderLine:view position:position clearBorderBeofreAdd:YES];
}

+ (void)addBorderLine:(UIView *)view position:(NSString *)position clearBorderBeofreAdd:(bool)clearBorderBeforeAdd {
    [self addBorderLine:view position:position size:0.5 clearBorderBeofreAdd:clearBorderBeforeAdd];
}

+ (void)addBorderLine:(UIView *)view position:(NSString *)position size:(float)size clearBorderBeofreAdd:(bool)clearBorderBeforeAdd {
    if (clearBorderBeforeAdd) {
        [self removeBorderLine:view];
    }
    CALayer *bbLine = [CALayer layer];
    bbLine.name = [NSString stringWithFormat:@"%@", view.layer];
    
    bbLine.frame = CGRectMake(0, [position isEqualToString:@"top"] ? 0 : view.frame.size.height - size, view.frame.size.width, size);
    if ([position isEqualToString:@"left"]) {
        bbLine.frame = CGRectMake(0, 0, size, view.frame.size.height);
    } else if ([position isEqualToString:@"right"]) {
        bbLine.frame = CGRectMake(view.frame.size.width - size, 0, size, view.frame.size.height);
    }
    
//    bbLine.backgroundColor = kLineColor.CGColor;
    [view.layer addSublayer:bbLine];
}

+ (void)removeBorderLine:(UIView *)view {
    NSArray *subLayers = [view.layer sublayers];// 因为这个subLayers也包含了subviews的layers
    NSString *name = [NSString stringWithFormat:@"%@", view.layer];
    for(int i = subLayers.count - 1; i >= 0; i--) {
        CALayer * layer = [[view.layer sublayers] objectAtIndex:i];
        if ([layer.name isEqualToString:name]) {
            [layer removeFromSuperlayer];
        }
    }
}

+ (void)addSingleEvent:(UIView *)view target:(id)target action:(SEL)action {
    if (view != nil) {
        for(UIGestureRecognizer *recognizer in view.gestureRecognizers) {
            [view removeGestureRecognizer:recognizer];
        }
        [view setUserInteractionEnabled:YES];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        singleTap.delegate = target;
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:singleTap];
    }
}


- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay *NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), block);
}


#pragma mark - checkNetwork
+ (BOOL)isConnectionAvailable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        DLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}




@end

#pragma mark ------------------------------------C函数------------------------

///////////////////////////////////////////////////////////////////////////////////////////////////
void FCAlert(NSString *message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void FCAlertNoTitle(NSString *message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}



BOOL FCIsPad(){
    return YES;
}



#pragma mark - ----获取手机信息
#pragma mark  获取手机品牌

NSString* getPhoneBrand(){
    return [UIDevice currentDevice].systemName;
}

#pragma mark  获取手机系统
NSString* getPhoneOS(){
    return [NSString stringWithFormat:@"iOS %@",[UIDevice currentDevice].systemVersion];
}

#pragma mark  获取手机型号
NSString* getPhoneDevice(){
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone 4(GSM)";
    if ([platform isEqualToString:@"iPhone3,2"])   return @"iPhone 4(GSM Rev A)";
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone 4(CDMA)";
    
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone 5(GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])   return @"iPhone 5(GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])   return @"iPhone 5c(GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])   return @"iPhone 5c(Global)";
    
    if ([platform isEqualToString:@"iPhone6,1"])   return @"iphone 5s(GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])   return @"iphone 5s(Global)";
    
    if ([platform isEqualToString:@"iPhone7,1"])   return @"iphone 6 plus";
    if ([platform isEqualToString:@"iPhone7,2"])   return @"iphone 6";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])     return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])     return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])     return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])     return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod4,1"])     return @"iPod Touch 5G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])     return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])     return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])     return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])     return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])     return @"iPad 2(WiFi + New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])     return @"iPad mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])     return @"iPad mini (GSM";
    if ([platform isEqualToString:@"iPad2,7"])     return @"ipad mini (GSM+CDMA)";
    
    if ([platform isEqualToString:@"iPad3,1"])     return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])     return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])     return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])     return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])     return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])     return @"iPad 4 (GSM+CDMA)";
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])        return @"Simulator";
    return platform;

}



#pragma mark 获取APP version
NSString* getAPPVersion(){
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
   
    return [infoDict objectForKey:@"CFBundleVersion"];

}



/**
 * @返回YES 键盘是可视化的
 */
BOOL IsKeyboardVisible(){
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return ![window isFirstResponder];

}

/**
 * @返回YES，设备支持iPhone
 */
BOOL IsPhoneSupported(){
    return [[UIDevice currentDevice].model isEqualToString:@"iPhone"];
}






