//
//  DetailFDAllCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDAllModel;

@interface DetailFDAllCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ALlJSLable;
@property (weak, nonatomic) IBOutlet UILabel *AllWeightLable;

- (void)loaddataWithModel:(FDAllModel *)model;

@end
