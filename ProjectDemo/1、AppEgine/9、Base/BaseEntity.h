//
//  BaseEntity.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject

@property (nonatomic,strong) NSNumber  *status;//状态

@property (nonatomic,assign) NSInteger code;//接口错误码，0:正常，1:错误

/**
 *  解析HTTP返回异常JSON
 */
+ (BaseEntity *)parseResponeErrorJSON:(id)json;

/**
 *  解析HTTP返回异常JSON
 */
+ (BaseEntity *)parseResponeStatusJSON:(id)json;


@end
