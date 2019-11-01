//
//  NotifyViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NotiFySuccessBlock)(void);
typedef void(^NotiFyFailBlock)(NSString *failStr);

@class NotifiModel;

@interface NotifyViewModel : NSObject

- (void)notifyWithModel:(NotifiModel *)model MachID:(NSString *)MAchID success:(NotiFySuccessBlock)success fail:(NotiFyFailBlock)fail;

@end
