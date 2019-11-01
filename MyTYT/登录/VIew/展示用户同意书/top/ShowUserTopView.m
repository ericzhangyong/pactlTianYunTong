//
//  ShowUserTopView.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowUserTopView.h"
#import "Masonry.h"

@implementation ShowUserTopView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.lable];
        self.backgroundColor = [UIColor whiteColor];

        [self layout];
    }
    return self;
}

- (void)layout{
    
    [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UILabel *)lable{
    if (!_lable) {
        _lable = [[UILabel alloc] init];
        _lable.font = [UIFont boldSystemFontOfSize:26];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.textColor = [UIColor blackColor];
    }
    return _lable;
}

@end
