//
//  QueryAgentCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryAgentCell.h"
#import "QueryAgentModel.h"
#import "UIColor+ColorString.h"

@implementation QueryAgentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.masksToBounds = YES;
    
    self.layer.cornerRadius = 5;
    
}

- (void)loaddataWithBaseModel:(QuerybaseModel *)model{
    
     QueryAgentModel *agentModel = (QueryAgentModel *)model;
    
    self.agentLable.text = agentModel.agent;
    
    self.agentLable.backgroundColor = [UIColor colorWithHexString:agentModel.colorStr];
 
}

@end
