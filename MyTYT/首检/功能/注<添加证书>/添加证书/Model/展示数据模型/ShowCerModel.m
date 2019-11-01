//
//  ShowCerModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowCerModel.h"

@implementation ShowCerModel

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    if (self = [super init]) {
        
        self.title = title;
        
        self.content = content;
        
    }
    return self;
}

@end
