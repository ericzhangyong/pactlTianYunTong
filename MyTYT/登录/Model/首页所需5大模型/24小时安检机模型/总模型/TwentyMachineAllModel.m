//
//  TwentyMachineAllModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyMachineAllModel.h"
#import "TwentyMachineModel.h"

@implementation TwentyMachineAllModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.totolMachineCount = [dic[@"total"] integerValue];
        
        NSMutableArray *array = [NSMutableArray array];
        
        if (self.totolMachineCount >0 && [dic[@"rows"] isKindOfClass:[NSArray class]] && [dic[@"rows"] count]>0) {
            
            for (NSDictionary *temdic in dic[@"rows"]) {
                TwentyMachineModel*model = [[TwentyMachineModel alloc] initWithDic:temdic];
                [array addObject:model];
            }
            
        }
        
        self.MachineArray = [NSArray arrayWithArray:array];
    }
    return  self;
}

@end
