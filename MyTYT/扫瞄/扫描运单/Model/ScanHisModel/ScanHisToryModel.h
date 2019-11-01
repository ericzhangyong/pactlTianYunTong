//
//  ScanHisToryModel.h
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanHisToryModel : NSObject

//操作机器
@property (nonatomic) NSString *HisOpertionMachine;
//操作状态
@property (nonatomic) NSString *HisState;
//操作人
@property (nonatomic) NSString *HisOperationMan;
//操作时间
@property (nonatomic) NSString *HisTime;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
