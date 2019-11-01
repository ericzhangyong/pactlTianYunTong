//
//  TwentyForuHourRoadModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwentyForuHourRoadModel : NSObject

@property (nonatomic,assign) NSInteger totolRoadCount;

@property (nonatomic) NSArray *roadArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
