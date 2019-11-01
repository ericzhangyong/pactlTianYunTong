//
//  AddBZSectionModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZSectionModel.h"
#import "AddBZRowModel.h"
#import "BZSectionHeadView.h"

@implementation AddBZSectionModel

- (instancetype)initWithSectionType:(ADDBZSectionCellType)type rowArray:(NSArray <NSArray *>*)rowarray{
    if (self = [super init]) {
        
        self.sectionType = type;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSArray *temarray in rowarray) {
            
            
            for (int i=0; i<temarray.count; i++) {
                
                AddBZRowModel *rowmodel = [[AddBZRowModel alloc] initWithModel:temarray[i]];
                
                [array addObject:rowmodel];
            }
        }
        
        self.rowarray = [NSMutableArray arrayWithArray:array];
        
        [self setHeight];
        
        [self setSectionVIew];
    }
    return self;
}

- (void)setHeight{
    
    switch (self.sectionType) {
        case contentTYpe:
        {
            self.headheight = 50;
            self.footerHeight = 20;
        }
            break;
            
        default:
        {
            self.headheight = 0;
            self.footerHeight = 20;
        }
            break;
    }
}


- (void)setSectionVIew{
    
    switch (self.sectionType) {
        case contentTYpe:
        {
            self.headview = [[BZSectionHeadView alloc] init];
        }
            break;
            
        default:
        {
            self.headview = [[UIView alloc] init];
        }
            break;
    }
    
    self.footview = [[UIView alloc] init];
}

@end
