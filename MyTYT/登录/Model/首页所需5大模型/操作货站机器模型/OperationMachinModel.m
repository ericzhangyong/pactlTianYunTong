//
//  OperationMachinModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "OperationMachinModel.h"

@implementation OperationMachinModel


- (instancetype)initWirhDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.machineName = dic[@"machineName"];
        
        self.ctName = dic[@"ctName"];
        
        self.ctId = dic[@"ctId"];
        
    }
    return self;
}

@end
