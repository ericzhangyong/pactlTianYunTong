//
//  twentyAletartView.h
//  MyTYT
//
//  Created by Fly on 2018/7/3.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TwentyAleartSuccessBlock)(void);

@interface twentyAletartView : UIView

+ (instancetype)showViewWithTitle:(NSString *)title subtitle:(NSString *)subtitle success:(TwentyAleartSuccessBlock)success;

@end
