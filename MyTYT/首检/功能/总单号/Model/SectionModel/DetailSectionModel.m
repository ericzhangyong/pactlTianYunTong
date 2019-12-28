//
//  DetailSectionModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailSectionModel.h"
#import "DetailRowMOdel.h"
#import "DetailModel.h"
#import "DetailBookHead.h"
#import "DetailWayBillHeadView.h"
#import "detailInfoheadView.h"
#import "DetailCheckHeadView.h"

@interface DetailSectionModel ()
//进入类型
@property (nonatomic,assign) DetectionType detailType;

@end
@implementation DetailSectionModel


- (instancetype)initWithSectioncellType:(DetailCellType)SectioncellType
                               RowArray:(NSArray<NSArray *> *)rowArray
                          DetectionType:(DetectionType)detailType{
    
    if (self = [super init]) {
        
        self.cellType = SectioncellType;
        self.detailType = detailType;
        
        NSMutableArray *array = [NSMutableArray array];
        
        
        for (NSArray *RowTypeArray in rowArray) {
            
            
            for (int i = 0; i<RowTypeArray.count; i++) {
                
                id temModel = RowTypeArray[i];
                
                DetailRowMOdel * rowmodel = [[DetailRowMOdel alloc] initWithModel:temModel];
                
                rowmodel.dataRow = i;
                
                [array addObject:rowmodel];
            }
            
        }
        
        self.rowArray = [NSArray arrayWithArray:array];
        
        [self setSectionHeight];
        
        [self setSectionView];

        
    }
    return self;
}

//根据数据设置section头尾高度
- (void)setSectionHeight{
    
    CGFloat headheight = 60;
    CGFloat footheight = 35;
    
    switch (self.cellType) {
    
        case SetionCheckCellType:
        {
            self.sectionHeadHeight = headheight;
            self.SectionFootHeight = footheight;
        }
            break;
            
            default:
        {
            self.sectionHeadHeight = self.rowArray.count > 0 ? headheight : 0;
            
            self.SectionFootHeight = self.rowArray.count > 0 ? footheight : 0;
        }
            break;
            
    }
    
}
//设置SectionView
- (void)setSectionView{
    
    switch (self.cellType) {
            
        case SetionInfoCellType:
        {
            self.SectionheadView = [[detailInfoheadView alloc] init];
        }
            break;
            
        case SetionWayBillCellType:
        {
            DetailWayBillHeadView *headView = [[DetailWayBillHeadView alloc] initWithDetectionType:self.detailType];
            if (self.detailType == DetectionType9610System) {
                headView.FDHLable.text = @"物流单号";
                headView.PMLable.text = @"中文品名";
            }else{
                headView.FDHLable.text = @"分单号";
                headView.PMLable.text = @"英文品名";
            }
            
            self.SectionheadView =  headView;
        }
            break;
            
        case SetionDetailBookCellType:
        {
            self.SectionheadView = [[DetailBookHead alloc] initWithBookCount:self.rowArray.count];
        }
            break;
            
        case SetionCheckCellType:
        {
           
                self.SectionheadView = [[DetailCheckHeadView alloc] init];
           
        }
            break;
            
    }
    
    
    self.SectionFooterView = [[UIView alloc] init];
}



@end
