//
//  BaseHandler.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpHelper.h"



/**
 *  Handler处理完成后调用的Block
 */
typedef void(^CompleteBlock)();

/**
*  Handler处理成功时调用的Block
*/
typedef void(^SuccessBlock)(id obj);


/**
*  andler处理失败时调用的Block
*/
typedef void(^FailedBlock)(id obj);


@interface BaseHandler : NSObject

/**
 *  获取请求URL
 *
 *  @param path
 *  @return 拼装好的URL
 */
+ (NSString *)requestUrlWithPath:(NSString *)path;


#pragma mark  弹出网络错误提示框
+ (void)showExceptionDialog;

#pragma mark 显示错误信息
//+ (void)showError:(NSString *)error toView:(UIView *)view;

    
@end
