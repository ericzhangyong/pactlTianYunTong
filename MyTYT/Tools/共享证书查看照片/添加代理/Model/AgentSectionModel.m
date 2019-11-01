//
//  AgentSectionModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AgentSectionModel.h"
#import "QuerybaseModel.h"
#import "AgentRowModel.h"

@implementation AgentSectionModel

- (instancetype)initWithArray:(NSArray <NSArray *> *)array{
    
    if (self = [super init]) {
        
        NSMutableArray *dataarray = [NSMutableArray array];
        
        for (NSArray *temarray in array) {
            
            for (int i=0; i<temarray.count; i++) {
                
                AgentRowModel *model = [[AgentRowModel alloc] initWithModel:temarray[i]];
                
                model.dataRow = i;
                
                [dataarray addObject:model];
            }
           
        }
        
        self.rowArray = [NSArray arrayWithArray:dataarray];
    }
    return self;
}

@end
