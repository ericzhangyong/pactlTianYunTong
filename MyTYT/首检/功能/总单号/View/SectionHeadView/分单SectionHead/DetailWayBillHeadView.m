//
//  DetailWayBillHeadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailWayBillHeadView.h"
#import "SectionheadLable.h"
#import "Masonry.h"

@implementation DetailWayBillHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.FDHLable = [[SectionheadLable alloc] initWithTitle:@"物流单号"];
        self.JSable = [[SectionheadLable alloc] initWithTitle:@"件数"];
        self.ZLable = [[SectionheadLable alloc] initWithTitle:@"重量"];
        self.MDGLable = [[SectionheadLable alloc] initWithTitle:@"目的港"];
        self.PMLable = [[SectionheadLable alloc] initWithTitle:@"中文品名"];
        self.BZLable = [[SectionheadLable alloc] initWithTitle:@"备注"];

        [self addSubview:self.FDHLable];
        [self addSubview:self.JSable];
        [self addSubview:self.ZLable];
        [self addSubview:self.MDGLable];
        [self addSubview:self.PMLable];
        [self addSubview:self.BZLable];
        
        self.JSable.textAlignment = NSTextAlignmentCenter;
        self.ZLable.textAlignment = NSTextAlignmentCenter;
        self.MDGLable.textAlignment = NSTextAlignmentCenter;
        self.BZLable.textAlignment = NSTextAlignmentCenter;



    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
    [self layout];
}

- (void)layout{
    
    [self.FDHLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(self).multipliedBy(0.2).offset(-20);
        make.centerY.equalTo(self);
    }];
    
    [self.JSable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.FDHLable.mas_right);
        make.width.equalTo(self).multipliedBy(0.1);
        make.centerY.equalTo(self);
        
    }];
    
    [self.ZLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.JSable.mas_right);
        make.width.equalTo(self).multipliedBy(0.1);
        make.centerY.equalTo(self);
        
    }];
    
    [self.MDGLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ZLable.mas_right);
        make.width.equalTo(self).multipliedBy(0.1);
        make.centerY.equalTo(self);
        
    }];
    
    [self.PMLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.MDGLable.mas_right).offset(20);
        make.width.equalTo(self).multipliedBy(0.4).offset(-20);
        make.centerY.equalTo(self);
        
    }];
    
    [self.BZLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PMLable.mas_right);
        make.width.equalTo(self).multipliedBy(0.1);
        make.centerY.equalTo(self);
        
    }];
}

@end
