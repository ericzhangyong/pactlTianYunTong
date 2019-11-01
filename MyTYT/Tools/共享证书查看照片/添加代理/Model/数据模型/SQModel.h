//
//  SQModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QuerybaseModel.h"

@interface SQModel : QuerybaseModel
//title
@property (nonatomic) NSString *title;

- (instancetype)initWithTitle:(NSString *)title;

@end
