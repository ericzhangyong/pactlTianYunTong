//
//  ScanRowModel.m
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanRowModel.h"
#import "ScanModel.h"
#import "ScanHisToryModel.h"

@implementation ScanRowModel

- (instancetype)initWithModel:(id)model{
    if (self = [super init]) {
        
        if ([model isKindOfClass:[ScanBillModel class]]) {
            
            self.Type = ScanStateRowType;
            self.scanModel =  model;
            
        }else if ([model isKindOfClass:[ScanHisToryModel class]]){
            self.Type = ScanHistoryRowType;
            self.hisModel = model;
        }
        
    }
    return self;
}

@end
