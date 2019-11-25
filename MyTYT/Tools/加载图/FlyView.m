//
//  FlyView.m
//  等带指示器
//
//  Created by ma c on 16/3/2.
//  Copyright © 2016年 666科技. All rights reserved.
//

#import "FlyView.h"

@interface FlyView ()

@property (strong,nonatomic)UIImageView *imageivew;

@property (strong,nonatomic)UILabel *lable;

@property (nonatomic) UIActivityIndicatorView *activityview;

@end

@implementation FlyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
       
       
//        [self addSubview:self.imageivew];
//        [self addSubview:self.lable];
    }
    return self;
}


+(void)removeFlyViewFromSuperView:(UIView*)superView
{
    
//    sleep(1);
    for (UIView*itemview in superView.subviews) {
        //如果某个子视图是flyview
        if ([itemview isKindOfClass:[FlyView class]]) {
            FlyView *view = (FlyView *)itemview;
//            [view.newactivityview stopAnimating];
            [view.activityview stopAnimating];
            [UIView animateWithDuration:0.1 animations:^{
                view.alpha = 0;

            } completion:^(BOOL finished) {
                [view.activityview removeFromSuperview];
//                [view.newactivityview removeFromSuperview];
                [view removeFromSuperview];
                
            }];
            
        }
    }
    
}
//要把loading界面加载到那个界面上(具体位置多少)

+(void)showFlyViewFromSuperView:(UIView*)superView{
    
    [self removeFlyViewFromSuperView:superView];
    
    FlyView *loadingView = [[FlyView alloc] init];
    
    
    [superView addSubview:loadingView];

    loadingView.frame = CGRectMake(0, -32, superView.frame.size.width, superView.frame.size.height+32);
    
    loadingView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];

    [loadingView addSubview:loadingView.activityview];
    

    
    //让动态图加载起来
    [loadingView.activityview startAnimating];
    

    
    
    
}


#pragma mark-获取图片数组
- (NSArray*)getimagearray
{
    NSMutableArray *imagearray = [NSMutableArray array];
    for (int i=1; i<16; i++) {
        NSString *imagename;
        imagename = [NSString stringWithFormat:@"loading_animate_%02d",i];
        UIImage *image = [UIImage imageNamed:imagename];
        [imagearray addObject:image];
    }

    return imagearray;
}

#pragma mark-懒加载
//- (DGActivityIndicatorView *)newactivityview{
//    if (!_newactivityview) {
//        _newactivityview = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotateMultiple tintColor:[UIColor colorWithRed:0.789 green:0.461 blue:0.321 alpha:1.00]];
//        _newactivityview.frame =CGRectMake(0, 0, kuan/6, kuan/6);
//        _newactivityview.center = self.center;
//    }
//    return _newactivityview;
//}
- (UIActivityIndicatorView *)activityview{
    if (!_activityview) {
        _activityview = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _activityview.center = self.center;
        _activityview.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _activityview;
}

- (UIImageView*)imageivew
{
    if (!_imageivew) {
        _imageivew = [[UIImageView alloc] init];
        _imageivew.frame = CGRectMake(0, 0, 80, 80);
        _imageivew.center = self.center;
        _imageivew.animationImages = [self getimagearray];
        _imageivew.animationDuration = 0;
    }
    return _imageivew;
}

- (UILabel*)lable
{
    if (!_lable) {
        _lable = [[UILabel alloc] init];
        _lable.frame = CGRectMake(3, 85, 80, 25);
        _lable.text = @"客官稍等";
        
    }
    return _lable;
}

- (void)dealloc{
    FlyLog(@"加载图delloc");
}

@end
