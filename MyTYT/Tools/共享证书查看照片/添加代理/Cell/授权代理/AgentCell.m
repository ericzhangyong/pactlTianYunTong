//
//  AgentCell.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AgentCell.h"
#import "QueryAgentModel.h"
#import "UIColor+ColorString.h"

@implementation AgentCell

- (void)loaddataWithModel:(QuerybaseModel *)model{
    
    QueryAgentModel *agentModel = (QueryAgentModel *)model;
    
    self.title.text = agentModel.agent;
    
    self.title.backgroundColor = [UIColor colorWithHexString:agentModel.colorStr];
    
    
 
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;

    self.layer.cornerRadius = 5;
    
    self.title.adjustsFontSizeToFitWidth = YES;
    
}

@end
