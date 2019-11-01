//
//  ShowCerModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowCerModel : NSObject

@property (nonatomic) NSString *title;

@property (nonatomic) NSString *content;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

@end
