//
//  ShowMachineRoadVC.h
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RoadModel;
@class TwentyMachineModel;

typedef NS_ENUM(NSInteger,ShowType) {
    SHOWRoad,//展示24小时通道
    SHOWMAChine,//展示安检机
};

typedef void(^ShowBlock)(NSArray *array);

@interface ShowMachineRoadVC : UIViewController

@property (nonatomic) NSMutableArray *dataArray;

@property (nonatomic,copy) ShowBlock block;

@property (nonatomic,assign) ShowType type;

@property (nonatomic) RoadModel *roadModel;

@property (nonatomic) TwentyMachineModel *machIneModel;

@end
