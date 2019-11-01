//
//  ControlTwobtnView.m
//  MyTYT
//
//  Created by Fly on 2018/10/8.
//  Copyright © 2018 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ControlTwobtnView.h"

@interface ControlTwobtnView ()

@property (nonatomic) UILabel *lineLable;

@property (nonatomic) UILabel *line;

@end

@implementation ControlTwobtnView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.sureBtn];
        [self addSubview:self.cancelbtn];
        [self addSubview:self.lineLable];
//        [self addSubview:self.line];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat Width = self.frame.size.width;
    
    CGFloat Height = self.frame.size.height;
    
    CGFloat LineWidth = 1;
    
//    self.line.frame = CGRectMake(0, 0, Width, 1);
    
    self.cancelbtn.frame = CGRectMake(0, 0,(Width - LineWidth)*0.5,Height);
    
    self.lineLable.frame = CGRectMake((Width - LineWidth)*0.5, 0, LineWidth, Height);
    
    self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.lineLable.frame), 0, (Width - LineWidth)*0.5, Height);
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00] forState:UIControlStateNormal];
        
    }
    return _sureBtn;
}

- (UIButton *)cancelbtn{
    if (!_cancelbtn) {
        _cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancelbtn;
}

- (UILabel *)lineLable{
    if (!_lineLable) {
        _lineLable = [[UILabel alloc] init];
        _lineLable.backgroundColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.925 alpha:1.00];
    }
    return _lineLable;
}

- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.925 alpha:1.00];
    }
    return _line;
}

@end
