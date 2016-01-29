//
//  UITextField+FC.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-31.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "UITextField+FC.h"

@implementation UITextField (FC)

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect{
    
    UIColor * placeholderColor;
    if ([[[NSUserDefaults standardUserDefaults ] objectForKey:@"placeHoldColor"]  isEqual: @"placeHoldColor"]) {
        
//        placeholderColor = kPlaceHolderColor;//设置颜色
        
    }else{
        
        placeholderColor = [UIColor greenColor];//设置颜色
        
    }

    [placeholderColor setFill];
    
    rect.origin.y = rect.size.height /3;
    
//    [[self placeholder] drawInRect:rect withAttributes:@{
//                                                        NSFontAttributeName:kValueFont,
//                                                        NSForegroundColorAttributeName:placeholderColor
//                                                        }];
    
    
}
@end
