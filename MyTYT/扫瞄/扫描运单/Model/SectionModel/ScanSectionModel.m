//
//  ScanSectionModel.m
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanSectionModel.h"
#import "ScanRowModel.h"
#import "ScanModel.h"
#import "ScanHisToryModel.h"

@implementation ScanSectionModel

- (instancetype)initWithScanModel:(ScanModel *)scanModel{
    if (self = [super init]) {
        
        self.scanModel = scanModel;
        
        [self setData];
        
        [self baseSet];
    }
    return self;
}

- (void)setData{
    
    NSMutableArray *array = [NSMutableArray array];
    
    ScanRowModel *stateRowModel = [[ScanRowModel alloc] initWithModel:self.scanModel];
    [array addObject:stateRowModel];
    
    
    if (self.scanModel.historyArray.count>0) {
        
    for (NSDictionary *temdic in self.scanModel.historyArray) {
        
        ScanHisToryModel *hisModel = [[ScanHisToryModel alloc] initWithDic:temdic];
        ScanRowModel *HisRowModel = [[ScanRowModel alloc] initWithModel:hisModel];
        [array addObject:HisRowModel];
    }
        
    }

    
    self.rowArray = [NSArray arrayWithArray:array];
    
}

- (void)baseSet{
    
    self.sctionHeadHeight = 0;
    self.sctionFootHeight = 15;
    
    self.SectionHeadView = [[UIView alloc] init];
    self.SectionFooterView = [[UIView alloc] init];
//    self.SectionFooterView.backgroundColor = [UIColor orangeColor];
}

@end
