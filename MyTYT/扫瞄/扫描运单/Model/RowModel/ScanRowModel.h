//
//  ScanRowModel.h
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScanModel;
@class ScanHisToryModel;

typedef NS_ENUM(NSInteger,ScanRowType) {
    ScanStateRowType,//状态
    ScanHistoryRowType//历史扫描
};

@interface ScanRowModel : NSObject

@property (nonatomic,assign) ScanRowType Type;

@property (nonatomic) ScanModel *scanModel;

@property (nonatomic) ScanHisToryModel *hisModel;

- (instancetype)initWithModel:(id)model;

@end
