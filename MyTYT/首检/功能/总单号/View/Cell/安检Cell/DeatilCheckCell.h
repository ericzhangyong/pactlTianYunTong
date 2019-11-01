//
//  DeatilCheckCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckModel;

@interface DeatilCheckCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *operatime;
@property (weak, nonatomic) IBOutlet UILabel *opearMan;

@property (weak, nonatomic) IBOutlet UILabel *CheckStatus;

- (void)loadDataWithModel:(CheckModel *)model;
@end
