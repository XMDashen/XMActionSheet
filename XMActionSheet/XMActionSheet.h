//
//  XMActionSheet.h
//  DongDongWedding
//
//  Created by 懂懂科技 on 17/4/17.
//  Copyright © 2017年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^actionBlock)(NSInteger);

typedef enum : NSUInteger {
    XMSheetStyleSystem,
    XMSheetStyleCustom,
} XMSheetStyle;

@interface XMActionSheet : UIView

/*sheet选项标题*/
@property (nonatomic,strong) NSArray *titlesArray;

/*sheet选项图标*/
@property (nonatomic,strong) NSArray<NSString *> *imagesArray;

/*是否显示右侧箭头*/
@property (nonatomic,assign) BOOL isShowArrow;

/*sheet顶部描述*/
@property (nonatomic,strong) NSString *sheetDesciption;

/*sheet风格*/
@property (nonatomic,assign) XMSheetStyle sheetStyle;

/*取消按钮颜色*/
@property (nonatomic,strong) UIColor *cancelBtnColor;

/*sheet选项标题颜色*/
@property (nonatomic,strong) NSArray<UIColor *> *titlesColorArray;

/*初始化系统风格*/
-(instancetype)initWithTitles:(NSArray *)titlesArray WithActionBlock:(actionBlock)action;

/*初始化自定义风格*/
-(instancetype)initWithTitles:(NSArray *)titlesArray LeftImagesNameArray:(NSArray<NSString *> *)imagesArray sheetDescription:(NSString *)sheetDesc WithActionBlock:(actionBlock)action;

/*弹出窗口*/
-(void)showSheetOnWindow;

/*隐藏窗口*/
-(void)hideSheet;

@end
