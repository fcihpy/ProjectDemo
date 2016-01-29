//
//  CordataHelper.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/11.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "CordataHelper.h"

#define  kDataBasePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"demon.sqlit" ]

@implementation CordataHelper


- (id)createEntityWithObjectName:(NSString *)objectName{

    return [NSEntityDescription insertNewObjectForEntityForName:objectName inManagedObjectContext:self.context];
}

- (void)initCoreData{
    
    self.manageModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *storeCoordinator = [self persistentStoreCoordinator];
    self.context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [self.context setPersistentStoreCoordinator:storeCoordinator];
}

-(void)aaa{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:kDataBasePath]) {
        [fileManager createDirectoryAtPath:kDataBasePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


- (NSArray *)noFetechRuequstEntity:(NSString *)entity{
    
    NSArray *arry = nil;
    
    return  arry;
}

- (NSArray *)fetechRequestEntityName:(NSString *)entityName{
    NSArray *arry = nil;
    
    return  arry;
    
}

- (NSArray *)fetechRequestEntityName:(NSString *)entityName sortKey:(NSString *)sortKey asceding:(BOOL)ascend{
    NSArray *arry = nil;
    
    return  arry;
    
}

- (NSArray *)fetechRequestEntityName:(NSString *)entityName sortKey:(NSString *)sortKey predicate:(NSPredicate *)predicate asceding:(BOOL)ascend{
    
    NSArray *resultArry = [NSArray array];
    
    NSAssert(predicate, @"谓词对象不能为空!");
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entityName
                                              inManagedObjectContext:self.context];
    [request setEntity:entityDescription];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:sortKey ascending:ascend];
    
    NSArray *sorArry = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sorArry];
    
    NSError *error = nil;
    NSArray *fetchResult = [self.context executeFetchRequest:request error:&error];
    
    if (fetchResult) {
        
        resultArry = fetchResult;
    }else{
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    
    return  resultArry;
}

- (NSManagedObjectContext *)context{
    if (!_context) {
        _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        
        NSSet *insertObject = [_context insertedObjects];
        if ([insertObject count]) {
            NSError *error = nil;
            BOOL success = [_context obtainPermanentIDsForObjects:[insertObject allObjects] error:&error];
        }
    }
    return _context;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    
    if (!_persistentStoreCoordinator) {
        
        NSURL *storeURL = [NSURL URLWithString:kDataBasePath];
        NSError *error = nil;
        NSDictionary *optionDict = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.manageModel];
        
        self.persistentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                         configuration:nil URL:storeURL options:optionDict error:&error];
        
    }
    return _persistentStoreCoordinator;
}


- (NSUInteger)getEntityCountWithName:(NSString *)entityName{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    [request setEntity:entityDescription];
    
    NSError *error = nil;
    
    NSUInteger count = [self.context countForFetchRequest:request error:&error];
    return  count;
}


- (NSArray *)fetechRequestEntityName:(NSString *)entityName
                           lastCount:(NSInteger)lastCount
                           predicate:(NSPredicate *)predicate
                             sortKey:(NSString *)sortKey
                            asceding:(BOOL)ascend{
    NSAssert(predicate, @"谓词对象不能为空!");
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName
                                                         inManagedObjectContext:self.context];
    
    [request setEntity:entityName];
    NSError *error = nil;
    
    NSUInteger count = [self.context countForFetchRequest:request error:&error];
    NSInteger requestCount = MIN(lastCount, count);
    NSInteger startRequestCount = (count >= lastCount)?count-lastCount:0;
    
    return nil;
}



@end

