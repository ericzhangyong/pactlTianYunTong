//
//  DetailNotifyModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailNotifyModel.h"

@implementation DetailNotifyModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        
        self.name = dic[@"name"];
        
      
        
    }
    return self;
}

@end
