//
//  LeftLable.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LeftLable.h"

@implementation LeftLable


- (instancetype)initWithTitle:(NSString *)title{
    
    if (self = [super init]) {
        
        self.text = title;
        [self setFont:[UIFont boldSystemFontOfSize:15]];
        self.textColor = BtnColor;
        self.textAlignment = NSTextAlignmentLeft;
        self.adjustsFontSizeToFitWidth = YES;

    }
    return self;
}

@end
