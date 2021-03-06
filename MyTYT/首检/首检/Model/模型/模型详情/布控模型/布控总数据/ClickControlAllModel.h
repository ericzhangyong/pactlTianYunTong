//
//  ClickControlAllModel.h
//  MyTYT
//
//  Created by Fly on 2019/3/27.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClickControlAllModel : NSObject

@property (nonatomic) NSArray *array;

@property (nonatomic) NSString *msg;

@property (nonatomic,assign) NSInteger ok;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
