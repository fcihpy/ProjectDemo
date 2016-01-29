//
//  DAO.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/30.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;

@interface DAO : NSObject

@property(nonatomic,strong) FMDatabaseQueue     *dataBaseQueue;

+ (void)createTableNeeded;

@end
