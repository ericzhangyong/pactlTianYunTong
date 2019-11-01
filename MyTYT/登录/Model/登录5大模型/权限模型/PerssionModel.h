//
//  PerssionModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerssionModel : NSObject

/*
 0 <首检 24小时检测 9610>
 1 首检
 2 24小时检测
 3 9610
 */

@property (nonatomic) NSString *Permissions;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
