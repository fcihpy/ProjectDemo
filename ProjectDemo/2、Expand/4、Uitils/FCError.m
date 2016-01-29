//
//  FCError.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/26.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "FCError.h"

@implementation FCError

- (instancetype)initWithText:(NSString *)text errorCode:(NSInteger)code{
    
    if (self = [super init]) {
        self.text = text;
        self.code = code;
    }
    return self;
}

@end
