//
//  MYTimer.h
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeviceModel;

typedef NS_ENUM(NSInteger,LeaveType) {
    DeadTimeLine,//30分钟到期退出
    NormalLeadVe,//正常点击退出
    TokenInValid//token失效
};


typedef NS_ENUM(NSInteger,ComingType) {
    FirstNeedNotificationType,//首检
    TwentyType//24小时
};

@interface MYTimer : NSObject

+ (instancetype)shareINstace;

@property (nonatomic) DeviceModel *deviceModel;

//开始计时
- (void)startTimerWithType:(ComingType)type;

//结束及时
- (void)endTimeWithType:(LeaveType)type;

@end
