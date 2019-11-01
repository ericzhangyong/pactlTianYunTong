//
//  newBzPMCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newBzPMCell.h"
#import "NewBZModel.h"

@implementation newBzPMCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;
    
    self.pmlable.adjustsFontSizeToFitWidth = YES;

}

- (void)loaddataWithModel:(NewBZModel *)model{

    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.goods_desc] attributes:@{}];
    
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
    
    self.pmlable.attributedText = attribute;
}

@end
