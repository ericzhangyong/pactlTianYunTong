//
//  RightLable.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "RightLable.h"

@implementation RightLable

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setFont:[UIFont boldSystemFontOfSize:17]];
        self.textColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
        self.textAlignment = NSTextAlignmentLeft;
        self.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}


@end
