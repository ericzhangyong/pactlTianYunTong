//
//  MyNeedInfo.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "MyNeedInfo.h"

@implementation MyNeedInfo

+ (instancetype)shareInstace{
    
    static MyNeedInfo *shareintance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareintance = [[self alloc] init];
    });
    return shareintance;
}

- (NSString *)getUUID{
  return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
