//
//  CheckBIllselectHeaderView.m
//  MyTYT
//
//  Created by zhangyong on 2019/11/10.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CheckBIllselectHeaderView.h"

@interface CheckBIllselectHeaderView()

@property (nonatomic,strong) UILabel *label_fendanHao;
@property (nonatomic,strong) UILabel *label_allOrder;
@property (nonatomic,strong) UILabel *label_daiLi;
@end
@implementation CheckBIllselectHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
            
        [self addSubview:self.label_fendanHao];
        [self addSubview:self.label_allOrder];
        [self addSubview:self.label_daiLi];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.label_fendanHao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.48).offset(-15);
    }];
    [self.label_daiLi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-85);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(self);
    }];
    
    [self.label_allOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_fendanHao.mas_right);
        make.right.equalTo(self.label_daiLi.mas_left);
        make.centerY.equalTo(self);
    }];
}


#pragma mark- lazy
-(UILabel *)label_fendanHao{
    if (!_label_fendanHao) {
        _label_fendanHao = [UILabel new];
        _label_fendanHao.text = @"分单号";
        _label_fendanHao.textAlignment = NSTextAlignmentCenter;
        _label_fendanHao.font = [UIFont systemFontOfSize:14];
    }
    return _label_fendanHao;
}
-(UILabel *)label_allOrder{
    if (!_label_allOrder) {
        _label_allOrder = [UILabel new];
        _label_allOrder.text = @"总单号";
        _label_allOrder.textAlignment = NSTextAlignmentCenter;
        _label_allOrder.font = [UIFont systemFontOfSize:14];
    }
    return _label_allOrder;
}
-(UILabel *)label_daiLi{
    if (!_label_daiLi) {
        _label_daiLi = [UILabel new];
        _label_daiLi.text = @"代理";
        _label_daiLi.textAlignment = NSTextAlignmentCenter;
        _label_daiLi.font = [UIFont systemFontOfSize:14];
    }
    return _label_daiLi;
}
@end
