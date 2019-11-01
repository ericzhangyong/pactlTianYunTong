//
//  FirstAllCount.m
//  MyTYT
//
//  Created by Fly on 2018/4/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FirstAllModel.h"
#import "FirstModel.h"

@implementation FirstAllModel

- (instancetype)initWIthDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.dataarray = [NSMutableArray array];

        self.ok = [dic[@"ok"] integerValue];
        
        self.msg = dic[@"msg"];
        
        if (self.ok == 1) {
            
            NSDictionary *dataDic = dic[@"data"];
            
            if ([dataDic[@"list"] isKindOfClass:[NSArray class]] && [dataDic[@"list"] count] >0) {
                
                for (NSDictionary *temdic in dataDic[@"list"]) {
                    
                    FirstModel *model = [[FirstModel alloc] initWithDic:temdic];
                    
                    [self.dataarray addObject:model];
                }
            }
            
        }
    
        
    }
    return self;
}

@end
