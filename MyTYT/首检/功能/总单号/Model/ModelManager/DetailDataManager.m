//
//  DetailDataManager.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailDataManager.h"
#import "DetailSectionModel.h"
#import "DetailModel.h"

@interface DetailDataManager ()

@end


@implementation DetailDataManager

- (instancetype)initWithWith:(DetailModel *)detailModel gpModel:(GPModel *)gpmdoel{

    if (self = [super init]) {
        
        self.gpModel = gpmdoel;
        
        self.detailModel = detailModel;
                
        [self setDataWithDetailModel:detailModel];
        
    }
    return self;
}


//设置数据1
- (void)setDataWithDetailModel:(DetailModel *)model{


     //详情
    DetailSectionModel *InfoModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionInfoCellType RowArray:@[@[model.infomdel]]];


    //分单
    DetailSectionModel *wayBillModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionWayBillCellType RowArray:@[model.waybillArray,model.wayAllArray]];


    //证书
    DetailSectionModel *BookModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionDetailBookCellType RowArray:@[model.canUseBookArray]];


    //安检
     DetailSectionModel *CheckModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionCheckCellType RowArray:@[model.checkArray]];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:InfoModel,wayBillModel,BookModel,CheckModel, nil];

    self.dataArray = [NSArray arrayWithArray:array];

}

@end
