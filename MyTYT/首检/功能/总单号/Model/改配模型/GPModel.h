//
//  GPModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPModel : NSObject

@property (nonatomic,assign) NSInteger ok;

@property (nonatomic) NSString *msg;
//改配信息
@property (nonatomic,assign) BOOL isgp;

- (instancetype)initWithdic:(NSDictionary *)dic;

@end
