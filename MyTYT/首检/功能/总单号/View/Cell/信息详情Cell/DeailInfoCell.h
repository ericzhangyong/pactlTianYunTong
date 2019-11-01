//
//  DeailInfoCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class infoModel;

@interface DeailInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *HBLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *FHRLable;
@property (weak, nonatomic) IBOutlet UILabel *SHRLable;
@property (weak, nonatomic) IBOutlet UILabel *JSlable;
@property (weak, nonatomic) IBOutlet UILabel *JFZLLable;
@property (weak, nonatomic) IBOutlet UILabel *TJLable;
@property (weak, nonatomic) IBOutlet UILabel *MDGLable;
@property (weak, nonatomic) IBOutlet UILabel *PMLable;
@property (weak, nonatomic) IBOutlet UILabel *ELILable;
@property (weak, nonatomic) IBOutlet UILabel *ELMLable;
@property (weak, nonatomic) IBOutlet UILabel *THDMLable;
@property (weak, nonatomic) IBOutlet UILabel *InfomationLable;

@property (weak, nonatomic) IBOutlet UILabel *ZLLable;
@property (weak, nonatomic) IBOutlet UIButton *BZBtn;
@property (weak, nonatomic) IBOutlet UILabel *INLable;

- (void)loaddataWithInfomationModel:(infoModel *)model remakcount:(NSInteger)count;

@end

