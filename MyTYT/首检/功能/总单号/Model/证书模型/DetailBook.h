//
//  DetailBook.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailBook : NSObject

//证书编号
@property (nonatomic) NSString *bookNo;

//根据BookID查看证书图片接口
@property (nonatomic) NSString *bookId;

//证书类型==book为证书
@property (nonatomic) NSString *bookCheckType;

//等于1显示证书
@property (nonatomic) NSString *checkVisual;

//证书创建时间
@property (nonatomic) NSString *createdDate;

//证书ID（如果没返回bookid，用ID查看证书）
@property (nonatomic) NSString *ID;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
