//
//  NewBZModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewBZModel : NSObject

//运单号
@property (nonatomic) NSString *waybill_no;

//品名
@property (nonatomic) NSString *goods_desc;


//0时显示证书以及证书添加信息
@property (nonatomic) NSString *type;

//备注个数==0显示没有备注
@property (nonatomic) NSString *count_remark;

//电子运单1为电子运单
@property (nonatomic) NSString *wb_ele;

//证书数组
@property (nonatomic) NSArray *ZSArray;

//可用证书数组<证书类型是book 证书可显示即为可用证书>
@property (nonatomic) NSArray *CanUseCerArray;

//运单主键
@property (nonatomic) NSString *awId;
//ELI
@property (nonatomic) NSString *eli_flag;
//ELM
@property (nonatomic) NSString *elm_flag;

/*
//证书类型==book为证书
@property (nonatomic) NSString *bookCheckType;

//等于1显示证书
@property (nonatomic) NSString *checkVisual;

//等于1显示删除
@property (nonatomic) NSString *deviceId;

*/

- (instancetype)initWIthDic:(NSDictionary *)dic;

@end
