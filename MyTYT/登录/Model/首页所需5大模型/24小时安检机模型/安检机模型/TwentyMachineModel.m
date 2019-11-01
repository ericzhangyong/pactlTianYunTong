//
//  TwentyMachineModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyMachineModel.h"

@implementation TwentyMachineModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        if (dic[@"id"]!=Nil) {
            self.ID = dic[@"id"];
        }else{
            self.ID = @"";
        }
        
        if (dic[@"name"]!=Nil) {
            self.name = dic[@"name"];
        }else{
            self.name = @"";
        }
        
        if (dic[@"ctid"]!=Nil) {
            self.ctid= dic[@"ctid"];
        }else{
            self.ctid = @"";
        }
        
        if (dic[@"deleted"]!=Nil) {
            self.deleted= dic[@"deleted"];
        }else{
            self.deleted = @"";
        }
        
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ID = @"";
        self.name = @"";
        self.ctid = @"";
        self.deleted = @"";
    }
    return self;
}

@end
