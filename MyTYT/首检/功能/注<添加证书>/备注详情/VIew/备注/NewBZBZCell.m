//
//  NewBZBZCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NewBZBZCell.h"
#import "NewBZModel.h"

@implementation NewBZBZCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;

    self.bzBtn.layer.cornerRadius = 5;
    self.bzBtn.layer.masksToBounds = YES;
}

- (void)loaddataWithModel:(NewBZModel *)mdoel{
  
    if ([mdoel.count_remark isEqualToString:@"0"]) {//没有备注
        [self.bzBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
        [self.bzBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
    }else{
        self.bzBtn.backgroundColor = BZCOlor;
        [self.bzBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
}

@end
