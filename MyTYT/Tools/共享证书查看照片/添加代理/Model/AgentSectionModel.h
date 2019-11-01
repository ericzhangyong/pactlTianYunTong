//
//  AgentSectionModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentSectionModel : NSObject

@property (nonatomic) NSArray *rowArray;

- (instancetype)initWithArray:(NSArray <NSArray *> *)array;

@end
