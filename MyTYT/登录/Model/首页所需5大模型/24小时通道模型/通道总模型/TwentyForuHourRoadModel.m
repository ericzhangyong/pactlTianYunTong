//
//  TwentyForuHourRoadModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyForuHourRoadModel.h"
#import "RoadModel.h"

@implementation TwentyForuHourRoadModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.totolRoadCount = [dic[@"total"] integerValue];
        
        NSMutableArray *array = [NSMutableArray array];
        
        if (self.totolRoadCount >0 && [dic[@"rows"] isKindOfClass:[NSArray class]] && [dic[@"rows"] count]>0) {
            
            for (NSDictionary *temdic in dic[@"rows"]) {
                RoadModel *model = [[RoadModel alloc] initWithDic:temdic];
                [array addObject:model];
               
            }
            
        }
        
        self.roadArray = [NSArray arrayWithArray:array];
    }
    
    return self;
}

@end
