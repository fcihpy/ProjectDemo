//
//  LOHelp.h
//  YM
//
//  Created by t2 on 15/3/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#ifndef YM_LOHelp_h
#define YM_LOHelp_h

#include "LOStringHeaderHelp.h"

#import "ResourceManager.h"
#import "LOColorMacro.h"
#import "AppConfig.h"




/*打印日志*/
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//是否在app store 上发布
#define IS_TOAPPSTORE   0


#if TARGET_IPHONE_SIMULATOR
#define WEIXIN 0
#else
#define WEIXIN 1
#endif

//TableViewCell高度
#define TWO_ROW_CELL_HEIGHT 65.f
#define THREE_ROW_CELL_HEIGHT 90.f
#define kContanctCellHeight TWO_ROW_CELL_HEIGHT


//头像描边宽度
#define BORDER_WIDTH 0.5f

//字数限制
#define CONTACT_COUNT 60
#define QQ_COUNT 15
#define WEIXIN_COUNT 20
#define NAME_COUNT 10
#define MAX_CONTENT_COUNT 30
#define ADDRESS_COUNT 40
#define EMAIL_COUNT 30
#define COMADDRSS_COUNT 50
#define FEED_BACK_COUNT 500

//添加标签最大个数 与 总的标签最大个数
#define MAX_ADD_LABEL_COUNT 15
#define MAX_ALL_LABEL_COUNT 30

//群组最大个数上限
#define MAX_GROUP_COUNT 50

//工作经历 与 教育经历 最大个数
#define MAX_WORK_EXPERIENCE 10
#define MAX_EDUCATION_EXPERIENCE 5

//给联系人添加最大备注电话个数
#define MAX_ADD_CONTACT_PHONE_COUNT 4

//给自己添加最大备注电话个数
#define MAX_ADD_SELF_PHONE_COUNT 4

//限制查看别人更多资料的资料完成度百分比
#define LIMIT_PERCENT_DATA_VIEW 60

//注册名的最大和最小长度
#define MIN_NAME_LENGTH 2
#define MAX_NAME_LENGTH 15

//密码最小 与 最大 长度
#define MIN_PASSWORD_LENGTH 6
#define MAX_PASSWORD_LENGTH 14

//群发短信最多人数限制
#define MAX_GROUP_SEND_MESSAGE 40

/*网络部分的定义*/
#define TIMEOUT_Seconds  20.f   //超时时间

#define TABBARHEIGHT  49.f

#define ABOUT_US                @"http://txl.locojoy.com/about.html"
#define SERVIVE_RULE            @"http://txl.locojoy.com/agreement.html"
#define OFFICIAL_WEBSITE_URL    @"http://txl.locojoy.com"
#define DAREN_URL               @"http://txl.locojoy.com/daren/index.php?type=%ld&id=%@&myid=%@"
#define SHARE_WEIXIN_URL        @"http://txl.locojoy.com/cardinfo.php?id=%@&uid=%@"
#define APP_DOWNLOAD_URL        @"http://txl.locojoy.com/down_ipa_m.php?act=2"
#define STAR_WEB_VIEW_URL       @"http://txl.locojoy.com/star/index.php?id=%@"

#define SCAN_HEADER_OLD         @"http://ym.locojoy.com/c/"
#define SCAN_HEADER_NEW         @"http://txl.locojoy.com/yunmai/cardinfo.php"
#define SCAN_HEADER_NEW1        @"http://txl.locojoy.com/cardinfo.php"

#define PREVENT_HARASS_URL      @"http://210.14.130.164:8080/resweb/res/get?resid=%@"

//判断字符串是否为空，YES:表示为空 NO:表示不为空
#define STRISEMPTY(str) (str==nil || [str isEqualToString:@""])


#define IS_NOT_EMPTY(string) (string && ![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])

//邮箱匹配验证
#define EMAILCHECK(email) \
[[NSPredicate predicateWithFormat:@"SELF MATCHES%@", @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"] evaluateWithObject:email]

#define IS_CHINESE(string) \
[[NSPredicate predicateWithFormat:@"SELF MATCHES%@", @"^[\u4E00-\u9FA5]*$"] evaluateWithObject:string]

//测量字体单行尺寸

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define STR_FONT_SIZE(font,str) [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]]
#else
#define STR_FONT_SIZE(font,str) [str sizeWithFont:font]
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

//(IS_IOS7)?[str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]]:[str sizeWithFont:font]

#define THEMA2_COLOR ColorFromRGB(0x28, 0xb5, 0x88)

#define ScreenHegiht [UIScreen mainScreen ].bounds.size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define IS_IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define IS_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

//app信息
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define ColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define nav_TintColor         ColorFromRGB(14.f,180.f,0.f)
#define view_bg_color    ColorFromRGB(0xf6, 0xf6, 0xf6)
#define SFRIEND_FOOT_BG_COLOR ColorFromRGB(0xf1, 0xf3, 0xf2)
#define LINA2_COLOR ColorFromRGB(0xd4, 0xd4, 0xd4)

//添加CELL 的内容
#define CELL_ADDSUBVIEW(target,view)\
{\
if (IS_IOS7) {\
    [target.contentView addSubview:view];\
}else{\
    [target addSubview:view];\
}\
}




#pragma mark /*--------------------------------开发中常用到的宏定义--------------------------------------*/

//系统目录
#define mDocumentPath  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]


//----------方法简写-------
#define mApplication        [UIApplication sharedApplication]
#define mAppDelegate        (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mMainBundle         [NSBundle mainBundle]
#define mNotificationCenter [NSNotificationCenter defaultCenter]

//G－C－D
#define kGCDGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define kGCDMain(block)       dispatch_async(dispatch_get_main_queue(),block)

#define TICK NSDate *startTime = [NSDate date]
#define TOCK NSLog(@"exect TIme %f",-[startTime timeIntervalSinceNow])


#define kInfoScore_RELOAD       @"kInfoScore_RELOAD"
#define kMyCardRedImageState    @"myCardRedImageState"
#define kRemoteNotificationKey  @"RemoteNotificationKey"
#define kLocalNotifyKey         @"isLocalNotify"


#endif



//判断系统版本
#ifndef __IOS_SYSTEM_VERSION_
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif //__IOS_SYSTEM_VERSION_


//判断手机是否是iPhone5等4英寸手机
#ifndef IS_IPHONE5
#define IS_IPHONE5 ( ( [[UIScreen mainScreen] bounds].size.height-568 ) ? NO : YES )
#endif //IS_IPHONE5



#ifndef isNull
#define objectNull(a)  ( (a==nil) || ((NSNull*)a==[NSNull null]) )
#define stringIsNotNull(a)  ((a!=nil) && (![a isKindOfClass:[NSNull class]]) && (a.length != 0))
#define arryAndDicIsNotNull(a)   ((a != nil) && (![a isKindOfClass:[NSNull class]]) && (a.count !=0))

#endif //isNull

#define STRISEMPTY(str) (str==nil || [str isEqualToString:@""])



