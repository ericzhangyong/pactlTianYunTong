//
//  ExplainRoadCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoadModel;

@interface ExplainRoadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Roadname;
@property (weak, nonatomic) IBOutlet UILabel *roadRemark;

- (void)loaddataWithModel:(RoadModel *)model;

@end
