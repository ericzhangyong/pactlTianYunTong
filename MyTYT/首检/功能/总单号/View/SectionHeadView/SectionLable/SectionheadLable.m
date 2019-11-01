//
//  SectionheadLable.m
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SectionheadLable.h"

@implementation SectionheadLable

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        
        self.textColor = [UIColor whiteColor];
        self.text = title;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
