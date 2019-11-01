//
//  QueryRowModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectCerModel;
@class QueryCerStateModel;
@class QuerybaseModel;

typedef NS_ENUM(NSInteger,QueryCellType) {
    RowCerStateType,//证书
    RowAgentType,//代理
    RowImageType,//图片
    RowSQDLType//授权代理
};

@interface QueryRowModel : NSObject

@property (nonatomic,assign) NSInteger dataRow;

@property (nonatomic,assign) QueryCellType cellType;

@property (nonatomic,assign) CGSize itemSize;

@property (nonatomic) QuerybaseModel *model;

- (instancetype)initWithModel:(QuerybaseModel *)model;

@end
