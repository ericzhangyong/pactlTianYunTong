//
//  FDAllModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FDAllModel.h"
#import "WayBillModel.h"

@implementation FDAllModel

- (instancetype)initWithArray:(NSArray *)array{
    
    if (self = [super init]) {
        
  
        self.allcount = [NSDecimalNumber decimalNumberWithString:@"0"];
        self.allWeight = [NSDecimalNumber decimalNumberWithString:@"0"];

        NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        
        for (WayBillModel *temModel in array) {
            
            if ([temModel.ref_status isEqualToString:@"1"]) {//有分单下拉标记的不做统计
                
            }else{
                
               NSDecimalNumber *countnumber = [NSDecimalNumber decimalNumberWithString:temModel.total_count.stringValue];
                  NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:temModel.gross_weight.stringValue];
                
              self.allcount = [self.allcount decimalNumberByAdding:countnumber withBehavior:handel];
                self.allWeight = [self.allWeight decimalNumberByAdding:weight withBehavior:handel];
                
            }
    
        }
        
    }
    return self;
}

@end
