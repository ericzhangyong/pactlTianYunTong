//
//  RightView.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "RightView.h"
#import "InfoView.h"
#import "Masonry.h"

@implementation RightView

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
    [self addSubview:self.ScanBtn];
    [self addSubview:self.titlelable];
    [self addSubview:self.infoView];
}

- (void)layout{
    
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(30);
        make.height.height.equalTo(@40);
    }];
    
    [_ScanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@35);
        make.width.equalTo(@100);
        make.centerY.equalTo(self.titlelable);
    }];
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20);
        make.top.equalTo(self.ScanBtn.mas_bottom).offset(25);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
}

- (UIButton *)ScanBtn{
    if (!_ScanBtn) {
        _ScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ScanBtn setTitle:@"扫描" forState:UIControlStateNormal];
        _ScanBtn.layer.cornerRadius = 17.5;
        _ScanBtn.layer.masksToBounds = YES;
        _ScanBtn.backgroundColor = NavColor;
        [_ScanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ScanBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_ScanBtn setImage:[UIImage imageNamed:@"san"] forState:UIControlStateNormal];
        [_ScanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    return _ScanBtn;
}

- (UILabel *)titlelable{
    if (!_titlelable) {
        _titlelable =[[UILabel alloc] init];
        _titlelable.text = @"运单信息";
        _titlelable.font = [UIFont boldSystemFontOfSize:25];
        _titlelable.textColor = [UIColor blackColor];
    }
    return _titlelable;
}

- (InfoView *)infoView{
    if (!_infoView) {
        _infoView = [[InfoView alloc] init];
        _infoView.backgroundColor = [UIColor whiteColor];
        _infoView.hidden = YES;
    }
    return _infoView;
}

@end
