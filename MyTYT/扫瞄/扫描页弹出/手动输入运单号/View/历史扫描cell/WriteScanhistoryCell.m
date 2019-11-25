//
//  WriteScanhistoryCell.m
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "WriteScanhistoryCell.h"
#import "ScanHisToryModel.h"
#import "UIColor+ColorString.h"

@implementation WriteScanhistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithRed:0.212 green:0.671 blue:0.376 alpha:1.00];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.operationMachine.adjustsFontSizeToFitWidth = YES;
    self.operationState.adjustsFontSizeToFitWidth = YES;
    
}


- (void)loadDataWithModel:(ScanHisToryModel *)model
                 ScanType:(ScanType)scanVCType{
    
    
    self.operationtime.text = model.HisTime;
    
    self.operationState.text = model.HisState;
    
    self.operationMan.text = model.HisOperationMan;
    
    self.operationMachine.text =[NSString stringWithFormat:@"已扫描安检机:%@",model.HisOpertionMachine];
    
    if ([model.HisState isEqualToString:@"通过"]) {//通过颜色变化
        [self.operationState setTextColor:[UIColor whiteColor]];
    }else{
        [self.operationState setTextColor:[UIColor colorWithHexString:@"#005493"]];
    }
}

@end
