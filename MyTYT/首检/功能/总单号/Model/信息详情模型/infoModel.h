//
//  infoModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface infoModel : BaseModel


//运单主键
@property (nonatomic) NSString *awId;

/**************heda所需************/
//运单号
@property (nonatomic) NSString *waybillNo;
//电子运单
@property (nonatomic) NSString *wbEle;

//操作代理
@property (nonatomic) NSString *agentOprn;
/**************************/

//航班
@property (nonatomic) NSString *flightNo;
//日期
@property (nonatomic) NSString *fltDate;
//发货人
@property (nonatomic) NSString *spName;
//收货人
@property (nonatomic) NSString *csName;
//目的港
@property (nonatomic) NSString *airportDest;
//品名（9610中文品名 其他是英文品名）
@property (nonatomic) NSString *goodsDesc;
//中文品名
@property (nonatomic) NSString *goodsNameCn;

//ELI
@property (nonatomic) NSString *eliFlag;
//ELM
@property (nonatomic) NSString *elmFlag;
//特或代码
@property (nonatomic) NSString *holdCode;
//SSR
@property (nonatomic) NSString *ssr;
//OSI
@property (nonatomic) NSString *osi1;

//件数
@property (nonatomic) NSNumber *rcpNo;
//重量
@property (nonatomic) NSNumber *grossWeight;
//计费重量
@property (nonatomic) NSNumber *chargeWeight;
//体积
@property (nonatomic) NSNumber *vol;

/// 控字的背景颜色
@property (nonatomic,copy) NSString *securityCheckResultColor;
/// 控字的
@property (nonatomic,copy) NSString *securityCheckResult;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end


