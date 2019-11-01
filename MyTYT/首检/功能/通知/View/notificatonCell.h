//
//  notificatonCell.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NotifiModel;

@interface notificatonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *notificationimageview;

@property (weak, nonatomic) IBOutlet UILabel *notifiactionLable;

- (void)loaddataWithModel:(NotifiModel *)model;

@end
