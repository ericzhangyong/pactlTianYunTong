//
//  ScanCell.h
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanModel;

@interface ScanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *YDHLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagetopcontant;

@property (weak, nonatomic) IBOutlet UIButton *DeleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *statelable;
@property (weak, nonatomic) IBOutlet UILabel *ReaonLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reasonContant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botomcontant;
@property (weak, nonatomic) IBOutlet UIImageView *reasonImageView;
@property (weak, nonatomic) IBOutlet UIView *reaonView;

@property (weak, nonatomic) IBOutlet UIView *ContorlView;
@property (weak, nonatomic) IBOutlet UIImageView *controlImageview;
@property (weak, nonatomic) IBOutlet UILabel *controllable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controltop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controlbottom;

@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastHeight;

- (void)loaddatWithMdoel:(ScanModel *)mdoel;

@end
