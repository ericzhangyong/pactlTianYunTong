//
//  DeatilTstModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DeatilTstModel.h"

@implementation DeatilTstModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        if (dic[@"isFormal"] !=Nil) {
            self.isFormal = dic[@"isFormal"];
        }else{
            self.isFormal = @"";
        }
        
        if (dic[@"showWord"] !=Nil) {
            self.showWord = dic[@"showWord"];
        }else{
            self.showWord = @"";
        }
    }
    return self;
}

@end
