//
//  TestModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

//状态
@property (nonatomic,assign) NSInteger ok;
//状态描述
@property (nonatomic) NSString *msg;

//测试字
@property (nonatomic) NSString *regVal;

- (instancetype)initWirhDic:(NSDictionary *)dic;

@end
