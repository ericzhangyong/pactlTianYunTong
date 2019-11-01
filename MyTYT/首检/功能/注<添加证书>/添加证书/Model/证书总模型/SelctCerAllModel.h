//
//  SelctCerAllModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelctCerAllModel : NSObject

@property (nonatomic) NSString *msg;

@property (nonatomic,assign) NSInteger ok;

@property (nonatomic) NSArray *array;

- (instancetype)initWithdic:(NSDictionary *)dic;

@end
