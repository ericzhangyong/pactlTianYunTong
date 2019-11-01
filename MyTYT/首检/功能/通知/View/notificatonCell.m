//
//  notificatonCell.m
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "notificatonCell.h"
#import "NotifiModel.h"

@implementation notificatonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loaddataWithModel:(NotifiModel *)model{
    
    self.notifiactionLable.text = model.AllTitle;
    
    if ([model.status isEqualToString:@"1"]) {
        self.notificationimageview.image = [UIImage imageNamed:@"haveread"];
    }else if([model.status isEqualToString:@"0"]){
        self.notificationimageview.image = [UIImage imageNamed:@"noready"];
    }
}

@end
