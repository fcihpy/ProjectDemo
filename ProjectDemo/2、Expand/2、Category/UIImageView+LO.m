//
//  UIImageView+LO.m
//  YM
//
//  Created by locojoy on 15/10/23.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "UIImageView+LO.h"
#import "UIImageView+WebCache.h"
#import "LOHelp.h"


@implementation UIImageView (LO)


-(void) sd_imageWithImageId:(NSString *) imageid  placeholderImage:(UIImage *)placeholder
{
    if (imageid) {
//        NSString *url = [NSString stringWithFormat:@"%@%@", RES_BASE_URL, imageid];
//        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
    }
    else
    {
        self.image = placeholder;
    }
}


#pragma mark - groupIcon
-(void) addImageIcon
{
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    iconView.tag = 0x0A1;
    iconView.image = [UIImage imageNamed:@"groupflage"];
    [self addSubview:iconView];
}

-(UIImageView *) getIconView
{
    UIImageView *icon = (UIImageView *)[self viewWithTag:0x0A1];
    return icon;
}

-(void) removeIcon{
    UIImageView *icon = [self getIconView];
    if (icon) {
        [icon removeFromSuperview];
    }
}
@end
