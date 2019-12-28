//
//  NewBzChPMCell.m
//  MyTYT
//
//  Created by zhangyong on 2019/12/28.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NewBzChPMCell.h"

@implementation NewBzChPMCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;
    
    self.label_chPinMing.adjustsFontSizeToFitWidth = YES;
    
}

- (void)loaddataWithModel:(NewBZModel *)model{

    
    
    self.label_chPinMing.text = model.goods_name_cn;
}
@end
