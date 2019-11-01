//
//  SelctCerAllModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelctCerAllModel.h"
#import "SelectCerModel.h"

@implementation SelctCerAllModel

- (instancetype)initWithdic:(NSDictionary *)dic{
    if (self = [super init]) {
       
        self.ok = [dic[@"ok"] integerValue];
        
        self.msg = dic[@"msg"];
        
        NSMutableArray *array = [NSMutableArray array];
        
        if (dic[@"data"] != Nil && [dic[@"data"] isKindOfClass:[NSArray class]] && [dic[@"data"] count]>0) {//有数据
            
            for (NSDictionary *temdic in dic[@"data"]) {
                SelectCerModel *model = [[SelectCerModel alloc] initWithdic:temdic];
                [array addObject:model];
            }
            
        }
        
        self.array = [NSArray arrayWithArray:array];
    }
    return self;
}

@end
