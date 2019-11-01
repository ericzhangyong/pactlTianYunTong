//
//  TwentyLocalInfoModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoadModel;
@class TwentyMachineModel;

@interface TwentyLocalInfoModel : NSObject

/*
 本地24小时通道模型
 */
@property (nonatomic) RoadModel *roadModel;

/*
 本地安检机模型
 */
@property (nonatomic) TwentyMachineModel *machineModel;

/*
 本地通道货物数量
 */
@property (nonatomic) NSString *aislecount;

/*
 本地24小时待过安检机
 */
@property (nonatomic) NSString *machine24;

@end
