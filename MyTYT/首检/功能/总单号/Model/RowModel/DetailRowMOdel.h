//
//  DetailRowMOdel.h
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailBook;
@class infoModel;
@class CheckModel;
@class WayBillModel;
@class FDAllModel;

typedef NS_ENUM(NSInteger,RowCellType) {
    RowInfoCellType,//详情
    RowFDCellType,//分单
    RowCerCellType,//证书
    RowCehckTYpe,//安检
    RowCerFDALLCellType//分单总计
};

@interface DetailRowMOdel : NSObject

//数据行
@property (nonatomic,assign) NSInteger dataRow;

@property (nonatomic,assign) RowCellType rowType;

@property (nonatomic) DetailBook *bookModel;

@property (nonatomic) infoModel *infomdoel;

@property (nonatomic) CheckModel *checmodel;

@property (nonatomic) WayBillModel *waymodel;

@property (nonatomic) FDAllModel *allmodel;

- (instancetype)initWithModel:(id)model;

@end
