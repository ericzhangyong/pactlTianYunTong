//
//  FlyScrollerView.h
//  HWZYBZT
//
//  Created by 张飞飞 on 2017/5/22.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlyScrollerView;
@protocol FlyPhotoScrollerViewDelegate <NSObject>

- (void)singleTap:(FlyScrollerView *)scrollerview tapGesture:(UITapGestureRecognizer *)tap;

@end

@interface FlyScrollerView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic) UIImageView *photoimageView;

@property (nonatomic, weak) id<FlyPhotoScrollerViewDelegate>flyphotodelegate;

- (void)setPhotoImageviewWithImage:(UIImage *)image afterframe:(CGRect)afterframe;
@end
