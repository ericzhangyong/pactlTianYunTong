//
//  FirstVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BaseVC.h"

@class AllModel;

typedef NS_ENUM(NSInteger,FirstFreshDataType) {
    FirstFreshOnly,//点击保存没有数据时仅用做刷新
    FirstFreshSave,//点击保存，成功后，更新数据时刷新
    FirsgFreshChengAgent,//改变代理时刷新数据
    FirstFreshDelete,//删除运单成功后刷新列表
    FirstBtnFresh,//刷新按钮
};



@interface FirstVC : BaseVC


@property (nonatomic) AllModel *allmodel;

/// 检测类型
@property (nonatomic,assign) DetectionType detectionType;

@end
