//
//  CheckBillSelectedCell.m
//  MyTYT
//
//  Created by zhangyong on 2019/11/4.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CheckBillSelectedCell.h"

@implementation CheckBillSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.btn_selected  setBackgroundColor:[UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

}


- (IBAction)actionDidSelect:(id)sender {
    
    if (self.selectedBlock) {
        self.selectedBlock(YES);
    }
}


@end
