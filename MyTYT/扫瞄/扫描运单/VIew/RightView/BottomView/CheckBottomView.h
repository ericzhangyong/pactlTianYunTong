//
//  AddBZBottomView.h
//  MyTYT
//
//  Created by zhangyong on 2019/11/1.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//通过pass 不合格 unqualified   暂扣 hold
#define pass @"pass"
#define unqualified @"unqualified"
#define hold @"hold"


@interface CheckBottomView : UIView



/// 1.不合格 2.暂扣 3.通过 4.备注
@property (nonatomic,copy) void(^bottomClickBlock)(NSInteger clickType);

///通过pass 不合格 unqualified   暂扣 hold
@property (nonatomic,copy) NSString *refResult;

@property (nonatomic,copy) NSString *count_remark;

@end

NS_ASSUME_NONNULL_END
