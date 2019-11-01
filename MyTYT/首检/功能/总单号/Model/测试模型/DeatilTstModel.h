//
//  DeatilTstModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeatilTstModel : NSObject

//测字
@property (nonatomic) NSString *isFormal;
//正时显示的字
@property (nonatomic) NSString *showWord;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
