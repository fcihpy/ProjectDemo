//
//  DataBaseManager.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/30.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;
@class FMResultSet;
#import "FCBaseModel.h"
#import "BaseEntity.h"

@interface DataBaseManager : NSObject
{
    BOOL                _isInitDataBaseSuccess;
    BOOL                _isDataBaseOpend;
}

@property(nonatomic,copy)NSString           *databasePath;
@property(nonatomic,strong)FMDatabaseQueue  *databaseQueue;

#pragma mark - 数据库管理
+ (DataBaseManager *)shareManager;

+ (void)releaseManager;

/**
 *  判断数据库是否打开
 */
- (BOOL)isDatabaseOpend;

/**
 *  打开数据库
 */
- (void)openDataBase;

/**
 * 关闭数据库
 */
- (void)closeDataBase;

/**
 *  使用数据库的名字进行初始化
 */
- (void)initDatabaseWithDBName:(NSString *)dbName;

/**
 *  删除数据库文件
 */
- (BOOL)deleteDataBase;

/**
 * 判断指定表是否存在
 */
- (BOOL)isTableExists:(NSString *)tableName;

#pragma mark - 数据库操作 C U R D
- (BOOL)updateEntity:(BaseEntity *)entity;
- (BOOL)deleteEntity:(BaseEntity *)entity;
- (BOOL)insertEntity:(BaseEntity *)entity;
- (BOOL)deleteEntitys:(NSArray *)entityArry;
- (BOOL)deleteEntityWithEntityID:(NSString *)entityID;

- (BaseEntity *)queryEntityWithEntityID:(NSString *)entityID;
- (NSArray *)qureryAllEntitys;

#pragma mark - 组装sql语句
/**
 *  根据resultSet来转换成NSArray类.
 */
- (NSArray *)getResultArryFromFMResultSet:(FMResultSet *)resultSet;

/**
 *   根据tableName和columns形成一个SELECT的SQL语句
 */
- (NSString *)selectFromTable:(NSString *)tableName
                      columns:(NSArray *)columns;

/**
 *  根据operation和conditions来形成一个WHERE的SQL语句.
 */
- (NSString *)whereWithOperation:(NSString *)operation
                      conditions:(NSArray *)conditions;


/**
 *  根据tableName,keys和values来形成一个INSERT的SQL语句.
 */
- (NSString *)insertToTableName:(NSString *)tableName
                           keys:(NSArray *)keys
                         values:(NSArray *)values;

/**
 *   根据tableName和newValues来形成一个UPDATE的SQL语句.
 */
- (NSString *)updateToTableName:(NSString *)tableName
                      newValues:(NSArray *)newValues;

/**
 *  根据tableName来形成一个DELETE的SQL语句.
 */
- (NSString *)deleteFromTableName:(NSString *)tableName;

/**
 *  根据conditions来形成ORDER BY的SQL语句.
 */
- (NSString *)orderByWithConditions:(NSArray *)conditions;

#pragma mark - 执行SQL语句
/**
 *  执行sqlString的SQL语句.接受INSERT,UPDATE,DELETE SQL语句.
 */
- (BOOL)excuteUpdateWithSqlString:(NSString *)sqlString;

/**
 *  执行sqlString的SQL语句.接受SELECT SQL语句
 */
- (FMResultSet *)executeQueryWithSqlString:(NSString *)sqlString;

/**
 *  根据sqlString和dictionary来执行UPDATE的SQL语句.
 */
- (BOOL)excuteUpdateWithSqlString:(NSString *)sqlString
                       dictionary:(NSDictionary *)dict;

/**
 *  根据sqlString和dictionary来执行SELECT的SQL语句.
 */
- (FMResultSet *)executeQueryWithSqlString:(NSString *)sqlString
                                dictionary:(NSDictionary *)dict;


/**
 *  根据sqlString和array来执行UPDATE的SQL语句
 */
- (BOOL)excuteUpdateWithSqlString:(NSString *)sqlString
                             arry:(NSArray *)arry;

#pragma mark 

/**
 *  获取tableName表中的所有的对象
 */
- (NSArray *)getAllObjectFromTable:(NSString *)tableName;


/**
 *  将一个Model插入model对应的表中.
 */
- (void)insertTableWithModel:(FCBaseModel *)model;


/**
 *  基于WHERE语句，用一个model去更新model对应的表中对应的数据
 */
- (void)updateTableWithModel:(FCBaseModel *)model
                   operation:(NSString *)operation
                  conditions:(NSArray *)conditions;

/**
 *  根据model,keys和values快速更新model对应的表中的一条数据 SQL语句格式为UPDATE %@ SET %@ WHERE %@ = %@.
 */
- (void)updateTableWithModel:(FCBaseModel *)model
                         key:(NSString *)key
                       value:(NSString *)value;

/**
 *  根据Columns,key和value快速从tableName表中查询的数据，SQL语句格式为SELECT %@ FROM %@ WHERE %@ = %@.
 */
- (NSArray *)selectFromTable:(NSString *)tableName
                     columns:(NSArray *)columns
                         key:(NSString *)key
                       value:(NSString *)value;


@end
