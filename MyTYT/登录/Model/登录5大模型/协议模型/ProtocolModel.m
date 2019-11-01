//
//  ProtocolModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ProtocolModel.h"

@implementation ProtocolModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.protocolContrnt = dic[@"regVal"];

    }
    return self;
}

@end
