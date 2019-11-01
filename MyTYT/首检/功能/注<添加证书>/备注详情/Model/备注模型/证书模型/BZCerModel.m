//
//  BZCerModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BZCerModel.h"

@implementation BZCerModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
    
        self.bookNo = dic[@"bookNo"];
        
        if (dic[@"checkVisual"] !=Nil) {
            self.checkVisual = dic[@"checkVisual"];

        }else{
            self.checkVisual = @"";
        }
        
        self.deviceId = dic[@"deviceId"];
        
        self.bookCheckType = dic[@"bookCheckType"];
        
        if (dic[@"bookId"]!=Nil) {
            self.bookId = dic[@"bookId"];
        }else{
            self.bookId = @"";
        }
        
        if (dic[@"id"] !=Nil) {
            self.ID = dic[@"id"];
        }else{
            self.ID = @"";
        }
        
        self.ocId = dic[@"ocId"];
        
    }
    
    return self;
}

@end
