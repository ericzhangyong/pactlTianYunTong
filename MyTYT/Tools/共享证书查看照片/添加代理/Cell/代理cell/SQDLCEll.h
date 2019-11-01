//
//  SQDLCEll.h
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuerybaseModel;

@interface SQDLCEll : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lable;

- (void)loaddataWithModel:(QuerybaseModel *)model;

@end
