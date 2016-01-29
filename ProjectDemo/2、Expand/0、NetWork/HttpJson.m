//
//  HttpJson.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/27.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "HttpJson.h"

@implementation HttpJson

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error{
    return data;
}

@end
