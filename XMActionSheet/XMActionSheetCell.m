//
//  XMActionSheetCell.m
//  DongDongWedding
//
//  Created by 懂懂科技 on 17/4/17.
//  Copyright © 2017年 gl. All rights reserved.
//

#import "XMActionSheetCell.h"

@interface XMActionSheetCell ()



@end

@implementation XMActionSheetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIsShowArrow:(BOOL)isShowArrow{
    
    _isShowArrow=isShowArrow;
    
    if (_isShowArrow) {
        self.rightImageView.hidden=NO;
    }else{
        self.rightImageView.hidden=YES;
    }
}

@end
