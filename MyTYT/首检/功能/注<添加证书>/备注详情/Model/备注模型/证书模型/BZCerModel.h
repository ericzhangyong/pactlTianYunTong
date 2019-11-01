//
//  BZCerModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZCerModel : NSObject


 //证书类型==book为证书
@property (nonatomic) NSString *bookCheckType;
 
 //等于1显示证书
@property (nonatomic) NSString *checkVisual;
 
 //等于1显示删除
@property (nonatomic) NSString *deviceId;

//证书号
@property (nonatomic) NSString *bookNo;

//证书ID
@property (nonatomic) NSString *bookId;

//运单证书ID
@property (nonatomic) NSString *ID;

//鉴定机构ID
@property (nonatomic) NSString *ocId;

- (instancetype)initWithDic:(NSDictionary *)dic;
 

@end
