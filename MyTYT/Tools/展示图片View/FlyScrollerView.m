//
//  FlyScrollerView.m
//  HWZYBZT
//
//  Created by 张飞飞 on 2017/5/22.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import "FlyScrollerView.h"

@implementation FlyScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate =self;
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 2;
        self.zoomScale =1;
        [self setupUI];
        [self addgesture];
    }
    return self;
}

- (void)addgesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *doubleges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleges.numberOfTapsRequired = 2;
    [tap requireGestureRecognizerToFail:doubleges];
    [self addGestureRecognizer:doubleges];
}

- (void)singleTap:(UITapGestureRecognizer *)Tap{
    if ([_flyphotodelegate respondsToSelector:@selector(singleTap:tapGesture:)]) {
        [_flyphotodelegate singleTap:self tapGesture:Tap];
    }
}

- (void)doubleTap:(UITapGestureRecognizer *)doubleGes{
    
    CGPoint touchpoint = [doubleGes locationInView:doubleGes.view];
    NSInteger scale ;
    
    if (self.zoomScale>self.minimumZoomScale) {
        scale = self.minimumZoomScale;
    }else{
        scale = self.maximumZoomScale;
    }
    
    //
    CGFloat touchX = touchpoint.x;
    CGFloat touchY = touchpoint.y;
    touchX *= 1/self.zoomScale;
    touchY *= 1/self.zoomScale;
    touchX += self.contentOffset.x;
    touchY += self.contentOffset.y;
    
    
    [self zoomWithScale:scale centerPoint:CGPointMake(touchX, touchY)];
}

- (void)zoomWithScale:(CGFloat)scale centerPoint:(CGPoint)center{
    
    CGFloat width = self.frame.size.width/scale;
    CGFloat height = self.frame.size.height/scale;
    
    CGFloat x = center.x-width*0.5;
    CGFloat y = center.y -height*0.5;
    
    CGRect rect = CGRectMake(x, y , width, height);
    [self zoomToRect:rect animated:YES];
    
}

- (void)setupUI{
    
    [self addSubview:self.photoimageView];
}

- (UIImageView *)photoimageView{
    if (!_photoimageView) {
        _photoimageView = [[UIImageView alloc] init];
        _photoimageView.backgroundColor = [UIColor clearColor];
        _photoimageView.contentMode = UIViewContentModeScaleAspectFit;
        _photoimageView.clipsToBounds = YES;
    }
    return _photoimageView;
}
- (void)setPhotoImageviewWithImage:(UIImage *)image afterframe:(CGRect)afterframe{
    
    self.photoimageView.image = image;
   
    self.photoimageView.frame = afterframe;
    self.contentSize = self.photoimageView.frame.size;
}


#pragma mark------------------------------------------------------------------------------------
//解决缩放比例图片的中心点始终在屏幕中心问题
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect oldFrame = self.photoimageView.frame ;
    CGSize size = self.bounds.size;
    
    if (oldFrame.size.height<size.height) {//y
        oldFrame.origin.y = floorf((size.height-oldFrame.size.height)/2);
    }else{
        oldFrame.origin.y = 0;
    }
    
    if (oldFrame.size.width<size.width) {//x
        oldFrame.origin.x = floorf((size.width-oldFrame.size.width)/2);
    }else{
        oldFrame.origin.x = 0;
    }
    
    self.photoimageView.frame = oldFrame;
    

    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self setNeedsLayout];
    
    [self layoutIfNeeded];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.photoimageView;
}


- (void)dealloc{
    FlyLog(@"flyscollerview-----delloc");
}
@end
