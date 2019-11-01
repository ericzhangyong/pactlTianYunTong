//
//  DetailModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class infoModel;
@class DeatilTstModel;
@class WayBillModel;

@interface DetailModel : NSObject

@property (nonatomic,assign) NSInteger ok;

@property (nonatomic) NSString *msg;

//代表信息详情备注数量
@property (nonatomic,assign) NSInteger count;

//代理中文
@property (nonatomic) NSString *agentShortName;

//总单信息
@property (nonatomic) infoModel*infomdel;

//测试模型
@property (nonatomic) DeatilTstModel *testModel;

//所有证书
@property (nonatomic) NSArray *bookArray;

//可用证书
@property (nonatomic) NSArray *canUseBookArray;

//分单
@property (nonatomic) NSArray<WayBillModel *> *waybillArray;

//分单总计数组
@property (nonatomic) NSArray *wayAllArray;

//安检
@property (nonatomic) NSArray *checkArray;

//安检布控
@property (nonatomic,assign) BOOL iscontrol;

//安保布控
@property (nonatomic,assign) BOOL isABcontrol;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
