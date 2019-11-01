//
//  AddBZALlModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZALlModel.h"
#import "BZModle.h"

@implementation AddBZALlModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self =[super init]) {
        
        
        self.ok = [dic[@"ok"] intValue];
        
        self.msg = dic[@"msg"];
        
        NSMutableArray *array = [NSMutableArray array];
        
        if ([dic[@"data"] isKindOfClass:[NSArray class]] && [dic[@"data"] count] >0) {
            
            for (NSDictionary *temdic in dic[@"data"]) {
                
                BZModle *mdoel = [[BZModle alloc] initWithdic:temdic];
                
                [array addObject:mdoel];
                
            }
            
        }
        
        
        self.dataarray = [NSArray arrayWithArray:array];
        
    }
    return self;
}

@end
