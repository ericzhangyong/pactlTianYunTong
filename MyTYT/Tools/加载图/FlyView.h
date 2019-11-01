//
//  FlyView.h
//  等带指示器
//
//  Created by ma c on 16/3/2.
//  Copyright © 2016年 666科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlyView : UIView

+(void)removeFlyViewFromSuperView:(UIView*)superView;

//要把loading界面加载到哪个界面上
+(void)showFlyViewFromSuperView:(UIView*)superView;


@end
