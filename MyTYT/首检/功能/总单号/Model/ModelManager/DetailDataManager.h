//
//  DetailDataManager.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailModel;
@class GPModel;

@interface DetailDataManager : NSObject

@property (nonatomic) NSArray *dataArray;

@property (nonatomic) GPModel *gpModel;

@property (nonatomic) DetailModel *detailModel;

- (instancetype)initWithWith:(DetailModel *)detailModel gpModel:(GPModel *)gpmdoel;
//返回列表所需要的数据类型

@end
