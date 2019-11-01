//
//  DetailCheckHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailCheckHeadView.h"
#import "CheckModel.h"
#import "SectionheadLable.h"
#import "Masonry.h"

@implementation DetailCheckHeadView

- (instancetype)init{
    if (self = [super init]) {
        
        self.statusLable = [[SectionheadLable alloc] initWithTitle:@"安检状态"];
        self.timeLable = [[SectionheadLable alloc] initWithTitle:@"操作时间"];
        self.machLable = [[SectionheadLable alloc] initWithTitle:@"安检机/安检人员"];
      
        
        [self addSubview:self.statusLable];
        [self addSubview:self.timeLable];
        [self addSubview:self.machLable];
       
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self layout];
}

- (void)layout{
    
    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(self).multipliedBy(0.25).offset(-20);
        make.centerY.equalTo(self);
    }];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLable.mas_right);
        make.width.equalTo(self).multipliedBy(0.3);
        make.centerY.equalTo(self);
        
    }];
    
    [self.machLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLable.mas_right);
        make.width.equalTo(self).multipliedBy(0.25);
        make.centerY.equalTo(self);
    }];
 
}
@end
