//
//  FlyAleartCell.m
//  WHT
//
//  Created by Fly on 2018/4/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FlyAleartCell.h"

@implementation FlyAleartCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.backgroundColor = NavColor;
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
