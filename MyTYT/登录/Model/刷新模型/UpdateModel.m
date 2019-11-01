//
//  UpdateModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "UpdateModel.h"
#import "NSDictionary+Judge.h"
#import "CheckVerSonModel.h"

@implementation UpdateModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.ok = [dic[@"ok"] integerValue];
        
        self.msg = dic[@"msg"];
        
        if (self.ok ==1 && [dic judgekeyAndValueWithKey:@"data"] && [dic[@"data"] judgekeyAndValueWithKey:@"PAppversion"]) {
            
            self.verSonModel = [[CheckVerSonModel alloc] initWithDic:dic[@"data"][@"PAppversion"]];
            
        }else{
            
            self.verSonModel = [[CheckVerSonModel alloc] init];
        }
    }
    return self;
}

@end
