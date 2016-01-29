//
//  UIView+LO.h
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LO)

//frame相关
-(CGFloat) top;
-(CGFloat) bottom;
-(CGFloat) left;
-(CGFloat) right;

-(CGFloat) width;
-(CGFloat) height;

-(void) setTop:(CGFloat) top;
-(void) setLeft:(CGFloat) left;
-(void) setWidth:(CGFloat) width;
-(void) setHeight:(CGFloat) height;

//DrawLinearGradient
-(void) drawLinearGradient:(UIColor *) beginColor end:(UIColor *)endColor;
//
-(void) drawLinearGradientWithContext:(CGContextRef)contentRef frame:(CGRect)frame begin:(UIColor *) beginColor end:(UIColor *)endColor;

// image
- (UIImage *)getImageFromView;


- (void) maskBound:(CGFloat) broderWidth radius:(CGFloat) radius brodercolor:(UIColor *)broderColor;
- (void) removeAllSubViews;

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;
/**
    根据borderWidth,borderColor和cornerRadius为UIVIEW添加边框.
 */
- (void)addBorderForViewWithBorderWidth:(CGFloat)bordWidth
                            bordercolor:(UIColor *)borderColor
                           cornerRadius:(CGFloat)radius;

@end

