//
//  UIDevice+LO.m
//  YM
//
//  Created by t2 on 15/8/25.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UIDevice+LO.h"

#import <sys/sysctl.h>
@implementation UIDevice (LO)


- (NSString *)platformString{
    
  
    size_t size;
    sysctlbyname("hw.machine",NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    
    NSString *PhoneDeviceStr = [NSString string];
    PhoneDeviceStr = [UIDevice currentDevice].model;
    
    free(machine);
    return platform;

}


#pragma mark  获取手机型号
- (NSString *)fcDeviceType{
    
    NSString *platform = [self platformString];
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"])   return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone4";
    
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"])   return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"])   return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"])   return @"iPhone5c";
    
    if ([platform isEqualToString:@"iPhone6,1"])   return @"iphone5s";
    if ([platform isEqualToString:@"iPhone6,2"])   return @"iphone5s";
    
    if ([platform isEqualToString:@"iPhone7,1"])   return @"iphone6plus";
    if ([platform isEqualToString:@"iPhone7,2"])   return @"iphone6";
    
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

- (FCDeviceType)deviceType{
    
    NSString *platform = [self platformString];
    
    FCDeviceType deviceType;
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,2"])   return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPhone2,1"])   return DeviceIsiPhone3GS;
    
    if ([platform isEqualToString:@"iPhone3,1"])   return DeviceIsiPhone4;
    if ([platform isEqualToString:@"iPhone3,2"])   return DeviceIsiPhone4;
    if ([platform isEqualToString:@"iPhone3,3"])   return DeviceIsiPhone4;
    
    if ([platform isEqualToString:@"iPhone4,1"])   return DeviceIsiPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"])   return DeviceIsiPhone5;
    if ([platform isEqualToString:@"iPhone5,2"])   return DeviceIsiPhone5;
    if ([platform isEqualToString:@"iPhone5,3"])   return DeviceIsiPhone5C;
    if ([platform isEqualToString:@"iPhone5,4"])   return DeviceIsiPhone5C;
    
    if ([platform isEqualToString:@"iPhone6,1"])   return DeviceIsiPhone5S;
    if ([platform isEqualToString:@"iPhone6,2"])   return DeviceIsiPhone5S;
    
    if ([platform isEqualToString:@"iPhone7,1"])   return DeviceIsiPhone6;
    if ([platform isEqualToString:@"iPhone7,2"])   return DeviceIsiPhone6Plus;
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])     return DeviceIsiPodTouch;
    if ([platform isEqualToString:@"iPod2,1"])     return DeviceIsiPodTouch2G;
    if ([platform isEqualToString:@"iPod3,1"])     return DeviceIsiPodTouch3G;
    if ([platform isEqualToString:@"iPod4,1"])     return DeviceIsiPodTouch4G;
    
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])     return DeviceIsiPad;
    if ([platform isEqualToString:@"iPad2,1"])     return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,2"])     return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,3"])     return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,4"])     return DeviceIsiPad2;
    if ([platform isEqualToString:@"iPad2,5"])     return DeviceIsiPadMini;
    if ([platform isEqualToString:@"iPad2,6"])     return DeviceIsiPadMini;
    if ([platform isEqualToString:@"iPad2,7"])     return DeviceIsiPadMini;
    
    if ([platform isEqualToString:@"iPad3,1"])     return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPad3,2"])     return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPad3,3"])     return DeviceIsiPad3G;
    if ([platform isEqualToString:@"iPad3,4"])     return DeviceIsiPad4G;
    if ([platform isEqualToString:@"iPad3,5"])     return DeviceIsiPad4G;
    if ([platform isEqualToString:@"iPad3,6"])     return DeviceIsiPad4G;
    
    
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])        return DeviceIsSimulator;
    return deviceType;
    
}


- (BOOL)is64bit

{
    
    BOOL is64bitHost = NO;
    int is64bit;
    size_t len = sizeof(is64bit);
    
    if (!sysctlbyname("hw.optional.x86_64",&is64bit,&len,NULL,0)){
        is64bitHost = (BOOL)is64bit;
    }
    return is64bitHost;
    

    
}


@end
