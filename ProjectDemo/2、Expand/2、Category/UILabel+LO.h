//
//  UILabel+LO.h
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LO)

#pragma mark - -----------设置label内容中其中一部份文字的颜色----
-(void) setSubText:(NSString *)text subs:(NSArray *)subText withColor:(UIColor *)color;

-(void) setSubText:(NSString *)text subs:(NSArray *)subText  withFont:(UIFont *)font withColor:(UIColor *)color;
-(void) setSubWithRanges:(NSString *)text ranges:(NSArray *) ranges withColor:(UIColor *)color;
-(void) setTextWithName:(NSString *)text color:(UIColor *)color;

-(NSString *) setTextWithNamenew:(NSString *)text color:(UIColor *)color;

-(void) setTextWithNameRange:(NSString *)text color:(UIColor *)color;


@end
