//
//  newBZALLModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newBZALLModel.h"
#import "NewBZModel.h"

@implementation newBZALLModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.ok = [dic[@"ok"] intValue];
        
        self.msg = dic[@"msg"];
        
        NSMutableArray *array =[NSMutableArray array];

        if ([dic[@"data"] isKindOfClass:[NSArray class]] && [dic[@"data"] count] >0) {
            for (NSDictionary *temdic in dic[@"data"]) {
                NewBZModel *model = [[NewBZModel alloc] initWIthDic:temdic];
                [array addObject:model];
            }
        }
        
    
        self.array = [NSArray arrayWithArray:array];
    }
    return self;
}

@end
