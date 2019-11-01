//
//  newYDCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newYDCell.h"
#import "NewBZModel.h"

@implementation newYDCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;

    self.EleLable.layer.cornerRadius = 10;
    self.EleLable.layer.masksToBounds = YES;
    self.EleLable.backgroundColor =  [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
}

- (void)loaddataWithModel:(NewBZModel *)model{
    
    self.ydLable.text = model.waybill_no;
    
    if ([model.wb_ele isEqualToString:@"1"]) {//电子运单
        self.EleLable.hidden = NO;
    }else{
        self.EleLable.hidden = YES;

    }
}

@end
