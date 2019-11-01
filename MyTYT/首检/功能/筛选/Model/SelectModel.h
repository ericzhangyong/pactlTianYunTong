//
//  SelectModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectModel : NSObject

//代理三字码
@property (nonatomic) NSString *agentName;
//代理简称或者代理
@property (nonatomic) NSString *name;

- (instancetype)initWithAgentName:(NSString *)agentName name:(NSString *)name;

@end
