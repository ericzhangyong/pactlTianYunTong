//
//  RoadModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoadModel : NSObject

//具体位置
@property (nonatomic) NSString *remark;
//通道名称
@property (nonatomic) NSString *name;
//通道ID
@property (nonatomic) NSString *ID;
//货站ID
@property (nonatomic) NSString *ctid;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
