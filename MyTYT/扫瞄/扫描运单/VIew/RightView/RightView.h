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

@class InfoView;
@interface RightView : UIView

-(instancetype)initWithFrame:(CGRect)frame vcType:(ScanVCType)vcType;

@property (nonatomic) UIButton *ScanBtn;

@property (nonatomic) UILabel *titlelable;

@property (nonatomic) InfoView *infoView;
@property (nonatomic,strong) CheckInfoView *view_checkInfo;


/// 备注
@property (nonatomic,strong) UIView *view_beizhu;




-(void)configData;

@end
