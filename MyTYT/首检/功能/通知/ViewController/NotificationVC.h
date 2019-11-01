//
//  NotificationVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NotifyBlock)(NSArray *notifiarray);

@interface NotificationVC : UIViewController

@property (nonatomic) NSString *YDH;

@property (nonatomic) NSString *MachID;

@property (nonatomic) NSArray *notifiarray;

@property (nonatomic,copy) NotifyBlock block;

@end
