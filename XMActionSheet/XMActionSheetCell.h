//
//  XMActionSheetCell.h
//  DongDongWedding
//
//  Created by 懂懂科技 on 17/4/17.
//  Copyright © 2017年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMActionSheetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UILabel *midTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (nonatomic,assign) BOOL isShowArrow;

@end
