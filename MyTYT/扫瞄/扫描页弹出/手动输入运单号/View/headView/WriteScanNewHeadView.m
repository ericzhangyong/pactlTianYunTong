//
//  WriteScanNewHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "WriteScanNewHeadView.h"
#import "Masonry.h"

@implementation WriteScanNewHeadView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self creatUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self layout];
}
- (void)creatUI{
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titlelable];
    [self addSubview:self.bootomLine];
    [self addSubview:self.topline];
    [self addSubview:self.YDH];
    [self addSubview:self.textfiled];
}

- (void)layout{
    
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
    
    [_topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlelable.mas_bottom).offset(30);
        make.left.right.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
    [_bootomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topline.mas_bottom).offset(80);
        make.height.equalTo(self.topline);
        make.bottom.lessThanOrEqualTo(self.mas_bottom);
    }];
    
    [_YDH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topline.mas_bottom);
        make.bottom.equalTo(self.bootomLine.mas_top);
        make.left.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [_textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.YDH.mas_right);
        make.right.equalTo(self);
        make.top.bottom.equalTo(self.YDH);
    }];
    
    
    
}

- (UILabel *)topline{
    if (!_topline) {
        _topline = [[UILabel alloc] init];
        _topline.backgroundColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00];
    }
    return _topline;
}

- (UILabel *)bootomLine{
    if (!_bootomLine) {
        _bootomLine = [[UILabel alloc] init];
        _bootomLine.backgroundColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00];
    }
    return _bootomLine;
}

- (UILabel *)YDH{
    if (!_YDH) {
        _YDH = [[UILabel alloc] init];
        _YDH.textAlignment = NSTextAlignmentCenter;
        _YDH.font = [UIFont boldSystemFontOfSize:18];
        _YDH.text = @"运单号";
    }
    return _YDH;
}

- (UITextField *)textfiled{
    if (!_textfiled) {
        _textfiled = [[UITextField alloc] init];
        _textfiled.placeholder = @"必填";
        _textfiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textfiled;
}
- (UILabel *)titlelable{
    if (!_titlelable) {
        _titlelable = [[UILabel alloc] init];
        _titlelable.font = [UIFont boldSystemFontOfSize:30];
        _titlelable.textColor = [UIColor blackColor];
        _titlelable.textAlignment = NSTextAlignmentCenter;
        _titlelable.text = @"手动输入运单号";
    }
    return _titlelable;
    
}

@end
