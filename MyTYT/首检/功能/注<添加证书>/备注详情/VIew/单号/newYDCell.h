//
//  newYDCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewBZModel;

@interface newYDCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *EleLable;
@property (weak, nonatomic) IBOutlet UILabel *ydLable;

@property (weak, nonatomic) IBOutlet UILabel *label_control;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_labelControl;

//状态
@property (weak, nonatomic) IBOutlet UILabel *label_refResult;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_labelresResult;


- (void)loaddataWithModel:(NewBZModel *)model detectionType:(DetectionType)detectionType;

@end
