//
//  UIView+FC.h
//  ProjectDemo
//
//  Created by locojoy on 16/1/25.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FC)


//frame相关
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;

//- (CGFloat)top;
//- (CGFloat)bottom;
//- (CGFloat)left;
//- (CGFloat)right;
//- (CGFloat)centerX;
//- (CGFloat)centerY;
//- (CGFloat)width;
//- (CGFloat)height;
//
//- (void)setTop:(CGFloat)top;
//- (void)setLeft:(CGFloat)left;
//- (void)setWidth:(CGFloat)width;
//- (void)setHeight:(CGFloat)height;

- (void)removeAllSubViews;

- (void)drawShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                    opactity:(CGFloat)opactity;
/** 设置view的边界宽度，颜色、弧度 */
- (void)addBordForViewWithBordWith:(CGFloat)bordWith
                         bordColor:(UIColor *)bordColor
                      cornerRadius:(CGFloat)radius;
/** 设置倾斜的、渐变的颜色的线 */
- (void)drawLinearGradientWithBeginColor:(UIColor *)begingColor
                                endColor:(UIColor *)endColor;
- (void)drawLinearGradientWithContext:(CGContextRef)context
                                frame:(CGRect)frame
                           BeginColor:(UIColor *)begingColor
                             endColor:(UIColor *)endColor;

@end
