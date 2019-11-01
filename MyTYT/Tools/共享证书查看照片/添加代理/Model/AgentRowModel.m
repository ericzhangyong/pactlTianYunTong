//
//  AgentRowModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AgentRowModel.h"
#import "QueryAgentModel.h"
#import "SQModel.h"

@implementation AgentRowModel

- (instancetype)initWithModel:(QuerybaseModel *)model{
    
    if (self = [super init]) {
        
        self.baseModel = model;
        
        if ([[model class] isEqual:[QueryAgentModel class]]) {
            
            self.cellType = AgentRowCell;
            
        }else if ([[model class] isEqual:[SQModel class]]){
            
            self.cellType = SQRowCell;
        }
        
    }
    
    return self;
}

@end
