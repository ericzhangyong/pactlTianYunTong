//
//  LoginModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

//token
@property (nonatomic) NSString *token;
//个人所有信息
@property (nonatomic) NSDictionary *user;
//个人ID
@property (nonatomic,assign) NSInteger PersonID;
//部门ID
@property (nonatomic,assign) NSInteger dept_id;
//个人全名
@property (nonatomic) NSString *FullName;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
