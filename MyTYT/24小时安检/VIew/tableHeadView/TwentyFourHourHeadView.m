//
//  TwentyFourHourHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyFourHourHeadView.h"
#import "MyLable.h"
#import "Masonry.h"
#import "NSString+Helper.h"

@interface TwentyFourHourHeadView ()

//序号
@property (nonatomic) MyLable *XuHaolable;
//代理
@property (nonatomic) MyLable *DaiLilable;
//总单号
@property (nonatomic) MyLable *ZongDanHaolable;
//目的港
@property (nonatomic) MyLable *Mudiganglable;
//件数/重量
@property (nonatomic) MyLable *JSZLlable;
//证书
@property (nonatomic) MyLable *zhengshulable;
//通过
@property (nonatomic) MyLable *tongguolable;

//待定
@property (nonatomic) MyLable *DaidingLable;
//货物类别
@property (nonatomic) MyLable *HuoWULeiBieLable;
//24小时通道
@property (nonatomic) MyLable *hourLable;
//通道货物数量
@property (nonatomic) MyLable *roadCountLable;
//24小时货待过安检机
@property (nonatomic) MyLable *twentyMachineLable;
//安检机
@property (nonatomic) MyLable *AJMachinelable;

//headview
@property (nonatomic) UIView * SectionView;

//tableHeadView
@property (nonatomic) UIView *tableHeadView;

@property (nonatomic) UIImageView *lowImageView;


@end

@implementation TwentyFourHourHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self creatUI];
        
        [self layout];
        
        
        
    }
    return self;
}

- (void)creatUI{
    
    self.SectionView.backgroundColor = NavColor;
    
    [self addSubview:self.tableHeadView];
    [self addSubview:self.SectionView];
    
    [self.tableHeadView addSubview:self.RoadExplainBtn];
    
    [self.tableHeadView addSubview:self.allBtn];
    
    [self.tableHeadView addSubview:self.saveBtn];
    
    [self.tableHeadView addSubview:self.scanBtn];
    
    [self.tableHeadView addSubview:self.shareBtn];
    
    [self.tableHeadView addSubview:self.lowImageView];
    
    self.XuHaolable = [[MyLable alloc] initWithTitle:@"序号"];
    self.DaiLilable = [[MyLable alloc] initWithTitle:@"代理"];
    self.ZongDanHaolable = [[MyLable alloc] initWithTitle:@"总单号"];
    self.Mudiganglable = [[MyLable alloc] initWithTitle:@"目的港"];
    self.JSZLlable = [[MyLable alloc] initWithTitle:@"件数/重量"];
    self.zhengshulable = [[MyLable alloc] initWithTitle:@"证书"];
    self.tongguolable = [[MyLable alloc] initWithTitle:@"通过"];
    self.DaidingLable = [[MyLable alloc] initWithTitle:@"待定"];
    self.HuoWULeiBieLable = [[MyLable alloc] initWithTitle:@"货物类别"];
    self.hourLable = [[MyLable alloc] initWithTitle:@"24小时通道"];
    self.roadCountLable = [[MyLable alloc] initWithTitle:@"通道货物数量"];
    self.twentyMachineLable = [[MyLable alloc] initWithTitle:@"24小时货待过安检机"];
    self.AJMachinelable = [[MyLable alloc] initWithTitle:@"安检机"];


    
    [self.SectionView addSubview:self.XuHaolable];
    [self.SectionView addSubview:self.DaiLilable];
    [self.SectionView  addSubview:self.ZongDanHaolable];
    [self.SectionView  addSubview:self.Mudiganglable];
    [self.SectionView  addSubview:self.JSZLlable];
    [self.SectionView  addSubview:self.zhengshulable];
    [self.SectionView  addSubview:self.tongguolable];
    [self.SectionView  addSubview:self.DaidingLable];
    [self.SectionView  addSubview:self.HuoWULeiBieLable];
    [self.SectionView  addSubview:self.hourLable];
    [self.SectionView  addSubview:self.roadCountLable];
    [self.SectionView  addSubview:self.twentyMachineLable];
    [self.SectionView  addSubview:self.AJMachinelable];
    
    self.zhengshulable.textAlignment = NSTextAlignmentCenter;
    self.tongguolable.textAlignment = NSTextAlignmentCenter;
    self.DaidingLable.textAlignment = NSTextAlignmentCenter;
    self.HuoWULeiBieLable.textAlignment = NSTextAlignmentCenter;
    self.roadCountLable.textAlignment = NSTextAlignmentCenter;
    self.hourLable.textAlignment = NSTextAlignmentCenter;
    self.twentyMachineLable.textAlignment = NSTextAlignmentCenter;
    self.AJMachinelable.textAlignment = NSTextAlignmentCenter;
    
    self.HuoWULeiBieLable.numberOfLines = 2;
    
    self.hourLable.numberOfLines = 2;
    self.hourLable.preferredMaxLayoutWidth = kuan*0.0675 - 15;
    
  CGFloat width = [NSString autoWidthWithString:@"通货物" Font:[UIFont systemFontOfSize:15]];
    
    self.roadCountLable.numberOfLines = 2;
    self.roadCountLable.preferredMaxLayoutWidth = width;
    
    self.twentyMachineLable.numberOfLines = 3;
    self.twentyMachineLable.preferredMaxLayoutWidth = width;
    

}

- (void)layout{
    

    CGFloat ZSDistance = kuan *0.07;
    
    [_SectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@80);
    }];
    
    [_tableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.SectionView.mas_top);
    }];
    
    
    [_XuHaolable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.SectionView);
        make.width.equalTo(self.SectionView).multipliedBy(0.05).offset(-5);
        make.left.equalTo(self.SectionView).offset(5);
    }];
    
    [_DaiLilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.left.equalTo(self.XuHaolable.mas_right);
        make.width.equalTo(self.SectionView).multipliedBy(0.06);
    }];
    
    [_ZongDanHaolable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.left.equalTo(self.DaiLilable.mas_right);
        make.width.equalTo(self.SectionView).multipliedBy(0.17);
    }];
    
    [_Mudiganglable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.05);
        make.left.equalTo(self.ZongDanHaolable.mas_right);
    }];
    
    [_JSZLlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.07);
        make.left.equalTo(self.Mudiganglable.mas_right);
    }];
    
    [_zhengshulable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.045);
        make.left.equalTo(self.JSZLlable.mas_right);
    }];
    
    
    [_tongguolable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.SectionView).multipliedBy(0.08).offset(-15);
        make.left.equalTo(self.zhengshulable.mas_right).offset(ZSDistance);
        make.top.bottom.equalTo(self.XuHaolable);
    }];
    
    
    [_DaidingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tongguolable.mas_right).offset(15);
        make.top.bottom.equalTo(self.tongguolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.08).offset(-15);
    }];
    
    [_HuoWULeiBieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.08).offset(-35);
        make.left.equalTo(self.DaidingLable.mas_right).offset(35);
    }];
    
    [_hourLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.06).offset(-15);
        make.left.equalTo(self.HuoWULeiBieLable.mas_right).offset(15);
    }];
    
    [_roadCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tongguolable);
        make.left.equalTo(self.hourLable.mas_right).offset(15);
        make.width.equalTo(self.SectionView).multipliedBy(0.0625).offset(-15);
    }];
    
    [_twentyMachineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roadCountLable.mas_right).offset(15);
        make.width.greaterThanOrEqualTo(self.SectionView).multipliedBy(0.0625).offset(-15);
        make.top.bottom.equalTo(self.tongguolable);
    }];
    
    [_AJMachinelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).offset(-(kuan * 0.06));
        make.width.equalTo(self.SectionView).multipliedBy(0.06).offset(-15);
        make.top.bottom.equalTo(self.XuHaolable);
        make.right.lessThanOrEqualTo(self.SectionView);
    }];
    
    
    [_RoadExplainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tableHeadView).offset(-10);
        make.top.equalTo(self.tableHeadView).offset(15);
        make.bottom.equalTo(self.tableHeadView).offset(-15);
        make.width.equalTo(self.tableHeadView.mas_width).multipliedBy(0.15);
        make.width.equalTo(@[self.saveBtn,self.scanBtn]);
    }];

    [_scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.RoadExplainBtn.mas_left).offset(-20);
        make.top.bottom.equalTo(self.RoadExplainBtn);
    }];

    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scanBtn.mas_left).offset(-20);
        make.top.bottom.equalTo(self.scanBtn);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.saveBtn.mas_left).offset(-20);
        make.top.bottom.equalTo(self.scanBtn);
        make.width.equalTo(self.tableHeadView.mas_width).multipliedBy(0.17);
    }];

    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.scanBtn);
        make.left.equalTo(self.tableHeadView).offset(15);
        make.width.equalTo(@170);
    }];

    [_lowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allBtn.mas_right).offset(-15);
        make.centerY.equalTo(self.allBtn);
        make.width.height.equalTo(@25);
    }];
    
   
    
}


#pragma mark------------------------------------------------------------------------------------



- (UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _allBtn.layer.cornerRadius = 5;
        _allBtn.layer.masksToBounds = YES;
        _allBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _allBtn.layer.borderWidth = 0.5;
        [_allBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        
    }
    return _allBtn;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.layer.cornerRadius = 5;
        _saveBtn.layer.masksToBounds = YES;
        [_saveBtn setBackgroundColor:[UIColor colorWithRed:0.953 green:0.635 blue:0.012 alpha:1.00]];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];

    }
    return _saveBtn;
}

- (UIButton *)scanBtn{
    if (!_scanBtn) {
        _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanBtn.layer.cornerRadius = 5;
        _scanBtn.layer.masksToBounds = YES;
        [_scanBtn setBackgroundColor:BZCOlor];
        [_scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
        [_scanBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];

    }
    return _scanBtn;
}

- (UIButton *)RoadExplainBtn{
    if (!_RoadExplainBtn) {
        _RoadExplainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _RoadExplainBtn.layer.cornerRadius = 5;
        _RoadExplainBtn.layer.masksToBounds = YES;
        [_RoadExplainBtn setBackgroundColor:[UIColor colorWithRed:0.482 green:0.447 blue:0.914 alpha:1.00]];
        [_RoadExplainBtn setTitle:@"通道说明" forState:UIControlStateNormal];
        [_RoadExplainBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];

    }
    return _RoadExplainBtn;
}

- (UIImageView *)lowImageView{
    if (!_lowImageView) {
        _lowImageView = [[UIImageView alloc] init];
        _lowImageView.image = [UIImage imageNamed:@"low"];
    }
    return _lowImageView;
}


- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc] init];
        _tableHeadView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _tableHeadView;
}

- (UIView *)SectionView{
    if (!_SectionView) {
        _SectionView = [[UIView alloc] init];
    }
    return _SectionView;
}

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.layer.cornerRadius = 5;
        _shareBtn.layer.masksToBounds = YES;
        [_shareBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];
        [_shareBtn setBackgroundColor:[UIColor colorWithRed:0.596 green:0.784 blue:0.157 alpha:1.00]];
        [_shareBtn setTitle:@"查询共享证书" forState:UIControlStateNormal];
    }
    return _shareBtn;
}


@end
