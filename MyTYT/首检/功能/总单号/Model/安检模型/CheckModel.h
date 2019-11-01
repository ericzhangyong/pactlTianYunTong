//
//  CheckModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckModel : NSObject

//安检状态
@property (nonatomic) NSString *a_status;
//安检机器
@property (nonatomic) NSString *machine;
//货物类型
@property (nonatomic) NSString *goods_class;
//操作时间
@property (nonatomic) NSString *operatdate;
//安检人员
@property (nonatomic) NSString *personid;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
