//
//  ClickControlAllModel.m
//  MyTYT
//
//  Created by Fly on 2019/3/27.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ClickControlAllModel.h"
#import "ClickControlModel.h"

@implementation ClickControlAllModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.ok = [dic[@"ok"] integerValue];
        
        if (self.ok == 1) {
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *temdic in dic[@"data"]) {
                ClickControlModel *model = [[ClickControlModel alloc] initWithDic:temdic];
                [array addObject:model];
            }
            
            self.array = [NSArray arrayWithArray:array];

        }else{
            self.msg = dic[@"msg"];
        }
        
    }
    return self;
}

@end
