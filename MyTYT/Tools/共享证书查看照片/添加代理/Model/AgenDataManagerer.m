//
//  AgenDataManagerer.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AgenDataManagerer.h"
#import "AgentSectionModel.h"
#import "SQModel.h"

@implementation AgenDataManagerer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.SectionArray = [NSArray array];
    }
    return self;
}

- (instancetype)initWithAgentArray:(NSArray *)agentArray{
    
    if (self = [super init]) {
        
        [self setDataWithArray:agentArray];
        
    }
   return  self;
}

- (void)setDataWithArray:(NSArray *)array{
    
    SQModel *model = [[SQModel alloc] initWithTitle:@"授权代理:"];
    
    AgentSectionModel *section = [[AgentSectionModel alloc] initWithArray:@[@[model],array]];
    
    self.SectionArray = [NSArray arrayWithObjects:section, nil];
}

@end
