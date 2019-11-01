//
//  GPModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "GPModel.h"

@implementation GPModel

- (instancetype)initWithdic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.ok = [dic[@"ok"] intValue];
        
        self.msg = dic[@"msg"];
        
        if (dic[@"data"] !=Nil && [dic[@"data"] isKindOfClass:[NSString class]] && [dic[@"data"] hasPrefix:@"从"]) {
            self.isgp = YES;
        }else{
            self.isgp = NO;
        }
        
    }
    return self;
}

@end
