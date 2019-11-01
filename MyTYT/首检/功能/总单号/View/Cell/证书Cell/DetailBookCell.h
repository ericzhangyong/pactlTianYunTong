//
//  DetailBookCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailBook;

@interface DetailBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CerLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;

- (void)loadDataWithModel:(DetailBook *)model;

@end
