//
//  DetailWayBillCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WayBillModel;

@interface DetailWayBillCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *DeleteImageView;
@property (weak, nonatomic) IBOutlet UILabel *WayBillNo;
@property (weak, nonatomic) IBOutlet UILabel *JSNumber;
@property (weak, nonatomic) IBOutlet UILabel *ZLNumber;
@property (weak, nonatomic) IBOutlet UILabel *MdgLable;
@property (weak, nonatomic) IBOutlet UILabel *pmLable;

@property (weak, nonatomic) IBOutlet UILabel *EleLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_eleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ELILable;
@property (weak, nonatomic) IBOutlet UILabel *ELMLable;
@property (weak, nonatomic) IBOutlet UIButton *BZBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DeleteImageConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RightConstant;
//控字
@property (weak, nonatomic) IBOutlet UILabel *label_control;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_labelControl;

//状态
@property (weak, nonatomic) IBOutlet UILabel *label_refResult;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_labelresResult;


- (void)loaddatawithModel:(WayBillModel *)model
            detectionType:(DetectionType)detectionType;

@end
