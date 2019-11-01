//
//  OperationMachinModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationMachinModel : NSObject

//货站ID
@property (nonatomic) NSString *ctId;
//货站名称
@property (nonatomic) NSString *ctName;

//机器名称
@property (nonatomic) NSString *machineName;

- (instancetype)initWirhDic:(NSDictionary *)dic;

@end
