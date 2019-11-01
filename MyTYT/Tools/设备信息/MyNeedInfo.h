//
//  MyNeedInfo.h
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNeedInfo : NSObject

+ (instancetype)shareInstace;

//设备ID
- (NSString *)getUUID;

@end
