//
//  ScanHisCell.h
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanHisToryModel;

@interface ScanHisCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *machineLable;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;
@property (weak, nonatomic) IBOutlet UILabel *operaTionManlable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

- (void)loadDataWithModel:(ScanHisToryModel *)model;

@end
