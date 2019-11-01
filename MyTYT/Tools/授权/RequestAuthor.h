//
//  RequestAuthor.h
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RequestAllow)(void);
typedef void(^RequestDeny)(void);

@interface RequestAuthor : NSObject

+ (instancetype)shareInstance;

//请求相机权限
- (void)requestAVMediaTypeVideoWithAllow:(RequestAllow)allow deny:(RequestDeny)deny withVC:(UIViewController *)VC;

@end
