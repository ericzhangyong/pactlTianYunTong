//
//  ControlTop.m
//  MyTYT
//
//  Created by Fly on 2018/8/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ControlTop.h"

@interface ControlTop ()

@end

@implementation ControlTop

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLable];
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLable.frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height-20);
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"布控提示";
        _titleLable.font = [UIFont boldSystemFontOfSize:20];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor whiteColor];
    }
    return _titleLable;
}

@end
