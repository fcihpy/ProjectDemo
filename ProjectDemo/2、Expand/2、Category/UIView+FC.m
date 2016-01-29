//
//  UIView+FC.m
//  ProjectDemo
//
//  Created by locojoy on 16/1/25.
//  Copyright © 2016年 fcihpy. All rights reserved.
//

#import "UIView+FC.h"


#pragma mark - DrawLinearGradient
void drawLinearGradient(CGContextRef context,CGRect rect,CGColorRef startColor,CGColorRef endColor){
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //颜色所在位置
    CGFloat locations[] = {0.0,1.0};
    //渐变颜色数组
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id _Nonnull)(startColor),(__bridge id _Nonnull)endColor, nil];
    //构造渐变
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    //保存状态，主要是因为下面用到裁剪。用完以后恢复状态。不影响以后的绘图
    CGContextSaveGState(context);
   
    //设置绘图的范围
    CGContextAddRect(context, rect);
    //裁剪
    CGContextClip(context);
    //绘制渐变效果图
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    //恢复状态
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


@implementation UIView (FC)

- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)top{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = top;
    self.frame = tempFrame;
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)left{
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)left{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = left;
    self.frame = tempFrame;
}

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)centerX{
    return CGRectGetMidX(self.frame);
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY{
     return CGRectGetMidY(self.frame);
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
    
}

- (void)setWidth:(CGFloat)width{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}

- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}








- (void)removeAllSubViews{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)drawLinearGradientWithContext:(CGContextRef)context
                                frame:(CGRect)frame
                           BeginColor:(UIColor *)begingColor
                             endColor:(UIColor *)endColor{
    
    return drawLinearGradient(context,
                              frame,
                              begingColor.CGColor,
                              endColor.CGColor);
}

- (void)drawLinearGradientWithBeginColor:(UIColor *)begingColor
                                endColor:(UIColor *)endColor{
    CGContextRef context = UIGraphicsGetCurrentContext();
    return [self drawLinearGradientWithContext:context
                                         frame:self.bounds
                                    BeginColor:begingColor
                                      endColor:endColor];
}


- (void)addBordForViewWithBordWith:(CGFloat)bordWith
                         bordColor:(UIColor *)bordColor
                      cornerRadius:(CGFloat)radius{
    if (bordColor != 0 && bordColor) {
        self.layer.borderColor = bordColor.CGColor;
        self.layer.borderWidth = bordWith;
    }
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)drawShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opactity:(CGFloat)opactity{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opactity;
    self.clipsToBounds = NO;
}

@end
