//
//  DeailInfoCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DeailInfoCell.h"
#import "infoModel.h"

@interface DeailInfoCell ()

@property (nonatomic,assign) DetectionType detectionType;

@end
@implementation DeailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.BZBtn.layer.masksToBounds = YES;
    self.BZBtn.layer.cornerRadius = 5;
    
    self.THDMLable.adjustsFontSizeToFitWidth = YES;
    self.INLable.adjustsFontSizeToFitWidth = YES;
    self.TJLable.adjustsFontSizeToFitWidth = YES;
}

- (void)loaddataWithInfomationModel:(infoModel *)model
                         remakcount:(NSInteger)count
                        dectionType:(DetectionType)detectionType{

    self.detectionType = detectionType;
    [self setOtherWithModel:model];
    
    [self setELWithModel:model];
    
    [self setBZWithCount:count];
    
    [self setInfoMationWithModel:model];
    
}

//其他
- (void)setOtherWithModel:(infoModel *)model{
    self.HBLable.text = model.flightNo;
    
    self.dateLable.text = model.fltDate;
    
    self.FHRLable.text = model.spName;
    
    self.SHRLable.text = model.csName;
    
    self.JSlable.text = [[NSString alloc] initWithFormat:@"%@",model.rcpNo.stringValue];
    
    self.ZLLable.text = [[NSString alloc] initWithFormat:@"%@",model.grossWeight.stringValue];
    
    self.JFZLLable.text = [[NSString alloc] initWithFormat:@"%@",model.chargeWeight.stringValue];
    
    self.TJLable.text = [[NSString alloc] initWithFormat:@"%@",model.vol.stringValue];
    
    self.MDGLable.text = model.airportDest;
        
    self.THDMLable.text = model.holdCode;
}

//infomation
- (void)setInfoMationWithModel:(infoModel *)model{
    
    if (![model.ssr isEqualToString:@""] && ![model.osi1 isEqualToString:@""]) {
        
         self.InfomationLable.text = [NSString stringWithFormat:@"%@\n%@",model.ssr,model.osi1];
    }else{
        self.InfomationLable.text = [NSString stringWithFormat:@"%@%@",model.ssr,model.osi1];
    }
    
   
}

//ELI ELM 品名
- (void)setELWithModel:(infoModel *)model{
    
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.goodsDesc] attributes:@{}];
    
    NSMutableAttributedString *ELI;
    NSMutableAttributedString *ELM;
    
    if ([model.eliFlag isEqualToString:@"1"]) {
        
        [attribute appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" " attributes:nil]];
        
        ELI = [[NSMutableAttributedString alloc] initWithString:@"ELI" attributes:@{
                                                                                    NSBackgroundColorAttributeName:ELICOlor,
                                                                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                                    NSLigatureAttributeName:[NSNumber numberWithInt:1],
                                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                    }];
        [attribute appendAttributedString:ELI];
        
        
    }
    
    
    
    if ([model.elmFlag isEqualToString:@"1"]) {
        
        [attribute appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" " attributes:nil]];
        
        ELM = [[NSMutableAttributedString alloc] initWithString:@"ELM" attributes:@{
                                                                                    NSBackgroundColorAttributeName:ELICOlor,
                                                                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                                    NSLigatureAttributeName:[NSNumber numberWithInt:1], NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                    }];
        [attribute appendAttributedString:ELM];
        
    }
    
    self.PMLable.attributedText = attribute;
    
    if (self.detectionType == DetectionType9610System) {
        self.view_chPinMing.hidden = YES;
        self.layoutHeight_chPinMing.constant = 0;
    }else{
        self.view_chPinMing.hidden = NO;
        self.layoutHeight_chPinMing.constant = 50;
        self.label_chPinMingContent.text = model.goodsNameCn;
    }
    
}

//备注
- (void)setBZWithCount:(NSInteger)count{
    
    if (count == 0) {//没有备注
        [self.BZBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
        [self.BZBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
    }else{
        self.BZBtn.backgroundColor = BZCOlor;
        [self.BZBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

@end
