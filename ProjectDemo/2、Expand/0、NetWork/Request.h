//
//  RequestID.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/26.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//
/**
    客户端请求的标识
 */

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^ResultBolck)(BOOL isSuccess,id object);

@interface Request : NSObject

@property(nonatomic,weak,readonly)AFHTTPRequestOperation    *requestOperation; //请求的消息体
@property(nonatomic,assign,readonly)NSUInteger              type;
@property(nonatomic,copy)NSString                           *name;   //请求的url
@property(nonatomic,strong,readonly)NSNumber                *idTag;
@property(nonatomic,strong)id                               userInfo;   //请求的消息体
@property(nonatomic,copy)ResultBolck                        resultBlock;

- (void)setResultBlock:(void (^)(BOOL isSuccess,id object))resultBlock;

+ (instancetype)requestWithApiType:(NSUInteger)apiType operation:(id)operation idTag:(NSUInteger)tag;

@end
