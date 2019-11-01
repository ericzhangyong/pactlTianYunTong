//
//  SQModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SQModel.h"

@implementation SQModel

- (instancetype)initWithTitle:(NSString *)title{
    
    if (self = [super init]) {
        
        self.title = title;
    }
    return self;
}

@end
