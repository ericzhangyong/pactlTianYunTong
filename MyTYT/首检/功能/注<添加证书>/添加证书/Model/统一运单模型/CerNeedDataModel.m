//
//  CerNeedDataModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CerNeedDataModel.h"
#import "FirstModel.h"
#import "TwentyModel.h"

@implementation CerNeedDataModel

//首检
- (instancetype)initWithFirstModel:(FirstModel *)model{
    
    if (self = [super init]) {
        
        self.DLChinese = model.agent_short_name;
        
        self.YDH = model.ALLNUmber;
        
        self.DL = model.daili;
        
        self.JS = model.jianshu;
        
        self.ZL = model.zhongliang;
        
        self.MDG = model.MUdigang;
        
    }
    return self;
}

//24小时
- (instancetype)initWithTwentyModel:(TwentyModel *)model{
    
    if (self = [super init]) {
        
        self.DLChinese = model.agent_short_name;

        self.YDH = model.waybill_no;
        
        self.DL = model.agent_oprn;
        
        self.JS =  model.total_count.stringValue;
        
        self.ZL = model.gross_weight.stringValue;
        
        self.MDG = model.dest1;
    }
    return self;
}

@end
