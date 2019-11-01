//
//  QueryAgentCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuerybaseModel;

@interface QueryAgentCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *agentLable;

- (void)loaddataWithBaseModel:(QuerybaseModel *)model;

@end
