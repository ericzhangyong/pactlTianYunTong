//
//  ShutBottomView.m
//  MyTYT
//
//  Created by Fly on 2018/6/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShutBottomView.h"
#import "Masonry.h"

@implementation ShutBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatUI];
        
        [self layout];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)creatUI{
    [self addSubview:self.surebtn];
}

- (void)layout{
    [_surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(50);
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-20);
        make.right.equalTo(self).offset(-50);
    }];
    

}


- (UIButton *)surebtn{
    if (!_surebtn) {
        _surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surebtn.layer.masksToBounds = YES;
        _surebtn.layer.cornerRadius = 5;
        _surebtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00];
        [_surebtn setTitle:@"确定" forState:UIControlStateNormal];
        [_surebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [_surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _surebtn;
}


@end
