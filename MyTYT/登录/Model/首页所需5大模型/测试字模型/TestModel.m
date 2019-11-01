//
//  TestModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TestModel.h"
#import "NSDictionary+Judge.h"

@implementation TestModel

- (instancetype)initWirhDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.ok = [dic[@"ok"] intValue];
        
        self.msg = dic[@"msg"];
        
        if (self.ok == 1) {
            
            NSDictionary *temdic = dic[@"data"];
            
            if ([dic judgekeyAndValueWithKey:@"regVal"]) {
                self.regVal = temdic[@"regVal"];
            }else{
                self.regVal = @"";
            }
            
        
        }
        
    }
    return self;
}

@end
