//
//  ShowPIcView.m
//  HWZYBZT
//
//  Created by 张飞飞 on 2017/5/22.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import "ShowPIcView.h"
#import "FlyScrollerView.h"

@interface ShowPIcView ()<FlyPhotoScrollerViewDelegate>

@property (nonatomic) FlyScrollerView *scrollerview;

@property (nonatomic) UIImage *image;

@property (nonatomic,assign) CGRect beforeFrame;

@property (nonatomic,assign) CGRect afterFrame;

@end

@implementation ShowPIcView

+ (void)showPic:(UIImage *)image beforeFrame:(CGRect)frame afterFrame:(CGRect)afterframe{
    
    ShowPIcView *showpic = [[ShowPIcView alloc] init];
    
    showpic.image = image;
    
    showpic.beforeFrame = frame;
    
    showpic.afterFrame = afterframe;
    
    [showpic showMiandanPic];
}

//添加到window上
- (void)showMiandanPic{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.frame = window.bounds;
    
    self.backgroundColor = [UIColor blackColor];
    
    [window addSubview:self];
    
    [self setupUI];
    
}

- (void)setupUI{
    
    [self addSubview:self.scrollerview];
    self.scrollerview.hidden = YES;
    
    [self showimage];
}

- (void)showimage{
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:self.image];
    
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    tempImageView.clipsToBounds = YES;

    tempImageView.frame = self.beforeFrame;

    FlyLog(@"---%@--",NSStringFromCGRect(self.beforeFrame));
    [self addSubview:tempImageView];
    

    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        tempImageView.frame = self.afterFrame;

    } completion:^(BOOL finished) {
        [tempImageView removeFromSuperview];
        self.scrollerview.hidden =NO;
        [self.scrollerview setPhotoImageviewWithImage:self.image afterframe:self.afterFrame];
    }];
    
}

- (FlyScrollerView *)scrollerview{
    if (!_scrollerview) {
        CGRect rect = self.bounds;
        _scrollerview = [[FlyScrollerView alloc] initWithFrame:rect];
        _scrollerview.contentSize = CGSizeMake(kuan, 0);
        _scrollerview.flyphotodelegate =self;
    }
    return _scrollerview;
}



- (void)singleTap:(FlyScrollerView *)scrollerview tapGesture:(UITapGestureRecognizer *)tap{
    UIImageView *tempview = [[UIImageView alloc] initWithImage:scrollerview.photoimageView.image];
    tempview.contentMode = UIViewContentModeScaleAspectFit;
    tempview.clipsToBounds = YES;

    tempview.frame = self.afterFrame;
    [self addSubview:tempview];
    
       
    self.scrollerview.hidden =YES;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        tempview.frame =self.beforeFrame;
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor clearColor];
        [self removeFromSuperview];
    }];
   
    
}


- (void)dealloc{
    FlyLog(@"图片展示delloc");
}
@end
