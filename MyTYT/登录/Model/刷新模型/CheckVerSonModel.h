//
//  CheckVerSonModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckVerSonModel : NSObject

@property (nonatomic) NSString *versionCode;

@property (nonatomic) NSString *manefest;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
