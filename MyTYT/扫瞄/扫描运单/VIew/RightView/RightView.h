//
//  RightView.h
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInfoView.h"
#import "ScanVC.h"
#import "CheckBottomView.h"

@class InfoView;
@interface RightView : UIView

-(instancetype)initWithFrame:(CGRect)frame vcType:(ScanType)vcType;

@property (nonatomic) UIButton *ScanBtn;

@property (nonatomic) UILabel *titlelable;

@property (nonatomic) InfoView *infoView;
@property (nonatomic,strong) CheckInfoView *view_checkInfo;


/// 备注
@property (nonatomic,strong) UIView *view_beizhu;

/// 1.不合格 2.暂扣 3.通过 4.备注
@property (nonatomic,copy) void(^bottomClickBlock)(NSInteger clickType);


-(void)configDataWithBillModel:(ScanBillModel *)billModel;

@end
