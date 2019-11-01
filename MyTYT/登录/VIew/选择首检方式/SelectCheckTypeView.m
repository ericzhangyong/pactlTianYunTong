//
//  SelectCheckTypeView.m
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectCheckTypeView.h"
#import "Masonry.h"

@interface SelectCheckTypeView ()

@property (nonatomic) UIView *backView;

@property (nonatomic) UIButton *firstBtn;

@property (nonatomic) UIButton *hourBtn;

@property (nonatomic) UIButton *btn_9610;

@property (nonatomic, copy) CheckTypeBlock checkblock;

@end

@implementation SelectCheckTypeView


+ (void)showSelectType:(CheckTypeBlock)block{
    
    SelectCheckTypeView *checkview = [[SelectCheckTypeView alloc] init];
    
    checkview.checkblock = block;
    
    [checkview creatUI];
    
}

- (void)showanimation{
    
    self.backView.alpha = 0;
    self.backView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
  
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.backView.alpha = 1;
        self.backView.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)disaniamtion{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

- (void)firstEvent{
    [self disaniamtion];
    self.checkblock(FirstCheck);
}

- (void)hourEvent{
    [self disaniamtion];
    self.checkblock(twenty_fourHourCheck);

    
}

-(void)btn9610Event{
    [self disaniamtion];
    self.checkblock(Check9610);
}

#pragma mark------------------------------------------------------------------------------------

- (void)creatUI{
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    
    self.frame = [UIScreen mainScreen].bounds;
    
    [self layoutUI];
    
    [keywindow addSubview:self];
    
    [self showanimation];
}

- (void)layoutUI{
    
    [self addSubview:self.backView];
    
    [self.backView addSubview:self.firstBtn];
    [self.backView addSubview:self.hourBtn];
    [self.backView addSubview:self.btn_9610];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.height.equalTo(@430);
        make.width.equalTo(self).multipliedBy(0.6);
    }];
    
    [_firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(40);
        make.height.mas_equalTo(90);
        make.left.equalTo(self.backView).offset(50);
        make.right.equalTo(self.backView).offset(-50);
    }];
    
    [_hourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.firstBtn);
        make.top.equalTo(self.firstBtn.mas_bottom).offset(40);
        make.height.mas_equalTo(90);
    }];
    
    [self.btn_9610 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.firstBtn);
        make.top.equalTo(self.hourBtn.mas_bottom).offset(40);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-40);
    }];
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIButton *)firstBtn{
    if (!_firstBtn) {
        _firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firstBtn setTitle:@"安检首检" forState:UIControlStateNormal];
        _firstBtn.backgroundColor = NavColor;
        [_firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_firstBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
        _firstBtn.layer.cornerRadius = 5;
        _firstBtn.layer.masksToBounds = YES;
        [_firstBtn addTarget:self action:@selector(firstEvent) forControlEvents:UIControlEventTouchUpInside];

    }
    return _firstBtn;
}


- (UIButton *)hourBtn{
    if (!_hourBtn) {
        _hourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hourBtn setTitle:@"24小时检测" forState:UIControlStateNormal];
        _hourBtn.backgroundColor = NavColor;
        [_hourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _hourBtn.layer.cornerRadius = 5;
        _hourBtn.layer.masksToBounds = YES;
        [_hourBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
        [_hourBtn addTarget:self action:@selector(hourEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hourBtn;
}
- (UIButton *)btn_9610{
    if (!_btn_9610) {
        _btn_9610 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_9610 setTitle:@"9610系统检测" forState:UIControlStateNormal];
        _btn_9610.backgroundColor = NavColor;
        [_btn_9610 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_9610.layer.cornerRadius = 5;
        _btn_9610.layer.masksToBounds = YES;
        [_btn_9610.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
        [_btn_9610 addTarget:self action:@selector(btn9610Event) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_9610;
}


@end
