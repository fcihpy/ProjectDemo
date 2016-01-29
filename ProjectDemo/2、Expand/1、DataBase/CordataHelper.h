//
//  CordataHelper.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/11.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CordataHelper : NSObject

@property(nonatomic,strong) NSManagedObjectContext          *context;
@property(nonatomic,strong) NSManagedObjectModel            *manageModel;
@property(nonatomic,strong) NSPersistentStore               *persistentStore;
@property(nonatomic,strong) NSPersistentStoreCoordinator    *persistentStoreCoordinator;


//C U R D
- (id)createEntityWithObjectName:(NSString *)objectName;

- (void)updateEntity:(id)entity;
- (void)deleteEntity:(id)entity;
- (void)deleteEntitys:(NSArray *)entityArry;

- (void)insertObjectName:(id)object;

/** 根据谓词查询 */
- (NSArray *)fetechRequestEntityName:(NSString *)entityName
                             sortKey:(NSString *)sortKey
                           predicate:(NSPredicate *)predicate
                            asceding:(BOOL)ascend;

/** 查询完进行排序 */
- (NSArray *)fetechRequestEntityName:(NSString *)entityName
                        sortKey:(NSString *)sortKey
                       asceding:(BOOL)ascend;

/** 查询所有 */
- (NSArray *)fetechRequestEntityName:(NSString *)entityName;

/** 自己设置查询条件 */
- (NSUInteger)getEntityCountWithName:(NSString *)entityName;

/** 自己设置查询条件 */
- (NSArray *)fetechRequestEntityName:(NSString *)entityName
                      predicateBlock:(void (^)(NSManagedObjectContext *context,
                                               NSFetchRequest *request))predicateBlock;
/** 获取最后多少条 */
- (NSArray *)fetechRequestEntityName:(NSString *)entityName
                           lastCount:(NSInteger)lastCount
                           predicate:(NSPredicate *)predicate
                             sortKey:(NSString *)sortKey
                            asceding:(BOOL)ascend;



@end
