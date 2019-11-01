//
//  WayBillModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WayBillModel : NSObject

//分单主键
@property (nonatomic) NSString *awId;
//分单号
@property (nonatomic) NSString *waybill_no;
//分单拉下标记
@property (nonatomic) NSString *ref_status;
//电子运单
@property (nonatomic) NSString *wb_ele;
//件数
@property (nonatomic) NSNumber *total_count;
//重量
@property (nonatomic) NSNumber *gross_weight;

//目的港
@property (nonatomic) NSString *dest1;
//品名
@property (nonatomic) NSString *goods_desc;
//ELI
@property (nonatomic) NSString *eli_flag;
//ELM
@property (nonatomic) NSString *elm_flag;
//备注数量
@property (nonatomic) NSString *count_remark;

/// 中文品名
@property (nonatomic,copy) NSString *goods_name_cn;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
