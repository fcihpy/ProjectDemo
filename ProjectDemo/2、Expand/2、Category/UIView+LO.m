//
//  UIView+LO.m
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UIView+LO.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (LO)

#pragma mark - frame相关
-(CGFloat) top{return CGRectGetMinY(self.frame);}
-(CGFloat) bottom {return CGRectGetMaxY(self.frame);}
-(CGFloat) left {return CGRectGetMinX(self.frame);}

-(CGFloat) right {return CGRectGetMaxX(self.frame);};

-(CGFloat) width {return CGRectGetWidth(self.frame);}
-(CGFloat) height {return CGRectGetHeight(self.frame);};

-(void) setTop:(CGFloat) top{
    CGRect r = self.frame; r.origin.y = top;
    self.frame = r;
}

-(void) setLeft:(CGFloat) left{
    CGRect r = self.frame; r.origin.x = left;
    self.frame = r;
}

-(void) setWidth:(CGFloat) width
{
    CGRect r = self.frame; r.size.width = width;
    self.frame = r;
}

-(void) setHeight:(CGFloat) height
{
    CGRect r = self.frame; r.size.height = height;
    self.frame = r;
}


#pragma mark - DrawLinearGradient
void drawLinearGradient(CGContextRef context,
                        CGRect rect,
                        CGColorRef startColor,
                        CGColorRef endColor)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0,1.0}; //颜色所在位置
    
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor,(__bridge id)endColor, nil];//渐变颜色数组
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);//构造渐变
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);//保存状态，主要是因为下面用到裁剪。用完以后恢复状态。不影响以后的绘图
    CGContextAddRect(context, rect);//设置绘图的范围
    CGContextClip(context);//裁剪
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);//绘制渐变效果图
    CGContextRestoreGState(context);//恢复状态
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

-(void) drawLinearGradient:(UIColor *) beginColor end:(UIColor *)endColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    return [self drawLinearGradientWithContext:context frame:self.bounds begin:beginColor end:endColor];
}
//
-(void) drawLinearGradientWithContext:(CGContextRef)contentRef frame:(CGRect)frame begin:(UIColor *) beginColor end:(UIColor *)endColor{
    return drawLinearGradient(contentRef,frame, beginColor.CGColor, endColor.CGColor);
}

#pragma mark - image
-(UIImage *)getImageFromView{
    UIImage *image = nil;
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (ctx) {
        [self.layer renderInContext:ctx];
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return image;
}


-(void) maskBound:(CGFloat) broderWidth radius:(CGFloat) radius brodercolor:(UIColor *)broderColor
{
    if (broderColor != 0 && broderColor) {
        self.layer.borderColor = [broderColor CGColor];
        self.layer.borderWidth = broderWidth;
    }
    
    self.layer.cornerRadius = radius;
    [self.layer setMasksToBounds:YES];
}


#pragma mark  根据borderWidth,borderColor和cornerRadius为UIVIEW添加边框.
- (void)addBorderForViewWithBorderWidth:(CGFloat)bordWidth
                            bordercolor:(UIColor *)borderColor
                           cornerRadius:(CGFloat)radius{
    if (borderColor != 0 && borderColor) {
        self.layer.borderColor = [borderColor CGColor];
        self.layer.borderWidth = bordWidth;
    }
    self.layer.cornerRadius = radius;
    [self.layer setMasksToBounds:YES];
}

-(void) removeAllSubViews
{
    NSArray *subs = [self subviews];
    for (UIView *v in subs) {
        [v removeFromSuperview];
    }
}



- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity
{
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
    
}


@end

