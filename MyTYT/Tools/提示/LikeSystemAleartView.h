//
//  LikeSystemAleartView.h
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSuccessBlock)(void);
typedef void(^ClickCancelBlock)(void);


@interface LikeSystemAleartView : UIView

+ (instancetype)showViewWithTitle:(NSString *)title
                         subtitle:(NSString *)subtitle
                        sureTitle:(NSString *)suretitle
                          success:(ClickSuccessBlock)success
                           cancel:(ClickCancelBlock)cancel;

@end
