//
//  PickBootomView.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "PickBootomView.h"
#import "Masonry.h"
@implementation PickBootomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:self.lookBtn];
        [self addSubview:self.completeBtn];
        [self addSubview:self.topView];

        [self layout];
    }
    return self;
}

- (void)layout{
    [_lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
//        make.width.greaterThanOrEqualTo(@50);
    }];
    
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.bottom.mas_equalTo(self.lookBtn);
        make.width.greaterThanOrEqualTo(@60);

    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIButton *)lookBtn{
    if (!_lookBtn) {
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _lookBtn.backgroundColor = [UIColor clearColor];
    }
    return _lookBtn;
}

- (UIButton *)completeBtn{
    if (!_completeBtn) {
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completeBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:185/255.0 blue:26/255.0 alpha:1]];
        
        [_completeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _completeBtn.layer.masksToBounds = YES;
        _completeBtn.layer.cornerRadius = 3;
    }
    return _completeBtn;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor darkGrayColor];
        _topView.alpha = 0.5;
    }
    return _topView;
}
@end
