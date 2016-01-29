
//
//  RequestID.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "RequestID.h"

@implementation RequestID

- (void)dealloc{
//    _delegate = nil;
    if (_resultBlock) {
        _resultBlock = nil;
    }
//    DLog(@"dealloc [%@],type= %lu,tag = %@",NSStringFromClass([self class]),(unsigned long)self.requestCode,self.idTag);
}

//- (NSMutableArray *)addedCookies{
//    if (!_addedCookies) {
//        _addedCookies = [[NSMutableArray alloc]initWithCapacity:1];
//    }
//    return _addedCookies;
//}
//
//- (void)setup{
//    self.timeout = 60;
//    _requestMethod = FCRequestMethodPost;
//}
//
//- (instancetype)init{
//    if (self = [super init]) {
//        [self setup];
//    }
//    return self;
//}

//- (id)initWithDelegate:(id<HttpResponseDelegate>)delegate requestUrl:(NSString *)url postDataDict:(NSDictionary *)postDict apiType:(ApiType)apiType{
//    if (self = [super init]) {
//        [self setup];
//        self.delegate = delegate;
//        self.requestUrl = url;
//        self.postDataDic = postDict;
////        self.requestCode = apiType;
//    }
//    return self;
//}

//- (id)initWithApiType:(NSUInteger)apiType operation:(id)operation idTag:(NSUInteger)tag{
//    if (self = [super init]) {
//        _idTag = [NSNumber numberWithUnsignedInteger:tag];
//        _requestOperation = operation;
////        self.name = @"";
//    }
//    return self;
//}

//+ (instancetype)requestWithApiType:(NSUInteger)apiType
//                         operation:(id)operation
//                             idTag:(NSUInteger)tag{
//    return [[self alloc] initWithApiType:apiType operation:operation idTag:tag];
//}

//- (BOOL)isEqual:(Request *)object{
//    
//    return (self.type == object.type &&
//            [self.name isEqualToString:object.name] &&
//            [self.idTag isEqualToNumber:object.idTag]);
//}




- (void)cancelDelegate{
//    _delegate = nil;
}

- (void)cancelDelegateAndother{
//    _delegate = nil;
    _resultBlock = nil;
}

@end
