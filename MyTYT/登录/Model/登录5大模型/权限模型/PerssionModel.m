//
//  PerssionModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "PerssionModel.h"

@implementation PerssionModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.Permissions = dic[@"Permissions"];

    }
    return self;
}

@end
