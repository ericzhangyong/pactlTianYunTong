//
//  LoadDataFailView.m
//  HWCBZT
//
//  Created by Fly on 2017/9/28.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import "LoadDataFailView.h"

@implementation LoadDataFailView

+ (void)ShowLoadFailViewWith:(UIView *)superView frame:(CGRect)frame clickBtn:(LoadFailViewBlcok)block{
    
    [LoadDataFailView removefromViewWith:superView];
    
    LoadDataFailView *failview = [[LoadDataFailView alloc] initWithFrame:frame];
    
    failview.myblock = block;
    
    [superView addSubview:failview];
    
}

+ (void)removefromViewWith:(UIView *)superView{
    
    for (UIView *view in superView.subviews) {
        if ([view isKindOfClass:[LoadDataFailView class]]) {
            [view removeFromSuperview];
        }
    }
}
//点击按钮
- (void)BtnEvent{
    [self removeFromSuperview];
    self.myblock();
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        [self addSubview:self.imageview];
        [self addSubview:self.lable];
        [self addSubview:self.btn];
    }
    return self;
}

- (UILabel *)lable{
    if (!_lable) {
        _lable = [[UILabel alloc] init];
        _lable.text = @"数据加载失败";
        _lable.textColor = [UIColor grayColor];
        _lable.frame = CGRectMake(0, CGRectGetMinY(self.imageview.frame)-40-30, self.frame.size.width, 30);
        _lable.textAlignment = NSTextAlignmentCenter;
    }
    return _lable;
}

- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo"]];
        _imageview.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-80)/2, ([UIScreen mainScreen].bounds.size.height-80)/2, 80, 80);
        _imageview.center = self.center;
    }
    return _imageview;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor clearColor];
        [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btn setTitle:@"重新加载" forState:UIControlStateNormal];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 10;
        _btn.layer.borderWidth = 0.6;
        _btn.layer.borderColor = [UIColor redColor].CGColor;
        _btn.frame = CGRectMake((self.frame.size.width-140)/2, CGRectGetMaxY(self.imageview.frame)+40, 140, 50);
        
        [_btn addTarget:self action:@selector(BtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)dealloc{
    FlyLog(@"加载失败--Delloc");
}
@end
