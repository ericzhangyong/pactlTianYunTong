//
//  infoModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface infoModel : NSObject


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
//品名
@property (nonatomic) NSString *goodsDesc;
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



- (instancetype)initWithDic:(NSDictionary *)dic;

@end


