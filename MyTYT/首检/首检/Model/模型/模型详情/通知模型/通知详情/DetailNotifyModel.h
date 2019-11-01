//
//  DetailNotifyModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailNotifyModel : NSObject


//测试详情
@property (nonatomic) NSString *name;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
