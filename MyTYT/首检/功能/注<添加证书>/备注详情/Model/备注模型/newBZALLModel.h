//
//  newBZALLModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newBZALLModel : NSObject

@property (nonatomic,assign) NSInteger ok;

@property (nonatomic) NSString *msg;

@property (nonatomic) NSArray *array;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
