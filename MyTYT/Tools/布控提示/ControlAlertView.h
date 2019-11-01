//
//  ControlAlertView.h
//  MyTYT
//
//  Created by Fly on 2018/8/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ControlType) {
    OnlySureBtn,//只有确定
    AllBtn,//取消，确定
};

typedef void(^ControlSureBlock)(void);

typedef void(^ControlCanCelBlock)(void);


@interface ControlAlertView : UIView

@property (nonatomic,assign) ControlType type;

+ (void)showControlAleratViewWithArray:(NSArray *)dataArray
                                  type:(ControlType)type
                              toptitle:(NSString *)topTitle
                           bottomTitle:(NSString *)bottomTitle
                                  sure:(ControlSureBlock)sure
                                cancel:(ControlCanCelBlock)cancel;

@end
