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

//进入类型
@property (nonatomic,assign) DetectionType detailType;

@end


@implementation DetailDataManager

- (instancetype)initWithWith:(DetailModel *)detailModel gpModel:(GPModel *)gpmdoel dectionType:(DetectionType)detailType{

    if (self = [super init]) {
        
        self.detailType = detailType;
        self.gpModel = gpmdoel;
        
        self.detailModel = detailModel;
                
        [self setDataWithDetailModel:detailModel];
        
        
    }
    return self;
}


//设置数据1
- (void)setDataWithDetailModel:(DetailModel *)model{


     //详情
    DetailSectionModel *InfoModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionInfoCellType RowArray:@[@[model.infomdel]] DetectionType:self.detailType];


    //分单
    DetailSectionModel *wayBillModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionWayBillCellType RowArray:@[model.waybillArray,model.wayAllArray] DetectionType:self.detailType];


    //证书
    DetailSectionModel *BookModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionDetailBookCellType RowArray:@[model.canUseBookArray] DetectionType:self.detailType];


    //安检
     DetailSectionModel *CheckModel = [[DetailSectionModel alloc] initWithSectioncellType:SetionCheckCellType RowArray:@[model.checkArray] DetectionType:self.detailType];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:InfoModel,wayBillModel,BookModel,CheckModel, nil];

    self.dataArray = [NSArray arrayWithArray:array];

}

@end
