//
//  SelectModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectModel.h"

@implementation SelectModel

- (instancetype)initWithAgentName:(NSString *)agentName name:(NSString *)name{
    
    if (self = [super init]) {
    
        self.agentName = agentName;
        
        self.name = name;
    }
    return self;
    
}

@end
