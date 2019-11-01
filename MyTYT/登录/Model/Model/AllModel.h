//
//  AllModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginModel;
@class DeviceModel;
@class ProtocolModel;
@class PerssionModel;
@class AJModel;

@class LastLoginTimeModel;
@class OperationMachinModel;
@class TestModel;
@class TwentyForuHourRoadModel;
@class TwentyMachineAllModel;

@interface AllModel : NSObject

@property (nonatomic) LoginModel *loginmdoel;

@property (nonatomic) DeviceModel *deviceModel;

@property (nonatomic) ProtocolModel *protocolModel;

@property (nonatomic) PerssionModel *perssioModel;

@property (nonatomic) AJModel *ajModel;


@property (nonatomic) LastLoginTimeModel *lasttimeModel;

@property (nonatomic) OperationMachinModel *operationModel;

@property (nonatomic) TestModel *textModel;

@property (nonatomic) TwentyForuHourRoadModel *RoadModel;

@property (nonatomic) TwentyMachineAllModel *machineAllModel;

@end
