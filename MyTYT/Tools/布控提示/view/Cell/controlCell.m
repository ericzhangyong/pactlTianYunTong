//
//  controlCell.m
//  MyTYT
//
//  Created by Fly on 2018/8/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "controlCell.h"
#import "ControlModel.h"

@implementation controlCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadDataWithModel:(ControlModel *)model{
    
    NSString *str;
    
    if (model.IsControl == YES && model.IsABControl == YES) {
        
    str = [[NSString alloc] initWithFormat:@"运单号:%@已被安检布控和安保布控",model.YDH];

    }else if (model.IsControl == YES && model.IsABControl == NO){
        str = [[NSString alloc] initWithFormat:@"运单号:%@已被安检布控",model.YDH];

    }else if (model.IsControl == NO && model.IsABControl == YES){
        str = [[NSString alloc] initWithFormat:@"运单号:%@已被安保布控",model.YDH];
    }
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    
    para.lineSpacing = 5;
    
    para.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attibute = [[NSMutableAttributedString alloc] initWithString:str attributes:@{
                                                                                                                   NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                                                                   NSParagraphStyleAttributeName:para
                                                                                                                   }];

    [attibute addAttribute:NSForegroundColorAttributeName value:NavColor range:NSMakeRange(4, 12)];


    self.controlLable.attributedText = attibute;
    

}

@end
