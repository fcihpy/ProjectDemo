//
//  FCError.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/26.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAKE_ERROR(text,code) [[FCError alloc] initWithText:text errorCode:code]

@interface FCError : NSObject

@property(nonatomic,strong)NSString     *text;
@property(nonatomic,assign)NSInteger    code;

- (instancetype)initWithText:(NSString *)text errorCode:(NSInteger)code;

@end
