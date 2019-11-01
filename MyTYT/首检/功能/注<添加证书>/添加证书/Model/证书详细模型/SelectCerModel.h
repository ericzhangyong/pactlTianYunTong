//
//  SelectCerModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectCerModel : NSObject

/****************************错误信息有可能不返回*************************************/
/*
 100 证书已停用请重新选择证书
 102 证书已过期请重新选择证书
 105 显示retunreson
 
 错误状态<不一定返回>
 */
@property (nonatomic) NSString *returnStatus;

//错误原因<不一定返回>
@property (nonatomic) NSString *returnReason;

/**************************************证书信某些息有可能不返回*********************************/

//证书类型<不一定返回> 设为sharing
@property (nonatomic) NSString *booktype;

//运单证书ID <服务器不一定返回> 不返回值为nil 上传时此字段都不要上传
@property (nonatomic) NSString *ID;

/*****************************************不从服务器解析**********************************************/

//构造好<保存证书时必须传book，所以默认构造好>
@property (nonatomic) NSString *bookCheckType;

//设备ID<保存证书时必须传”1“，所以默认构造好>
@property (nonatomic) NSString *deviceID;

/****************************************鉴定机构信息**********************************/

//机构名
@property (nonatomic) NSString *shortName;

/****************************************证书信息***********************************************/

//证书ID
@property (nonatomic) NSString *bookId;

//证书编号
@property (nonatomic) NSString *bookNo;

//鉴定机构
@property (nonatomic) NSString *ocId;

//鉴定机构名称
@property (nonatomic) NSString *officeName;

//坚定机构三字代码
@property (nonatomic) NSString *officeCode;

/****************************************证书图片***********************************************/

//证书数组
@property (nonatomic) NSArray *ZSarray;

//可用图片数组type = jpeg表示图片可用
@property (nonatomic) NSArray *CanUsePicArray;

/****************************************代理***********************************************/
//代理
@property (nonatomic) NSArray *agentArray;


- (instancetype)initWithdic:(NSDictionary *)dic;


@end
