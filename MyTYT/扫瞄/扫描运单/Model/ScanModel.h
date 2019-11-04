//
//  ScanModel.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class ScanBillModel;

@interface ScanModel : BaseModel<NSCoding>


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


///子单信息
@property (nonatomic,copy) NSDictionary *subWaybill;

/// 总单信息
@property (nonatomic,copy) NSDictionary *waybill;
/// 证书信息
@property (nonatomic,copy) NSArray *books;


- (instancetype)initWithDic:(NSDictionary *)dic;


@end

@interface ScanBillModel : BaseModel
// 总单
@property (nonatomic,copy) ScanModel *waybill;

/// 子单
@property (nonatomic,copy) ScanModel *subWaybill;

/// 证书信息
@property (nonatomic,copy) NSArray *books;

@end


@interface ScanBillSubModel:BaseModel

/// type:1 子单
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,copy) NSString *awId;
/// 代理
@property (nonatomic,copy) NSString *agent_oprn;
/// 代理id
@property (nonatomic,copy) NSString *agent_oprn_id;
/// 销售代理
@property (nonatomic,copy) NSString *agent_sales;
/// 单号
@property (nonatomic,copy) NSString *waybill_no;
/// 目的港口
@property (nonatomic,copy) NSString *dest1;
@property (nonatomic,copy) NSString *total_count;
///毛重
@property (nonatomic,copy) NSString *gross_weight;
///毛重
@property (nonatomic,copy) NSString *goods_desc;
///是否电子运单0:不是 1 是
@property (nonatomic,copy) NSString *wb_ele;
///ref_status
@property (nonatomic,copy) NSString *ref_status;
///主单id
@property (nonatomic,copy) NSString *parent_no;


@end
