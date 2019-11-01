//
//  BZLable.m
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BZLable.h"

@implementation BZLable

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.text = title;
        self.textColor =  [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];

    }
    return self;
}

@end
