//
//  RequestID.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/26.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "Request.h"

@interface Request ()


//- (id)initWithRequestType:(NSUInteger)type object:(id)object idTag:(NSUInteger)tag;

@end

@implementation Request

- (void)dealloc{
    if (_resultBlock) {
        self.resultBlock = nil;
    }
    DLog(@"dealloc [%@],type= %lu,tag = %@",NSStringFromClass([self class]),(unsigned long)self.type,self.idTag);
}

- (id)initWithApiType:(NSUInteger)apiType operation:(id)operation idTag:(NSUInteger)tag{
    if (self = [super init]) {
        _idTag = [NSNumber numberWithUnsignedInteger:tag];
        _requestOperation = operation;
        self.name = @"";
    }
    return self;
}

+ (instancetype)requestWithApiType:(NSUInteger)apiType
                         operation:(id)operation
                             idTag:(NSUInteger)tag{
     return [[self alloc] initWithApiType:apiType operation:operation idTag:tag];
}



- (BOOL)isEqual:(Request *)object{
    
    return (self.type == object.type &&
            [self.name isEqualToString:object.name] &&
            [self.idTag isEqualToNumber:object.idTag]);
}

- (void)setResultBlock:(void (^)(BOOL, id))resultBlock{
    
    _resultBlock = resultBlock;
}

@end
