//
//  DataBaseManager.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/30.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "DataBaseManager.h"
#import <FMDB/FMDatabase.h>
#import <FMDB/FMDatabaseQueue.h>
#import <sqlite3.h>

#define kDataBasePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"LocoJoy.sqlite"]

@implementation DataBaseManager

static DataBaseManager *_instance;

+ (DataBaseManager *)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//- (instancetype)init{
//    if (self = [super init]) {
//        _isDataBaseOpend = NO;
//     
//      
//        [self setDataBasePath:kDataBasePath];
//        [self openDataBase];
//    }
//    return self;
//}
//
//
//- (BOOL)isDatabaseOpend{
//    return _isDataBaseOpend;
//}
//
//
//- (void)openDataBase{
//    self.dataaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.dataBasePath];
//    if (_dataaseQueue == 0x00) {
//        _isDataBaseOpend = NO;
//        return;
//    }
//    _isDataBaseOpend = YES;
//    DLog(@"Open Database OK!");
//    
//    [_dataaseQueue inDatabase:^(FMDatabase *db) {
//        [db setShouldCacheStatements:YES];
//    }];
//    
//}
//
//
//- (void)closeDataBase{
//    if (!_isDataBaseOpend) {
//        DLog(@"数据库已打开，或打开失败。请求关闭数据库失败。");
//        return;
//    }
//    [self.dataaseQueue close];
//    _isDataBaseOpend = NO;
//    DLog(@"关闭数据库成功。");
//    
//}

+ (void)releaseManager{
   
    if (_instance) {
        _instance = nil;
    }
}

- (void)dealloc{
    
    [self closeDataBase];

}

@end
