//
//  Controlbootom.m
//  MyTYT
//
//  Created by Fly on 2018/8/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "Controlbootom.h"

@interface Controlbootom ()

@end

@implementation Controlbootom

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.btn];
        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.btn.frame = self.bounds;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"确定" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _btn;
}

@end
