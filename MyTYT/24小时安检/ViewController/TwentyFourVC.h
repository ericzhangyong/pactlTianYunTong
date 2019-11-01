//
//  TwentyFourVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BaseVC.h"

typedef NS_ENUM(NSInteger,TwentyDataType) {
    TwentyFreshOnly,//点击保存没有数据时仅用做刷新
    TwentyFreshSave,//点击保存，成功后，更新数据时刷新
    TwentyFreshChengAgent,//改变代理时刷新数据
    TwentyFreshDelete,//删除运单成功后刷新列表
    twentyBtnFresh,//刷新按钮
    TwentySaveMsgFresh//保存出现msg也要刷新列表
};

@class AllModel;

@interface TwentyFourVC : BaseVC

@property (nonatomic) AllModel *allmodel;

@end
