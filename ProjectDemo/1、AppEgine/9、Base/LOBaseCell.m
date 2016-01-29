//
//  LOBaseCell.m
//  YM
//
//  Created by locojoy on 15/9/11.
//  Copyright (c) 2015年 YM. All rights reserved.
//

#import "LOBaseCell.h"

@implementation LOBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


+ (instancetype)cellShow{
    
    NSString *nibname = [NSString stringWithFormat:@"%@",[self class]];
    return [[NSBundle mainBundle] loadNibNamed:nibname owner:nil options:nil][0];
    
}
@end
