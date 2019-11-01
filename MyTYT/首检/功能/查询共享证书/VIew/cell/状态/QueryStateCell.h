//
//  QueryStateCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuerybaseModel;

@interface QueryStateCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *zhhLable;

@property (weak, nonatomic) IBOutlet UIButton *Scanbtn;

@property (weak, nonatomic) IBOutlet UILabel *cerlable;

- (void)loaddataWithBaseModel:(QuerybaseModel *)model;

@end
