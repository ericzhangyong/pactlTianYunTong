//
//  ScanHisToryModel.m
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanHisToryModel.h"
#import "NSDictionary+Judge.h"

@implementation ScanHisToryModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self =[super init]) {
        
        if ([dic judgekeyAndValueWithKey:@"personName"]) {
            self.HisOperationMan = dic[@"personName"];
        }else{
            self.HisOperationMan = @"";
        }
        
        
        if ([dic judgekeyAndValueWithKey:@"pCheckFlist"]) {
            
            [self otherDataWithDic:dic[@"pCheckFlist"]];
            
        }else{
            
            self.HisState = @"";
            self.HisOpertionMachine = @"";
            self.HisTime = @"";
            
        }
    
    }
    return self;
}

- (void)otherDataWithDic:(NSDictionary *)dic{
    
    //机器
    if ([dic judgekeyAndValueWithKey:@"machine"]) {
        self.HisOpertionMachine = dic[@"machine"];
    }else{
        self.HisOpertionMachine = @"";
    }
    
    //状态
    if ([dic judgekeyAndValueWithKey:@"fstatus"]) {

        if ([dic[@"fstatus"] isEqualToString:@"1"]) {
            self.HisState = @"通过";
        }else if ([dic[@"fstatus"] isEqualToString:@"0"]){
            self.HisState = @"待定";
        }else{
            self.HisState = @"";
        }

    }else{
        self.HisState = @"";
    }
    
    //时间
    if ([dic judgekeyAndValueWithKey:@"operatdate"]) {

        NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:([dic[@"operatdate"] doubleValue]/1000)];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.HisTime = [dateFormatter stringFromDate: detailDate];
        
    }else{
        self.HisTime = @"";
    }
    
}

@end
