//
//  detailInfoheadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "detailInfoheadView.h"
#import "Masonry.h"
#import "SectionheadLable.h"

@implementation detailInfoheadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.infolable = [[SectionheadLable alloc] initWithTitle:@"信息详情"];
        
        [self addSubview:self.infolable];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self layout];
}

- (void)layout{
    
    
    [self.infolable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(self).multipliedBy(0.2).offset(-20);
        make.centerY.equalTo(self);
    }];
    
}

@end
