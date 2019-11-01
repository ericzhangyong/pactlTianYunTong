//
//  BZSectionHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BZSectionHeadView.h"
#import "Masonry.h"
#import "BZLable.h"

@implementation BZSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        
        [self layout];
    }
    return self;
}

- (void)creatUI{
    
    
    self.YGlable = [[BZLable alloc] initWithTitle:@"员工"];
    self.Contentlable = [[BZLable alloc] initWithTitle:@"内容"];
    self.Timelable = [[BZLable alloc] initWithTitle:@"时间"];
    self.Piclable = [[BZLable alloc] initWithTitle:@"图片"];
    self.EDitlable = [[BZLable alloc] initWithTitle:@"编辑"];
    self.Deletelable = [[BZLable alloc] initWithTitle:@"操作"];
    
    self.Piclable.textAlignment = NSTextAlignmentLeft;
    self.EDitlable.textAlignment = NSTextAlignmentCenter;
    self.Deletelable.textAlignment = NSTextAlignmentCenter;


    [self addSubview:self.YGlable];
    [self addSubview:self.Contentlable];
    [self addSubview:self.Timelable];
    [self addSubview:self.Piclable];
    [self addSubview:self.EDitlable];
    [self addSubview:self.Deletelable];
    
}

- (void)layout{
 
    [_YGlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.equalTo(self).multipliedBy(0.1);
        make.top.bottom.equalTo(self);
    }];
    
    [_Deletelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.1);
    }];
    [_EDitlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Deletelable.mas_left);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.1);
    }];
    [_Piclable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.EDitlable.mas_left);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.2);
        
    }];
    
    [_Timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.Piclable.mas_left);
        make.top.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.1);
        
    }];
    
    [_Contentlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.YGlable.mas_right).offset(10);
        make.right.equalTo(self.Timelable.mas_left).offset(-10);
        make.top.bottom.equalTo(self);
    }];
}

@end
