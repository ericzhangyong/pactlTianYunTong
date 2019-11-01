//
//  SelectStateModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectStateModel.h"

@implementation SelectStateModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.state = @"";
        self.operationcount = 0;
        self.isAllAgree = NO;
    }
    return self;
}

@end
