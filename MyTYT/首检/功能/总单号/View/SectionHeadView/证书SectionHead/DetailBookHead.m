//
//  DetailBookHead.m
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailBookHead.h"
#import "SectionheadLable.h"
#import "Masonry.h"

@implementation DetailBookHead

- (instancetype)initWithBookCount:(NSInteger)count{
    if (self =[super init]) {
        
        self.bookLable = [[SectionheadLable alloc] initWithTitle:@"证书列表"];
        self.countLable = [[SectionheadLable alloc] initWithTitle:[NSString stringWithFormat:@"(%ld)",count]];;
        
        [self addSubview:self.bookLable];
        
        [self addSubview:self.countLable];
                
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self layout];
}

- (void)layout{
    
    [self.bookLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(self);
    }];
    
    [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bookLable.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
}

@end
