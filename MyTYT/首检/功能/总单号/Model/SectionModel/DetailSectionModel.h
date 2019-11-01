//
//  DetailSectionModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DetailCellType) {
    
    SetionInfoCellType,//运单详情
    SetionWayBillCellType,//分单
    SetionDetailBookCellType,//证书
    SetionCheckCellType//安检
};

@interface DetailSectionModel : NSObject

@property (nonatomic,assign) CGFloat sectionHeadHeight;

@property (nonatomic,assign) CGFloat SectionFootHeight;

@property (nonatomic) UIView *SectionheadView;

@property (nonatomic) UIView *SectionFooterView;

@property (nonatomic,assign) DetailCellType cellType;

@property (nonatomic) NSArray *rowArray;

- (instancetype)initWithSectioncellType:(DetailCellType)SectioncellType
                                 RowArray:(NSArray<NSArray *> *)rowArray;

@end
