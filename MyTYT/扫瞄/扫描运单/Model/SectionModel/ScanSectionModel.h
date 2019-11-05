//
//  ScanSectionModel.h
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanModel.h"


@interface ScanSectionModel : NSObject

@property (nonatomic) ScanBillModel *scanModel;

@property (nonatomic) NSArray *rowArray;

@property (nonatomic,assign) CGFloat sctionHeadHeight;

@property (nonatomic,assign) CGFloat sctionFootHeight;

@property (nonatomic) UIView *SectionFooterView;

@property (nonatomic) UIView *SectionHeadView;

- (instancetype)initWithScanModel:(ScanBillModel *)scanModel;

@end
