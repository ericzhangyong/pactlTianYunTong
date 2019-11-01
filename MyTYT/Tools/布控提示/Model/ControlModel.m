//
//  ControlModel.m
//  MyTYT
//
//  Created by Fly on 2018/9/19.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ControlModel.h"
#import "FirstModel.h"
#import "TwentyModel.h"

@implementation ControlModel

- (instancetype)initWithTwentyModel:(TwentyModel *)mdoel{
    
    if (self = [super init]) {
        
        self.YDH = mdoel.waybill_no;
        
        self.IsControl = mdoel.iscontrol;
        
        self.IsABControl = mdoel.isABControl;
        
    }
    return self;
}

- (instancetype)initWithFirstModel:(FirstModel *)mdoel{
    if (self = [super init]) {
        
        
        self.YDH = mdoel.ALLNUmber;
        
        self.IsControl = mdoel.iscontrol;
        
        self.IsABControl = mdoel.isABControl;
        
    }
    return self;
}

@end
