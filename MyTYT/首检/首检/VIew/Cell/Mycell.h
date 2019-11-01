//
//  Mycell.h
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstVC.h"

@class FirstModel;

@interface Mycell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *EleRightConstant;

@property (weak, nonatomic) IBOutlet UILabel *xuhaoLable;
@property (weak, nonatomic) IBOutlet UILabel *DaiLILable;
@property (weak, nonatomic) IBOutlet UILabel *ceLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cecontant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *JianJuConconstant;
@property (weak, nonatomic) IBOutlet UILabel *Eletritclable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *elecontant;

@property (weak, nonatomic) IBOutlet UIImageView *XImageView;
@property (weak, nonatomic) IBOutlet UIButton *ZDBtn;
@property (weak, nonatomic) IBOutlet UILabel *MudiLable;
@property (weak, nonatomic) IBOutlet UIButton *DisPlayZBBtn;
@property (weak, nonatomic) IBOutlet UILabel *jianshuLable;
@property (weak, nonatomic) IBOutlet UIButton *ZSBtn;
@property (weak, nonatomic) IBOutlet UIButton *tongguoBtn;
@property (weak, nonatomic) IBOutlet UIButton *daiDingBtn;
@property (weak, nonatomic) IBOutlet UIButton *HWLBBtn;
@property (weak, nonatomic) IBOutlet UILabel *YGNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *TZBtn;
@property (weak, nonatomic) IBOutlet UIView *TZVIew;
@property (weak, nonatomic) IBOutlet UILabel *TZcountLable;
@property (weak, nonatomic) IBOutlet UIView *TongguoVIew;
@property (weak, nonatomic) IBOutlet UILabel *tongguocountLable;
@property (weak, nonatomic) IBOutlet UIView *daidingVIew;

@property (weak, nonatomic) IBOutlet UILabel *daiDingOCuntLable;
@property (weak, nonatomic) IBOutlet UIView *huowuleibieVIew;
@property (weak, nonatomic) IBOutlet UILabel *roadlable;

@property (weak, nonatomic) IBOutlet UIView *controlView;

- (void)loaddtaWithModel:(FirstModel *)model row:(NSInteger)row;

/// 检测类型
@property (nonatomic,assign) DetectionType detectionType;


@end
