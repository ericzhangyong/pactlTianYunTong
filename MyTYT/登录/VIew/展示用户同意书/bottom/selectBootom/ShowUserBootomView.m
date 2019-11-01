//
//  ShowUserBootomView.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowUserBootomView.h"
#import "Masonry.h"

@implementation ShowUserBootomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
        
        [self layout];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)creatUI{
    [self addSubview:self.surebtn];
    [self addSubview:self.cancelbtn];
}

- (void)layout{
    [_surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(50);
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-20);
        make.right.equalTo(self.cancelbtn.mas_left).offset(-50);
    }];
    
    [_cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.surebtn);
        make.right.equalTo(self).offset(-50);
        make.width.equalTo(self.surebtn);
    }];
    
}

- (UIButton *)surebtn{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.layer.masksToBounds = YES;
        _surebtn.layer.cornerRadius = 5;
        _surebtn.backgroundColor = NavColor;
        [_surebtn setTitle:@"确定" forState:UIControlStateNormal];
        [_surebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _surebtn;
}

- (UIButton *)cancelbtn{
    if (!_cancelbtn) {
        _cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelbtn.layer.masksToBounds = YES;
        _cancelbtn.layer.cornerRadius = 5;
        _cancelbtn.backgroundColor = NavColor;
        [_cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [_cancelbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _cancelbtn;
}

@end
