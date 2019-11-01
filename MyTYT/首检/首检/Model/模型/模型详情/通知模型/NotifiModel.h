//
//  NotifiModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotifiModel : NSObject

//0未 1已读 点击请求度武器

//machinid id status
@property (nonatomic) NSString *status;

@property (nonatomic) NSString *ID;

@property (nonatomic) NSArray *notifyarray;

@property (nonatomic) NSString *AllTitle;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
