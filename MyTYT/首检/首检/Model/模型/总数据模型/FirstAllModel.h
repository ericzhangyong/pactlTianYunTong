//
//  FirstAllCount.h
//  MyTYT
//
//  Created by Fly on 2018/4/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstAllModel : NSObject

@property (nonatomic,assign) NSInteger ok;

@property (nonatomic) NSString *msg;

@property (nonatomic) NSMutableArray *dataarray;

- (instancetype)initWIthDic:(NSDictionary *)dic;

@end
