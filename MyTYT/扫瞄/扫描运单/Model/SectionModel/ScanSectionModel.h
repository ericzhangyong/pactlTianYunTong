//
//  ScanSectionModel.h
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanModel;

@interface ScanSectionModel : NSObject

@property (nonatomic) ScanModel *scanModel;

@property (nonatomic) NSArray *rowArray;

@property (nonatomic,assign) CGFloat sctionHeadHeight;

@property (nonatomic,assign) CGFloat sctionFootHeight;

@property (nonatomic) UIView *SectionFooterView;

@property (nonatomic) UIView *SectionHeadView;

- (instancetype)initWithScanModel:(ScanModel *)scanModel;

@end
