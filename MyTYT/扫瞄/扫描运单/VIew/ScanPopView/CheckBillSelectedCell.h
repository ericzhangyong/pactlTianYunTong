//
//  CheckBillSelectedCell.h
//  MyTYT
//
//  Created by zhangyong on 2019/11/4.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckBillSelectedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_fendanHao;
@property (weak, nonatomic) IBOutlet UILabel *label_allBillNum;
@property (weak, nonatomic) IBOutlet UILabel *label_daiLI;
@property (weak, nonatomic) IBOutlet UIButton *btn_selected;
@property (weak, nonatomic) IBOutlet UILabel *label_control;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidht_labelControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft_labelControl;

@property (weak, nonatomic) IBOutlet UILabel *label_reResult;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_reResult;

@property (nonatomic,copy) void(^selectedBlock)(BOOL isSelect);


@end

NS_ASSUME_NONNULL_END
