//
//  DetailBookCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailBookCell.h"
#import "DetailBook.h"

@implementation DetailBookCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)loadDataWithModel:(DetailBook *)model{
    
    self.CerLable.text = model.bookNo;
    
    self.TimeLable.text = model.createdDate;
}

@end
