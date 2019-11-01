//
//  ScanHisCell.m
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanHisCell.h"
#import "ScanHisToryModel.h"
#import "UIColor+ColorString.h"

@implementation ScanHisCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.contentView.backgroundColor = [UIColor colorWithRed:0.212 green:0.671 blue:0.376 alpha:1.00];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)loadDataWithModel:(ScanHisToryModel *)model{
    
    self.timeLable.text = model.HisTime;
    
    self.stateLable.text = model.HisState;
    
    self.operaTionManlable.text = model.HisOperationMan;
    
    self.machineLable.text =[NSString stringWithFormat:@"已扫描安检机:%@",model.HisOpertionMachine];
    
    if ([model.HisState isEqualToString:@"通过"]) {//通过颜色变化
        [self.stateLable setTextColor:[UIColor whiteColor]];
    }else{
        [self.stateLable setTextColor:[UIColor colorWithHexString:@"#005493"]];
    }
}

@end
