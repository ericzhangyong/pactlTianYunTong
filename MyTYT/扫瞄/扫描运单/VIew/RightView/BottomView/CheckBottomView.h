//
//  AddBZBottomView.h
//  MyTYT
//
//  Created by zhangyong on 2019/11/1.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckBottomView : UIView



/// 1.不合格 2.暂扣 3.通过 4.备注
@property (nonatomic,copy) void(^bottomClickBlock)(NSInteger clickType);
@end

NS_ASSUME_NONNULL_END
