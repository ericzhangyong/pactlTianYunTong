//
//  ShowCerDataModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CerNeedDataModel;

@interface ShowCerDataModel : NSObject

@property (nonatomic) CerNeedDataModel *mdoel;

@property (nonatomic) NSArray *datararay;

- (instancetype)initWithStr:(NSString *)CerStr state:(NSString *)state model:(CerNeedDataModel *)model;

@end
