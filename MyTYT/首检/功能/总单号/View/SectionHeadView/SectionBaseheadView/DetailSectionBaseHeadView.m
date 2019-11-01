//
//  DetailSectionBaseHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailSectionBaseHeadView.h"

@implementation DetailSectionBaseHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = NavColor;
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
}

@end
