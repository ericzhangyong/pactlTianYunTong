//
//  YDDetailVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstModel;
@class OperationMachinModel;
@class DeviceModel;


@interface YDDetailVC : UIViewController

//进入类型
@property (nonatomic,assign) DetectionType type;

//运单主键
@property (nonatomic) NSString *aWID;

//测字
@property (nonatomic) NSString *testWord;

//用于 备注
@property (nonatomic) OperationMachinModel *opeationModel;

//用于 备注 24小时加载数据
@property (nonatomic) DeviceModel *deviceModel;

@end
