//
//  SelectCheckTypeView.h
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SelectCheckType) {
    twenty_fourHourCheck,//24小时安检
    FirstCheck,//首检
    Check9610//9610
};

typedef void(^CheckTypeBlock)(SelectCheckType checkType);

@interface SelectCheckTypeView : UIView

+ (void)showSelectType:(CheckTypeBlock)block;

@end
