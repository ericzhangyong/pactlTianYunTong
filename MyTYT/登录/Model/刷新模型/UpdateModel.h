//
//  UpdateModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CheckVerSonModel;

@interface UpdateModel : NSObject

@property (nonatomic) NSString *msg;

@property (nonatomic,assign) NSInteger ok;

@property (nonatomic) CheckVerSonModel *verSonModel;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
