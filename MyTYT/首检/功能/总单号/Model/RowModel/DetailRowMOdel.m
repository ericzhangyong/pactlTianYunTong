//
//  DetailRowMOdel.m
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailRowMOdel.h"
#import "WayBillModel.h"
#import "CheckModel.h"
#import "DetailBook.h"
#import "infoModel.h"
#import "FDAllModel.h"

@implementation DetailRowMOdel

- (instancetype)initWithModel:(id)model{

    if (self = [super init]) {
        
        if ([model isKindOfClass:[infoModel class]]) {
            
            self.infomdoel = (infoModel *) model;
            self.rowType =RowInfoCellType;
            
        }else if ([model isKindOfClass:[WayBillModel class]]){
            
            self.waymodel = (WayBillModel *) model;
            self.rowType =RowFDCellType;

        }else if ([model isKindOfClass:[DetailBook class]]){
            
            self.bookModel = (DetailBook *) model;
            self.rowType = RowCerCellType;

        }else if ([model isKindOfClass:[CheckModel class]]){
            
            self.checmodel = (CheckModel *) model;
            self.rowType =RowCehckTYpe;

        }else if ([model isKindOfClass:[FDAllModel class]]){
            
            self.allmodel = (FDAllModel *) model;
            self.rowType =RowCerFDALLCellType;
            
        }
    
    }
    return self;
}

@end
