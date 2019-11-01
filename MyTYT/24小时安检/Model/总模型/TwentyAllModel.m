//
//  TwentyAllModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyAllModel.h"
#import "TwentyModel.h"

@implementation TwentyAllModel


- (instancetype)initWIthDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.dataarray = [NSMutableArray array];
        
        self.ok = [dic[@"ok"] integerValue];
        
        self.msg = dic[@"msg"];
        
        if (self.ok == 1) {
            
            
            if ([dic[@"data"] isKindOfClass:[NSArray class]] && [dic[@"data"] count] >0) {
                
                for (NSDictionary *temdic in dic[@"data"]) {
                    
                    TwentyModel *model = [[TwentyModel alloc] initWithDic:temdic];
                    
                        [self.dataarray addObject:model];

                                    

                }
            }
            
        }
        
        
    }
    return self;
}

@end
