//
//  ResourceManager.m
//  T2
//
//  Created by lirongfeng on 14/12/24.
//  Copyright (c) 2014年 locojoy. All rights reserved.
//

#import "ResourceManager.h"
#import <UIKit/UIAlert.h>

#import "NSArray+LO.h"

@interface ResourceManager()

@property(nonatomic,strong) NSMutableDictionary *strData;
-(CGFloat) currentScale;

@end

@implementation ResourceManager

static ResourceManager *__instance = nil;

+(ResourceManager*) shareManager
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc]init];
    });
    return __instance;
    
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [super allocWithZone:zone];
    });
    return __instance;
}


-(ResourceManager*)init
{
    self = [super init];
    if(self){
        [self initStr];
    }
    return self;
}


-(void) initStr{
    
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0];
    NSString* plistPath =  [NSString  stringWithFormat:@"%@%@.plist",docDir,STR_FILE];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]  != YES){
        plistPath =
        [[NSBundle mainBundle]pathForResource:STR_FILE ofType:@"plist"];
    }
    
    self.strData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

-(NSString*) strNamed:(NSString*) key
{
    NSString *temp = [_strData objectForKey:key];
    if (!temp)
    {
        temp = [_strData objectForKey:[key uppercaseString]];
    }
    return temp;
}

-(id) IdNamed:(NSString*) key
{
    return [_strData objectForKey:key] ;
}

-(NSString *) resourStrforModel:(NSInteger)model andKey:(NSString *)key
{
    NSArray *models = @[@"MODEL_CHAT",@"MODEL_CONTACT",@"MODEL_DISCOVER",@"MODEL_ME",@"MODEL_OTHER",@"MODEL_LOGIN"];
    NSDictionary *dic = _strData[models[model]];
    return dic[key];
}


/*
-(UIImage*) imageNamed:(NSString*) name
{
    NSArray * array = [name componentsSeparatedByString:@"."];
    if ([array count] < 2) {
        return nil;
    }
    
    NSArray *paths =
                NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString* fullPath =  [NSString  stringWithFormat:@"%@%@",docDir,name];
    
    UIImage* img = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath] ){
        img =   [UIImage imageWithContentsOfFile:fullPath];
    }
    else{
        NSInteger count = [array count];
        NSString* str =  [array objectAtIndex:(count-2)];
        int scale = [[ResourceManager shareManager] currentScale];
        str = [NSString stringWithFormat:@"%@@%dx",str,scale];
        NSString *imagePath =
            [[NSBundle mainBundle]pathForResource:str
                            ofType:[array objectAtIndex:(count-1)] ];
        img =   [UIImage imageWithContentsOfFile:imagePath];
        if (img == nil) {
            scale = 2;
            str = [NSString stringWithFormat:@"%@@%dx",str,scale];
            NSString *imagePath =
            [[NSBundle mainBundle]pathForResource:str
                                           ofType:[array objectAtIndex:(count-1)] ];
            img =   [UIImage imageWithContentsOfFile:imagePath];
        }
    }
    
    
    
    return img;
}
 */
- (CGFloat) currentScale {
    if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
        return [UIScreen mainScreen].scale ;
    }
    return 1;
}
+(NSMutableDictionary*) readPlist:(NSString*)fileName
{
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString* fullPath =  [NSString  stringWithFormat:@"%@%@.plist",docDir,fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]  != YES){
        fullPath =
        [[NSBundle mainBundle]pathForResource:fileName ofType:@"plist"];
    }
    
    NSMutableDictionary* data = [[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
    return data;
}


//+(NSArray *) readPlistForcountry:(void (^)(NSArray *array)) rblock
//{
//#if 1
////    NSMutableArray *result = [[NSMutableArray alloc] init];
////    NSMutableArray *result2 = [[NSMutableArray alloc] init];
////    NSDictionary* dict = [ResourceManager readPlist:@"country_code2"];
////
////    NSArray *arr = dict[@"roots"];
////    for (NSDictionary *rdic in arr) {
////        
////        NSArray *subsDic = rdic[@"subs"];
////        NSMutableArray *subsArr = [NSMutableArray array];
////        for (NSDictionary *itemDic in subsDic) {
////            CountryItem *item = [[CountryItem alloc] init];
////            item.engName = itemDic[@"en"];
////            item.chinName = itemDic[@"zh"];
////            item.code = itemDic[@"code"];
////            [subsArr addObject:item];
////        }
////        LOSourceItem *sitem = [[LOSourceItem alloc] init];
////        sitem.firstString = rdic[@"fc"];
////        sitem.subSources = subsArr;
////        [result addObject:sitem];
////        [result2 addObjectsFromArray:subsArr];
////    }
////    if (rblock) {
////        rblock(result2);
////    }
////    return result;
//    
//#endif
//#if 0
//    NSMutableArray *result = [[NSMutableArray alloc] init];
//    NSMutableArray *result2 = [[NSMutableArray alloc] init];
//    NSDictionary* dict = [ResourceManager readPlist:@"country_code"];
//    NSMutableArray *firstChars = [[NSMutableArray alloc] init];
//    NSArray *arr = dict[@"country"];
//    for (NSString *str in arr) {
//        CountryItem *item = [[CountryItem alloc] initWithString:str];
//        [result addObject:item];
//        if (![firstChars containsObject:item.firstChar]) {
//            [firstChars addObject:item.firstChar];
//        }
//    }
//
//    for (NSString * str in firstChars) {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstChar==%@",str];
//        NSArray *subArr = [result filteredArrayUsingPredicate:predicate];
//        if(subArr && subArr.count > 0){
//            NSArray *subs = [subArr sortedArrayUsingKeys:@[@"pinYin"] ascending:YES];
//            if (subs && subs.count > 0) {
//                LOSourceItem *sitem = [[LOSourceItem alloc] init];
//                sitem.firstString = str;
//                sitem.subSources = [[NSMutableArray alloc] initWithArray:subs];
//                [result2 addObject:sitem];
//            }
//        }
//    }
//    if (rblock) {
//        rblock([result sortedArrayUsingKeys:@[@"pinYin"] ascending:YES]);
//    }
//    return [result2 sortedArrayUsingKeys:@[@"firstString"] ascending:YES];
//#endif
//}


-(NSString*) errorIded:(NSString*)Id
{
    NSMutableDictionary* dict = [ResourceManager readPlist:ERROR_FILE];
    if ([dict objectForKey:Id] == nil) {
        
        UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"error:" message:@"invalid error code" delegate:nil cancelButtonTitle:@"OK"  otherButtonTitles:nil];
        
        [promptAlert show];
        return nil;
    }
    else{
        return [dict objectForKey:Id];
    }
}

@end
