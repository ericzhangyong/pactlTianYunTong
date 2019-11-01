//
//  AgentRowModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuerybaseModel;

typedef NS_ENUM(NSInteger,AgentCellTYpe) {
    SQRowCell,//授权代理
    AgentRowCell//代理
};

@interface AgentRowModel : NSObject

@property (nonatomic,assign) AgentCellTYpe cellType;

@property (nonatomic) QuerybaseModel *baseModel;

@property (nonatomic) NSInteger dataRow;

- (instancetype)initWithModel:(QuerybaseModel *)model;

@end
