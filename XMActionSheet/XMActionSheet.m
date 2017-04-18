//
//  XMActionSheet.m
//  DongDongWedding
//
//  Created by 懂懂科技 on 17/4/17.
//  Copyright © 2017年 gl. All rights reserved.
//

#import "XMActionSheet.h"
#import "XMActionSheetCell.h"

//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//顶部描述高
#define SHEET_HEADER_HEIGHT 30.0
//cell行高
#define SHEET_ROWHEIGHT 50.0
//取消按钮高
#define SHEET_CANCEL_BUTTON_HEIGHT 50.0
//section间距
#define SHEET_SECTION_MARGIN 10.0
//屏幕两边间距
#define SHEET_SIDE_MARGIN 10.0

@interface XMActionSheet ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIView *shelterView;

@property (nonatomic,strong) actionBlock action;
@end


@implementation XMActionSheet

-(instancetype)init{
    
    if (self=[super init]) {
        
        self.backgroundColor=[UIColor clearColor];
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        [self createShelterView];
        [self createSheetTableView];
    }
    return self;
}

//系统
-(instancetype)initWithTitles:(NSArray *)titlesArray WithActionBlock:(actionBlock)action{
    
    if (self=[super init]) {
        
        _titlesArray=titlesArray;
        _action=action;
        _sheetStyle=XMSheetStyleSystem;
    }
    
    return [self init];
}

//自定义
-(instancetype)initWithTitles:(NSArray *)titlesArray LeftImagesNameArray:(NSArray *)imagesArray sheetDescription:(NSString *)sheetDesc WithActionBlock:(actionBlock)action{
    
    if (self=[super init]) {
        
        _titlesArray=titlesArray;
        _imagesArray=imagesArray;
        _action=action;
        _sheetDesciption=sheetDesc;
        _sheetStyle=XMSheetStyleCustom;
    }
    
    return [self init];
}

-(void)createShelterView{
    
    self.shelterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _shelterView.alpha=0.5;
    _shelterView.backgroundColor=[UIColor blackColor];
    
    [self addSubview:_shelterView];
    
}

-(void)createSheetTableView{
    
    CGFloat tableViewW=SCREEN_WIDTH - 2 * SHEET_SIDE_MARGIN;
    CGFloat tableViewH=_titlesArray.count * SHEET_ROWHEIGHT + SHEET_HEADER_HEIGHT + SHEET_CANCEL_BUTTON_HEIGHT + SHEET_SECTION_MARGIN*2;
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(SHEET_SIDE_MARGIN, SCREEN_HEIGHT - tableViewH, tableViewW, tableViewH) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.scrollEnabled=NO;
    
    [self addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMActionSheetCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([XMActionSheetCell class])];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return self.titlesArray.count;
    }
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        //***系统风格***
        if (_sheetStyle==XMSheetStyleSystem) {
            
            UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sysCell"];
            
            UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-2*SHEET_SIDE_MARGIN, SHEET_ROWHEIGHT)];
            label.text=_titlesArray[indexPath.row];
            label.textAlignment=1;
            if (_titlesColorArray) {
                label.textColor=_titlesColorArray[indexPath.row];
            }
            [cell addSubview:label];
            
            
            //第一个cell切圆角
            if (indexPath.row==0) {
                
                CGRect cellBounds=CGRectMake(0, 0, SCREEN_WIDTH - 2 * SHEET_SIDE_MARGIN, SHEET_ROWHEIGHT);
                
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
                
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                
                maskLayer.frame = cellBounds;
                
                maskLayer.path = maskPath.CGPath;
                
                cell.layer.mask = maskLayer;
            }
            
            //最后一个cell切圆角
            if (indexPath.row==_titlesArray.count-1) {
                
                CGRect cellBounds=CGRectMake(0, 0, SCREEN_WIDTH - 2 * SHEET_SIDE_MARGIN, SHEET_ROWHEIGHT);
                
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
                
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                
                maskLayer.frame = cellBounds;
                
                maskLayer.path = maskPath.CGPath;
                
                cell.layer.mask = maskLayer;
            }
            
            return cell;
        }
        
        //***自定义风格***
        XMActionSheetCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XMActionSheetCell class])];
        
        if(_imagesArray){
            cell.leftImageView.image=[UIImage imageNamed:_imagesArray[indexPath.row]];
        }
        cell.midTitleLabel.text=_titlesArray[indexPath.row];
        
        if (_titlesColorArray) {
            cell.midTitleLabel.textColor=_titlesColorArray[indexPath.row];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.isShowArrow=_isShowArrow;
        
        //最后一个cell切圆角
        if (indexPath.row==_titlesArray.count-1) {
            
            CGRect cellBounds=CGRectMake(0, 0, SCREEN_WIDTH - 2 * SHEET_SIDE_MARGIN, SHEET_ROWHEIGHT);
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            
            maskLayer.frame = cellBounds;
            
            maskLayer.path = maskPath.CGPath;
            
            cell.layer.mask = maskLayer;
        }
        
        return cell;
    }
    
    //***取消按钮***
    if (indexPath.section==1) {
        
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cancelCell"];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, SHEET_CANCEL_BUTTON_HEIGHT)];
        label.text=@"取消";
        label.textAlignment=1;
        label.font=[UIFont systemFontOfSize:20.0];
        if (_cancelBtnColor) {
            label.textColor=_cancelBtnColor;
        }
        
        [cell addSubview:label];
        
        cell.layer.masksToBounds=YES;
        cell.layer.cornerRadius=8.0;

        return cell;
    }
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        UILabel *titleLabel=[[UILabel alloc] init];
        titleLabel.frame=CGRectMake(0, 0, SCREEN_WIDTH - 2 * SHEET_SIDE_MARGIN, SHEET_HEADER_HEIGHT);
        if (_sheetDesciption) {
            titleLabel.text=[NSString stringWithFormat:@"   %@",_sheetDesciption];
        }
        titleLabel.textColor=[UIColor darkGrayColor];
        titleLabel.font=[UIFont systemFontOfSize:14.0];
        titleLabel.backgroundColor=[UIColor whiteColor];
        
        //圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = titleLabel.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        titleLabel.layer.mask = maskLayer;
        
        if (_sheetStyle==XMSheetStyleSystem) {
            titleLabel.hidden=YES;
        }
        
        return titleLabel;
    }
    
    if (section==1) {
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SHEET_SECTION_MARGIN)];
        view.backgroundColor=[UIColor clearColor];
        
        return view;
    }
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return SHEET_ROWHEIGHT;
    }
    
    return SHEET_CANCEL_BUTTON_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        return SHEET_HEADER_HEIGHT;
    }
    return SHEET_SECTION_MARGIN;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        self.action(indexPath.row);
    }
    
    [self hideSheet];
}

-(void)showSheetOnWindow{
    
    CGFloat tableViewX=self.tableView.frame.origin.x;
    CGFloat tableViewY=self.tableView.frame.origin.y;
    CGFloat tableViewW=self.tableView.bounds.size.width;
    CGFloat tableViewH=self.tableView.bounds.size.height;
    
    self.shelterView.alpha=0;
    self.tableView.frame=CGRectMake(tableViewX, SCREEN_HEIGHT, tableViewW, tableViewH);
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.shelterView.alpha=0.5;
        self.tableView.frame=CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideSheet{
    
    CGFloat tableViewX=self.tableView.frame.origin.x;
    CGFloat tableViewW=self.tableView.bounds.size.width;
    CGFloat tableViewH=self.tableView.bounds.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.shelterView.alpha=0;
        self.tableView.frame=CGRectMake(tableViewX, SCREEN_HEIGHT, tableViewW, tableViewH);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
