//
//  ExplainHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ExplainHeadView.h"
#import "Masonry.h"

@implementation ExplainHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = NavColor;
        
        [self creaUI];
        
        [self layout];
    }
    return self;
}

- (void)creaUI{
    [self addSubview:self.roadname];
    
    [self addSubview:self.roadremark];
}

- (void)layout{
    
    [_roadname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.3);
        
    }];
    
    [_roadremark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.roadname.mas_right);
    }];
}

- (UILabel *)roadname{
    if (!_roadname) {
        _roadname = [[UILabel alloc] init];
        _roadname.text = @"24小时通道";
        _roadname.textColor = [UIColor whiteColor];
        _roadname.textAlignment = NSTextAlignmentCenter;

        
    }
    return _roadname;
}

- (UILabel *)roadremark{
    if (!_roadremark) {
        _roadremark = [[UILabel alloc] init];
        _roadremark.text = @"具体位置";
        _roadremark.textColor = [UIColor whiteColor];
        _roadremark.textAlignment = NSTextAlignmentCenter;

    }
    return _roadremark;
}

@end
