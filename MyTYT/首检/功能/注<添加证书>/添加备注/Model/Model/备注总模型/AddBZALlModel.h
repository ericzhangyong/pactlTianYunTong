//
//  AddBZALlModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddBZALlModel : NSObject

@property (nonatomic,assign) NSInteger ok;

@property (nonatomic) NSString *msg;

@property (nonatomic) NSArray *dataarray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
