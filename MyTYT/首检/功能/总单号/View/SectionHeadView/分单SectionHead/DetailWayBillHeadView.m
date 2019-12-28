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

@interface DetailWayBillHeadView ()

@property (nonatomic,assign) DetectionType detectionType;
@end
@implementation DetailWayBillHeadView

//-(instancetype)initWithDetectionType:(DetectionType)detectionType{
//    if (self = [super init]) {
////        self.detectionType = detectionType;
//    }
//    return self;
//}

- (instancetype)initWithDetectionType:(DetectionType)detectionType
{
    self = [super init];
    if (self) {
        self.detectionType = detectionType;
        self.FDHLable = [[SectionheadLable alloc] initWithTitle:@"物流单号"];
        self.JSable = [[SectionheadLable alloc] initWithTitle:@"件数"];
        self.ZLable = [[SectionheadLable alloc] initWithTitle:@"重量"];
        self.MDGLable = [[SectionheadLable alloc] initWithTitle:@"目的港"];
        self.PMLable = [[SectionheadLable alloc] initWithTitle:@"英文品名"];
        self.PMChLable = [[SectionheadLable alloc] initWithTitle:@"中文品名"];
        self.BZLable = [[SectionheadLable alloc] initWithTitle:@"备注"];

        [self addSubview:self.FDHLable];
        [self addSubview:self.JSable];
        [self addSubview:self.ZLable];
        [self addSubview:self.MDGLable];
        [self addSubview:self.PMLable];
        [self addSubview:self.PMChLable];
        [self addSubview:self.BZLable];
        
        self.JSable.textAlignment = NSTextAlignmentCenter;
        self.ZLable.textAlignment = NSTextAlignmentCenter;
        self.MDGLable.textAlignment = NSTextAlignmentCenter;
        self.BZLable.textAlignment = NSTextAlignmentCenter;
        self.PMLable.textAlignment = NSTextAlignmentCenter;
        self.PMChLable.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
    [self layout];
}

- (void)layout{
    
    CGFloat fdRate = 0.34;
    CGFloat pmRate = 0;
    CGFloat pmRateOffset = 0;
    CGFloat pmChRate = 0.26;
    if (self.detectionType != DetectionType9610System) {
        fdRate = 0.2;
        pmRate = 0.2;
        pmRateOffset = 20;
        pmChRate = 0.2;
    }
    [self.FDHLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(self).multipliedBy(fdRate).offset(-20);
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
        make.left.equalTo(self.MDGLable.mas_right).offset(pmRateOffset);
        make.width.equalTo(self).multipliedBy(pmRate).offset(-pmRateOffset);
        make.centerY.equalTo(self);
        
    }];
    
    [self.PMChLable mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.PMLable.mas_right).offset(0);
           make.width.equalTo(self).multipliedBy(pmChRate).offset(-0);
           make.centerY.equalTo(self);
       }];
    
    [self.BZLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PMChLable.mas_right);
        make.width.equalTo(self).multipliedBy(0.1);
        make.centerY.equalTo(self);
        
    }];
}

@end
