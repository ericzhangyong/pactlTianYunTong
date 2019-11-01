//
//  QueryAgentModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryAgentModel.h"

@implementation QueryAgentModel

- (instancetype)initWithAgent:(NSString *)Agent{
    if (self = [super init]) {
        
        self.agent = Agent;
    }
    return self;
}


@end
