//
//  controlCell.h
//  MyTYT
//
//  Created by Fly on 2018/8/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ControlModel;

@interface controlCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *controlLable;

- (void)loadDataWithModel:(ControlModel *)model;

@end
