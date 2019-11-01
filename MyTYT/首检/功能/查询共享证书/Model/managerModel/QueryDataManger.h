//
//  QueryDataManger.h
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SelectCerModel;
@class QueryCerStateModel;

@interface QueryDataManger : NSObject

@property (nonatomic) SelectCerModel *cermodel;

@property (nonatomic) NSArray *sectionArray;

@property (nonatomic) QueryCerStateModel *stateModel;

@property (nonatomic) NSArray *AgentArray;

- (instancetype)initWithModel:(SelectCerModel *)Model;

- (instancetype)initBaseData;

@end
