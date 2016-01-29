//
//  UIImageView+LO.h
//  YM
//
//  Created by locojoy on 15/10/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LO)


-(void) sd_imageWithImageId:(NSString *) imageid  placeholderImage:(UIImage *)placeholder;


//group
-(UIImageView *) getIconView;
-(void) addImageIcon;
-(void) removeIcon;


@end
