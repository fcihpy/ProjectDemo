//
//  DAO.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/30.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "DAO.h"
#import "DataBaseManager.h"
#import <FMDB/FMDatabaseAdditions.h>
#import <FMDB/FMDatabaseQueue.h>

@implementation DAO

- (instancetype)init{
    if (self = [super init]) {
        self.dataBaseQueue = [DataBaseManager shareManager].databaseQueue;
    }
    return self;
}

- (FMDatabaseQueue *)dataBaseQueue{
    if (![[DataBaseManager shareManager] isDatabaseOpend]) {
        [[DataBaseManager shareManager] openDataBase];
        self.dataBaseQueue = [DataBaseManager shareManager].databaseQueue;
        if (_dataBaseQueue) {
            [DAO createTableNeeded];
        }
    }
    return  _dataBaseQueue;
}

+ (void)createTableNeeded{
    
    @autoreleasepool {
        FMDatabaseQueue *databaseQueue = [DataBaseManager shareManager].databaseQueue;
        
        [databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            
            NSString *sqlStr1 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_info_system (system_id INTEGER PRIMARY KEY NOT NULL,app_version TEXT NOT NULL"];
            [db executeUpdate:sqlStr1];
        }];
    }
}


@end
