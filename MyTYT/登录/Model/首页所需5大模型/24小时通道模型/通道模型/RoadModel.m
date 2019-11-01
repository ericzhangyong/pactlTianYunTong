//
//  RoadModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "RoadModel.h"

@implementation RoadModel

- (instancetype)init{
    if (self = [super init]) {
        self.ID = @"";
        self.name = @"";
        self.remark = @"";
        self.ctid = @"";
    }
    return self;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        
        if (dic[@"name"] !=Nil) {
            self.name = dic[@"name"];
        }else{
            self.name = @"";
        }
        
        if (dic[@"id"] !=Nil) {
            self.ID = dic[@"id"];
        }else{
            self.ID = @"";
        }
        
        
        if (dic[@"remark"] !=Nil) {
            self.remark = dic[@"remark"];
        }else{
            self.remark = @"";
        }
        
        if (dic[@"ctid"] !=Nil) {
            self.ctid = dic[@"ctid"];
        }else{
            self.ctid = @"";
        }
    }
    return self;
}

@end
