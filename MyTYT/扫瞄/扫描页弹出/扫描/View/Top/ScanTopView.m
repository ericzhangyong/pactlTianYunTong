//
//  ScanTopView.m
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanTopView.h"


@implementation ScanTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.maskView];
        [self addSubview:self.imageview];
    }
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.maskView.frame = self.bounds;
    
    self.imageview.frame = self.ImageRect;
    
    [self addShapeLayer];
    
}

- (void)addShapeLayer{
    
    CAShapeLayer *shaper = [CAShapeLayer layer];
    
    shaper.path = [self creatBesiPath].CGPath;
    
    self.maskView.layer.mask = shaper;
    
}

- (UIBezierPath *)creatBesiPath{
    
    UIBezierPath *besi = [UIBezierPath bezierPathWithRect:self.bounds];
    
    [besi appendPath:[[UIBezierPath bezierPathWithRoundedRect:self.ImageRect cornerRadius:15] bezierPathByReversingPath]];
    
    return besi;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    return _maskView;
}

- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] init];
        _imageview.layer.cornerRadius = 15;
        _imageview.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageview.layer.borderWidth = 1;
    }
    return _imageview;
}

- (CGRect)ImageRect{
    return CGRectMake(self.bounds.size.width *0.1, self.bounds.size.height*0.15, self.bounds.size.width*0.8, self.bounds.size.height*0.7);
}

@end
