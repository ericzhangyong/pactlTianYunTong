//
//  InputHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "InputHeadView.h"
#import "Masonry.h"

@implementation InputHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        
        [self layout];
    }
    return self;
}

- (void)creatUI{
    
//    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titlelable];
//    [self addSubview:self.subtitlelable];
}

- (void)layout{
 
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
//    [_subtitlelable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titlelable.mas_bottom);
//        make.centerX.equalTo(self);
//        make.bottom.equalTo(self).offset(-15);
//    }];
}

- (UILabel *)titlelable{
    if (!_titlelable) {
        _titlelable = [[UILabel alloc] init];
        _titlelable.font = [UIFont boldSystemFontOfSize:30];
        _titlelable.textColor = [UIColor blackColor];
        _titlelable.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelable;
    
}

- (UILabel *)subtitlelable{
    if (!_subtitlelable) {
        _subtitlelable = [[UILabel alloc] init];
        _subtitlelable.textColor =[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
        _subtitlelable.textAlignment = NSTextAlignmentCenter;
        [_subtitlelable setFont:[UIFont systemFontOfSize:17]];
    }
    return _subtitlelable;
}

@end
