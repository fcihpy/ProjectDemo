//
//  UIImage+LO.h
//  YM
//
//  Created by locojoy on 15/10/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

#import <UIKit/UIKit.h>

@interface UIImage (LO)

//color
+(id) imageColor:(UIColor *)color size:(CGSize)size;
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;


//blur
- (UIImage *)blurWithLevel:(CGFloat)blur;


//load
+(id) imageLoad:(NSString *)name;
+(id) imageColor:(UIColor *)color size:(CGSize)size;
+(id) imageColor:(UIColor *)scolor end:(UIColor *)endColor size:(CGSize)size;

+(UIImage*) grayscale:(UIImage*)anImage type:(char)type;
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;




//tint
- (UIImage *)imageWithTintColor:(UIColor *)tintColor Alpha:(CGFloat)alpha;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor Alpha:(CGFloat)alpha;

//!@brief 建议颜色设置为2个相近色为佳，设置3个相近色能形成拟物化的凸起感
- (UIImage*)imageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType Size:(CGSize)size;



@end
