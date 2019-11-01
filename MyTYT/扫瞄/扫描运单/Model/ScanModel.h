//
//  ScanModel.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanModel : NSObject<NSCoding>


//代理简称
@property (nonatomic) NSString *agentShortName;
//运单号
@property (nonatomic) NSString *waybillno;
//航班
@property (nonatomic) NSString *flightNo;
//航班时间
@property (nonatomic) NSString *fltDate;
//目的港
@property (nonatomic) NSString *airportDest;
//代理
@property (nonatomic) NSString *agentOprn;
//件数
@property (nonatomic) NSString *rcpNo;
//重量
@property (nonatomic) NSString *grossWeight;
//计费重量
@property (nonatomic) NSString *chargeWeight;
//体积
@property (nonatomic) NSString *vol;
//品名
@property (nonatomic) NSString *goodsDesc;

//电子运单
@property (nonatomic) NSString *Ele;

//标记
@property (nonatomic) NSString *eliFlag;
//标记
@property (nonatomic) NSString *elmFlag;

//特火代码
@property (nonatomic) NSString *holdCode;
//发货人
@property (nonatomic) NSString *spName;
//收货人
@property (nonatomic) NSString *csName;
//状态 <0不可安检 1可安检>
@property (nonatomic) NSString *isCheck;

//状态msg
@property (nonatomic) NSString *msg;

/*****************************************************/

//安检布控
@property (nonatomic,assign) BOOL iscontrol;

//安保布控
@property (nonatomic,assign) BOOL isABControl;

@property (nonatomic) NSArray *historyArray;

/*****************************************************/


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
