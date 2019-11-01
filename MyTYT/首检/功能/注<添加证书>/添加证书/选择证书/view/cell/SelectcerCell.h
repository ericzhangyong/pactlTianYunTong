//
//  SelectcerCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectCerModel;

@interface SelectcerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIImageView *selectimageView;

- (void)loadDataWithModel:(SelectCerModel *)model isselet:(BOOL)isselect;

@end
