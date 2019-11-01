//
//  ScanBotoomView.m
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanBotoomView.h"
#import "Masonry.h"

@implementation ScanBotoomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
        
        [self layout];
   
    }
    return self;
}

- (void)dealloc{
    FlyLog(@"bottomview---delloc");
}

- (void)creatUI{
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.alertTitle];
    [self addSubview:self.ScanLable];
    [self addSubview:self.writBtn];
}

- (void)layout{
    
    [_ScanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.centerX.equalTo(self);
    }];
    
    [_alertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ScanLable.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    [_writBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-15);
        make.centerX.equalTo(self);
      
    }];
}

#pragma mark------------------------------------------------------------------------------------
- (UILabel *)ScanLable{
    if (!_ScanLable) {
        _ScanLable = [[UILabel alloc] init];
        _ScanLable.font = [UIFont boldSystemFontOfSize:35];
        _ScanLable.textAlignment = NSTextAlignmentCenter;
        _ScanLable.textColor = [UIColor blackColor];
        _ScanLable.text = @"扫描运单";
    }
    return _ScanLable;
}

- (UILabel *)alertTitle{
    if (!_alertTitle) {
        _alertTitle = [[UILabel alloc] init];
        _alertTitle.textAlignment = NSTextAlignmentCenter;
        _alertTitle.textColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
        _alertTitle.text = @"将运单放入方框内";
    }
    return _alertTitle;
}

- (UIButton *)writBtn{
    if (!_writBtn) {
        _writBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_writBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_writBtn setTitle:@"手动输入运单详细信息" forState:UIControlStateNormal];
    }
    return _writBtn;
}

@end
