//
//  DeviceModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.machinID = dic[@"machine"];
    }
    return self;
}

@end
