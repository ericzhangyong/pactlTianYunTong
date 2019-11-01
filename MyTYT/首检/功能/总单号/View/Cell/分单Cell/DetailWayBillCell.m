//
//  DetailWayBillCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailWayBillCell.h"
#import "WayBillModel.h"

@implementation DetailWayBillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.BZBtn.layer.cornerRadius = 5;
    self.BZBtn.layer.masksToBounds = YES;
    
    self.EleLable.layer.masksToBounds = YES;
    self.EleLable.layer.cornerRadius = 10;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}



- (void)loaddatawithModel:(WayBillModel *)model{
    
    
    [self setELWithModel:model];
    
    [self setBZWithModel:model];
    
    [self setDeleteImageViewWithModel:model];
    
    [self setEleWithModel:model];
    
    [self setOtherWithModel:model];
    
}

//其他字符
- (void)setOtherWithModel:(WayBillModel *)model{
    
    self.WayBillNo.text = model.waybill_no;
    self.JSNumber.text = [[NSString alloc] initWithFormat:@"%@",model.total_count.stringValue];
    self.ZLNumber.text = [[NSString alloc] initWithFormat:@"%@",model.gross_weight.stringValue];
    self.MdgLable.text = model.dest1;
    
}

//设置下拉差号
- (void)setDeleteImageViewWithModel:(WayBillModel *)model{
    
    if ([model.ref_status isEqualToString:@"1"]) {
        
        self.RightConstant.constant = 10;
        self.DeleteImageConstant.constant = 25;
        self.backgroundColor = [UIColor colorWithRed:0.753 green:0.753 blue:0.753 alpha:1.00];
        
    }else{
        self.RightConstant.constant = 0;
        self.DeleteImageConstant.constant = 0;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
}

//电子运单
- (void)setEleWithModel:(WayBillModel *)model{
    
    if ([model.wb_ele isEqualToString:@"1"]) {
        self.EleLable.hidden = NO;
    }else{
        self.EleLable.hidden = YES;
    }
    
}

//ELI ELM 品名
- (void)setELWithModel:(WayBillModel *)model{
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.goods_name_cn] attributes:@{}];
   
    
    NSMutableAttributedString *ELI;
    NSMutableAttributedString *ELM;

    if ([model.eli_flag isEqualToString:@"1"]) {

        [attribute appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" " attributes:nil]];

        ELI = [[NSMutableAttributedString alloc] initWithString:@"ELI" attributes:@{
                                                                                    NSBackgroundColorAttributeName:ELICOlor,
                                                                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:20],

                                                                                    NSLigatureAttributeName:[NSNumber numberWithInt:1],
                                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                    }];
        [attribute appendAttributedString:ELI];


    }



    if ([model.elm_flag isEqualToString:@"1"]) {



        [attribute appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" " attributes:nil]];

        ELM = [[NSMutableAttributedString alloc] initWithString:@"ELM" attributes:@{
                                                                                    NSBackgroundColorAttributeName:ELICOlor,
                                                                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                                    NSLigatureAttributeName:[NSNumber numberWithInt:1], NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                    }];


        [attribute appendAttributedString:ELM];

    }
    
    
    self.pmLable.attributedText = attribute;
    
}


//备注
- (void)setBZWithModel:(WayBillModel *)mdoel{
    
    if ([mdoel.count_remark isEqualToString:@"0"]) {//没有备注
        [self.BZBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
        [self.BZBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
    }else{
        self.BZBtn.backgroundColor = BZCOlor;
        [self.BZBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
}

@end
