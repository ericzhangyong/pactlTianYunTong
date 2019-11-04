//
//  AddBZBottomView.m
//  MyTYT
//
//  Created by zhangyong on 2019/11/1.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CheckBottomView.h"
#import "Masonry.h"


@interface CheckBottomView ()

@property (nonatomic,strong) UIButton *btn_tongGuo;
@property (nonatomic,strong) UIButton *btn_zanKou;
@property (nonatomic,strong) UIButton *btn_buHeGe;
@property (nonatomic,strong) UIButton *btn_beiZhu;

@end
@implementation CheckBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews{
    
    [self addSubview:self.btn_beiZhu];
    [self addSubview:self.btn_buHeGe];
    [self addSubview:self.btn_zanKou];
    [self addSubview:self.btn_tongGuo];
    
    
    [self.btn_beiZhu addTarget:self action:@selector(btn_beiZhuClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_buHeGe addTarget:self action:@selector(btn_buHeGeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_zanKou addTarget:self action:@selector(btn_zanKouClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_tongGuo addTarget:self action:@selector(btn_tongGuoClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark- click
-(void)btn_tongGuoClick{
    if (self.bottomClickBlock) {
        self.bottomClickBlock(3);
    }
}

-(void)btn_zanKouClick{
    if (self.bottomClickBlock) {
        self.bottomClickBlock(2);
    }
}

-(void)btn_buHeGeClick{
    if (self.bottomClickBlock) {
        self.bottomClickBlock(1);
    }
}

-(void)btn_beiZhuClick{
    if (self.bottomClickBlock) {
        self.bottomClickBlock(4);
    }
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.btn_beiZhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-40);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
    }];
    
    [self.btn_buHeGe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn_beiZhu.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
    }];
    
    [self.btn_zanKou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn_buHeGe.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
    }];
    
    [self.btn_tongGuo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn_zanKou.mas_left).offset(-10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(70);
    }];
}


#pragma mark- lazy
-(UIButton *)btn_tongGuo{
    if (!_btn_tongGuo) {
        _btn_tongGuo  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_tongGuo setTitle:@"通过" forState:UIControlStateNormal];
        [_btn_tongGuo setBackgroundColor:Color9A9A9A];
        [_btn_tongGuo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_tongGuo.layer.masksToBounds = YES;
        _btn_tongGuo.layer.cornerRadius = 4;
    }
    return _btn_tongGuo;
}

- (UIButton *)btn_zanKou{
    if (!_btn_zanKou) {
        _btn_zanKou = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_zanKou setTitle:@"暂扣" forState:UIControlStateNormal];
        [_btn_zanKou setBackgroundColor:Color9A9A9A];
        [_btn_zanKou setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_zanKou.layer.masksToBounds = YES;
        _btn_zanKou.layer.cornerRadius = 4;
    }
    return _btn_zanKou;
}

-(UIButton *)btn_buHeGe{
    if (!_btn_buHeGe) {
        _btn_buHeGe = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_buHeGe setTitle:@"不合格" forState:UIControlStateNormal];
        [_btn_buHeGe setBackgroundColor:Color9A9A9A];
        [_btn_buHeGe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn_buHeGe.layer.masksToBounds = YES;
        _btn_buHeGe.layer.cornerRadius = 4;
    }
    return _btn_buHeGe;
}
-(UIButton *)btn_beiZhu{
    if (!_btn_beiZhu) {
        _btn_beiZhu = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_beiZhu setTitle:@"备注" forState:UIControlStateNormal];
        [_btn_beiZhu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_btn_beiZhu setBackgroundColor:Color9A9A9A];
        [_btn_beiZhu setBackgroundColor:Color0093F0];
        _btn_beiZhu.layer.masksToBounds = YES;
        _btn_beiZhu.layer.cornerRadius = 4;
    }
    return _btn_beiZhu;
}


@end
