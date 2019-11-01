//
//  HeadView.m
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "HeadView.h"
#import "Masonry.h"

@interface HeadView ()

//序号
@property (nonatomic) UILabel *XuHaolable;
//代理
@property (nonatomic) UILabel *DaiLilable;
//总单号
@property (nonatomic) UILabel *ZongDanHaolable;
//目的港
@property (nonatomic) UILabel *Mudiganglable;
//件数/重量
@property (nonatomic) UILabel *JSZLlable;
//证书
@property (nonatomic) UILabel *zhengshulable;
//通过
@property (nonatomic) UILabel *tongguolable;

//待定
@property (nonatomic) UILabel *DaidingLable;
//货物类别
@property (nonatomic) UILabel *HuoWULeiBieLable;
//24小时通道
@property (nonatomic) UILabel *hourLable;
//最后首检员工
@property (nonatomic) UILabel *yuangongLable;
// /操作时间
@property (nonatomic) UILabel *timeLable;
//通知
@property (nonatomic) UILabel *tongzhilable;
//备注
@property (nonatomic) UILabel *BZLable;

//headview
@property (nonatomic) UIView * SectionView;

//tableHeadView
@property (nonatomic) UIView *tableHeadView;

@property (nonatomic) UIImageView *lowImageView;

@end

@implementation HeadView

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
    
    [self.tableHeadView addSubview:self.allBtn];
    
    [self.tableHeadView addSubview:self.saveBtn];
    
    [self.tableHeadView addSubview:self.scanBtn];
    
    [self.tableHeadView addSubview:self.shareBtn];
    
    [self.tableHeadView addSubview:self.lowImageView];
    
    [self.tableHeadView addSubview:self.operationBtn];
    
    
    [self.SectionView addSubview:self.XuHaolable];
    [self.SectionView addSubview:self.DaiLilable];
    [self.SectionView  addSubview:self.ZongDanHaolable];
    [self.SectionView  addSubview:self.Mudiganglable];
    [self.SectionView  addSubview:self.JSZLlable];
    [self.SectionView  addSubview:self.zhengshulable];
    [self.SectionView  addSubview:self.tongguolable];
    [self.SectionView  addSubview:self.DaidingLable];
    [self.SectionView  addSubview:self.YJTGBTn];
    [self.SectionView  addSubview:self.HuoWULeiBieLable];
    [self.SectionView  addSubview:self.hourLable];
    [self.SectionView  addSubview:self.yuangongLable];
    [self.SectionView  addSubview:self.timeLable];
    [self.SectionView  addSubview:self.tongzhilable];
//    [self.SectionView addSubview:self.BZLable];
}

- (void)layout{
    
    
    
    [_SectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@60);
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
        make.width.equalTo(self.SectionView).multipliedBy(0.055);
    }];
    
    [_ZongDanHaolable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.left.equalTo(self.DaiLilable.mas_right).offset(10);
        make.width.equalTo(self.SectionView).multipliedBy(0.18).offset(-10);
    }];
    
    [_Mudiganglable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.05);
        make.left.equalTo(self.ZongDanHaolable.mas_right);
    }];
    
    [_JSZLlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.075);
        make.left.equalTo(self.Mudiganglable.mas_right);
    }];
    
    [_zhengshulable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.045);
        make.left.equalTo(self.JSZLlable.mas_right);
    }];
    
//    [_BZLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.zhengshulable.mas_right);
//        make.width.equalTo(self.SectionView).multipliedBy(0.08).offset(20);
//        make.top.bottom.equalTo(self.XuHaolable);
//    }];
    
    
    [_tongguolable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.SectionView).multipliedBy(0.09);
        make.left.equalTo(self.zhengshulable.mas_right).offset((kuan*0.08));
        make.top.equalTo(self.SectionView);
        make.bottom.equalTo(self.YJTGBTn.mas_top);
        make.height.equalTo(self.YJTGBTn);
    }];
    
    [_YJTGBTn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.SectionView);
        make.left.right.equalTo(self.tongguolable);
    }];
    
    self.DaidingLable.hidden = NO;
    if (self.detectionType == DetectionType9610System) {
        self.DaidingLable.hidden = YES;
        [_DaidingLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tongguolable.mas_right);
            make.top.bottom.equalTo(self.XuHaolable);
//            make.width.mas_equalTo(0);
            make.width.equalTo(self.SectionView).multipliedBy(0).offset(-15);
        }];
    }else{
        [_DaidingLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tongguolable.mas_right);
            make.top.bottom.equalTo(self.XuHaolable);
            make.width.equalTo(self.SectionView).multipliedBy(0.09).offset(-15);
        }];
    }
    
    
    [_HuoWULeiBieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.XuHaolable);
        make.width.equalTo(self.SectionView).multipliedBy(0.09).offset(-35);
        make.left.equalTo(self.DaidingLable.mas_right).offset(35);
    }];
    
    self.hourLable.hidden = NO;
    if (self.detectionType == DetectionType9610System) {
//        self.hourLable.hidden = YES;
        [_hourLable mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.top.bottom.equalTo(self.XuHaolable);
            make.width.mas_equalTo(0);
//              make.width.equalTo(self.SectionView).multipliedBy(0.05);
              make.left.equalTo(self.HuoWULeiBieLable.mas_right).offset(15);
          }];
        [_yuangongLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.tongguolable);
            make.left.equalTo(self.hourLable.mas_right);
            make.width.equalTo(self.SectionView).multipliedBy(0.135);
        }];
        
        [_timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.YJTGBTn);
            make.left.equalTo(self.hourLable.mas_right);
            make.width.equalTo(self.SectionView).multipliedBy(0.135);
        }];
    }else{
        
        [_hourLable mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.top.bottom.equalTo(self.XuHaolable);
              make.width.equalTo(self.SectionView).multipliedBy(0.05);
              make.left.equalTo(self.HuoWULeiBieLable.mas_right).offset(15);
          }];
        [_yuangongLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.tongguolable);
            make.left.equalTo(self.hourLable.mas_right);
            make.width.equalTo(self.SectionView).multipliedBy(0.085);
        }];
        
        [_timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.YJTGBTn);
            make.left.equalTo(self.hourLable.mas_right);
            make.width.equalTo(self.SectionView).multipliedBy(0.085);
        }];
    }
    
    [_tongzhilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLable.mas_right);
        make.right.equalTo(self.SectionView);
        make.top.bottom.equalTo(self.XuHaolable);
    }];
    
    [_scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tableHeadView).offset(-10);
        make.top.equalTo(self.tableHeadView).offset(15);
        make.bottom.equalTo(self.tableHeadView).offset(-15);
        make.width.equalTo(self.tableHeadView.mas_width).multipliedBy(0.15);
        make.width.equalTo(@[self.saveBtn.mas_width,self.operationBtn]);
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
    
    [_operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.scanBtn);
        make.right.equalTo(self.shareBtn.mas_left).offset(-20);
    }];
    
    [_lowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allBtn.mas_right).offset(-15);
        make.centerY.equalTo(self.allBtn);
        make.width.height.equalTo(@25);
    }];
    
}

-(void)setDetectionType:(DetectionType)detectionType{
    _detectionType = detectionType;
    
    if (detectionType == DetectionType9610System ) {
        [self layout];
    }
}

#pragma mark------------------------------------------------------------------------------------
- (UILabel *)XuHaolable{
    if (!_XuHaolable) {
        _XuHaolable = [[UILabel alloc] init];
        _XuHaolable.text = @"序号";
        [_XuHaolable setFont:[UIFont boldSystemFontOfSize:15]];
        _XuHaolable.textColor = [UIColor whiteColor];
        _XuHaolable.backgroundColor = NavColor;
        _XuHaolable.textAlignment = NSTextAlignmentLeft;
    }
    return _XuHaolable;
}

- (UILabel *)DaiLilable{
    if (!_DaiLilable) {
        _DaiLilable = [[UILabel alloc] init];
        _DaiLilable.text = @"代理";
        [_DaiLilable setFont:[UIFont boldSystemFontOfSize:15]];
        _DaiLilable.textColor = [UIColor whiteColor];
        _DaiLilable.backgroundColor = NavColor;
        _DaiLilable.textAlignment = NSTextAlignmentLeft;

    }
    return _DaiLilable;
}

- (UILabel *)ZongDanHaolable{
    if (!_ZongDanHaolable) {
        _ZongDanHaolable = [[UILabel alloc] init];
        _ZongDanHaolable.text = @"总单号";
        [_ZongDanHaolable setFont:[UIFont boldSystemFontOfSize:15]];
        _ZongDanHaolable.textColor = [UIColor whiteColor];
        _ZongDanHaolable.backgroundColor = NavColor;
        _ZongDanHaolable.textAlignment = NSTextAlignmentLeft;

    }
    return _ZongDanHaolable;
}

- (UILabel *)Mudiganglable{
    if (!_Mudiganglable) {
        _Mudiganglable = [[UILabel alloc] init];
        _Mudiganglable.text = @"目的港";
        [_Mudiganglable setFont:[UIFont boldSystemFontOfSize:15]];
        _Mudiganglable.textColor = [UIColor whiteColor];
        _Mudiganglable.backgroundColor = NavColor;
        _Mudiganglable.textAlignment = NSTextAlignmentLeft;
        _Mudiganglable.adjustsFontSizeToFitWidth = YES;

    }
    return _Mudiganglable;
}

- (UILabel *)JSZLlable{
    if (!_JSZLlable) {
        _JSZLlable = [[UILabel alloc] init];
        _JSZLlable.text = @"件数/重量";
        [_JSZLlable setFont:[UIFont boldSystemFontOfSize:15]];
        _JSZLlable.textColor = [UIColor whiteColor];
        _JSZLlable.backgroundColor = NavColor;
        _JSZLlable.textAlignment = NSTextAlignmentCenter;

    }
    return _JSZLlable;
}


- (UILabel *)zhengshulable{
    if (!_zhengshulable) {
        _zhengshulable = [[UILabel alloc] init];
        _zhengshulable.text = @"证书";
        [_zhengshulable setFont:[UIFont boldSystemFontOfSize:15]];
        _zhengshulable.textColor = [UIColor whiteColor];
        _zhengshulable.backgroundColor = NavColor;
        _zhengshulable.textAlignment = NSTextAlignmentCenter;

    }
    return _zhengshulable;
}


- (UILabel *)tongguolable{
    if (!_tongguolable) {
        _tongguolable = [[UILabel alloc] init];
        _tongguolable.text = @"通过";
        [_tongguolable setFont:[UIFont boldSystemFontOfSize:15]];
        _tongguolable.textColor = [UIColor whiteColor];
        _tongguolable.backgroundColor = NavColor;
        _tongguolable.textAlignment = NSTextAlignmentCenter;

    }
    return _tongguolable;
}


- (UILabel *)DaidingLable{
    if (!_DaidingLable) {
        _DaidingLable = [[UILabel alloc] init];
        _DaidingLable.text = @"待定";
        [_DaidingLable setFont:[UIFont boldSystemFontOfSize:15]];
        _DaidingLable.textColor = [UIColor whiteColor];
        _DaidingLable.backgroundColor = NavColor;
        _DaidingLable.textAlignment = NSTextAlignmentCenter;

    }
    return _DaidingLable;
}


- (UILabel *)HuoWULeiBieLable{
    if (!_HuoWULeiBieLable) {
        _HuoWULeiBieLable = [[UILabel alloc] init];
        _HuoWULeiBieLable.text = @"货物类别";
        [_HuoWULeiBieLable setFont:[UIFont boldSystemFontOfSize:15]];
        _HuoWULeiBieLable.textColor = [UIColor whiteColor];
        _HuoWULeiBieLable.backgroundColor = NavColor;
        _HuoWULeiBieLable.textAlignment = NSTextAlignmentCenter;
        _HuoWULeiBieLable.numberOfLines = 2;

    }
    return _HuoWULeiBieLable;
}


- (UILabel *)hourLable{
    if (!_hourLable) {
        _hourLable = [[UILabel alloc] init];
        _hourLable.text = @"24小时通道";
        [_hourLable setFont:[UIFont boldSystemFontOfSize:15]];
        _hourLable.textColor = [UIColor whiteColor];
        _hourLable.backgroundColor = NavColor;
        _hourLable.textAlignment = NSTextAlignmentCenter;
        _hourLable.numberOfLines = 2;


    }
    return _hourLable;
}


- (UILabel *)yuangongLable{
    if (!_yuangongLable) {
        _yuangongLable = [[UILabel alloc] init];
        _yuangongLable.text = @"最后首检员工";
        [_yuangongLable setFont:[UIFont boldSystemFontOfSize:12]];
        _yuangongLable.textColor = [UIColor whiteColor];
        _yuangongLable.backgroundColor = NavColor;
        _yuangongLable.textAlignment = NSTextAlignmentCenter;
        _yuangongLable.adjustsFontSizeToFitWidth = YES;

    }
    return _yuangongLable;
}


- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.text = @"/操作时间";
        [_timeLable setFont:[UIFont boldSystemFontOfSize:15]];
        _timeLable.textColor = [UIColor whiteColor];
        _timeLable.backgroundColor = NavColor;
        _timeLable.textAlignment = NSTextAlignmentCenter;

    }
    return _timeLable;
}

- (UILabel *)tongzhilable{
    if (!_tongzhilable) {
        _tongzhilable = [[UILabel alloc] init];
        _tongzhilable.text = @"通知";
        [_tongzhilable setFont:[UIFont boldSystemFontOfSize:15]];
        _tongzhilable.textColor = [UIColor whiteColor];
        _tongzhilable.backgroundColor = NavColor;
        _tongzhilable.textAlignment = NSTextAlignmentCenter;

    }
    return _tongzhilable;
}

- (UILabel *)BZLable{
    if (!_BZLable) {
        _BZLable = [[UILabel alloc] init];
        _BZLable.text = @"备注";
        [_BZLable setFont:[UIFont boldSystemFontOfSize:15]];
        _BZLable.textColor = [UIColor whiteColor];
        _BZLable.backgroundColor = NavColor;
        _BZLable.textAlignment = NSTextAlignmentCenter;
        
    }
    return _BZLable;
}



- (UIButton *)YJTGBTn{
    if (!_YJTGBTn) {
        _YJTGBTn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_YJTGBTn setTitle:@"一键通过" forState:UIControlStateNormal];
        [_YJTGBTn setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
        [_YJTGBTn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        _YJTGBTn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _YJTGBTn;
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

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.layer.cornerRadius = 5;
        _shareBtn.layer.masksToBounds = YES;
        [_shareBtn setBackgroundColor:[UIColor colorWithRed:0.596 green:0.784 blue:0.157 alpha:1.00]];
        [_shareBtn setTitle:@"查询共享证书" forState:UIControlStateNormal];
        [_shareBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];

    }
    return _shareBtn;
}


- (UIButton *)operationBtn{
    if (!_operationBtn) {
        _operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationBtn.layer.cornerRadius = 5;
        _operationBtn.layer.masksToBounds = YES;
        [_operationBtn setBackgroundColor:[UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00]];
        [_operationBtn setTitle:@"操作说明" forState:UIControlStateNormal];
        [_operationBtn.titleLabel setFont:[UIFont systemFontOfSize:25]];
        
    }
    return _operationBtn;
}



- (UIImageView *)lowImageView{
    if (!_lowImageView) {
        _lowImageView = [[UIImageView alloc] init];
        _lowImageView.image = [UIImage imageNamed:@"low"];
    }
    return _lowImageView;
}


@end
