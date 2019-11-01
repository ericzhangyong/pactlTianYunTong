//
//  ScanCell.m
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanCell.h"
#import "ScanModel.h"
#import "UIImage+UIImage_FLyColor.h"
#import "UIColor+ColorString.h"

@implementation ScanCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.DeleteBtn.layer.cornerRadius = 15;
    self.DeleteBtn.layer.masksToBounds = YES;
    [self.DeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.DeleteBtn setBackgroundImage:[UIImage imageWithColor:NavColor] forState:UIControlStateNormal];
    
    [self.controlImageview setImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#005493"]]];

    
}

- (void)loaddatWithMdoel:(ScanModel *)mdoel{

    self.YDHLable.text = mdoel.waybillno;
    
    //是否可以安检
    [self iscanCheckWithModel:mdoel];
    
    //布控
    [self CheckControlWithModel:mdoel];
    
    //不可安检理由
    [self dontCheckReasonWithModel:mdoel];
    
    [self lastViewShowWithModel:mdoel];
   
}

//是否可以安检
- (void)iscanCheckWithModel:(ScanModel *)model{
    
    if ([model.isCheck isEqualToString:@"1"]) {
        self.YDHLable.textColor = [UIColor colorWithRed:0.212 green:0.671 blue:0.376 alpha:1.00];
        self.statelable.textColor = [UIColor colorWithRed:0.212 green:0.671 blue:0.376 alpha:1.00];
        self.statelable.text = @"可安检";
        
    }else{
        self.YDHLable.textColor = [UIColor colorWithRed:1.000 green:0.494 blue:0.475 alpha:1.00];
        self.statelable.textColor = [UIColor colorWithRed:1.000 green:0.494 blue:0.475 alpha:1.00];
        
        self.statelable.text = @"不可安检";
    }

}

//安检布控
- (void)CheckControlWithModel:(ScanModel *)model{
    
    if (model.iscontrol == NO && model.isABControl == NO) {//没有布控
        self.ContorlView.hidden = YES;
        self.controltop.constant = 0;
        self.controlbottom.constant = 0;
        self.controllable.text = @"";
    }else{
        
        NSString *controlStr = @"";
        
        if (model.iscontrol == YES && model.isABControl == YES) {//都被布控
            controlStr = @"已被安检布控和安保布控";
        }else if (model.iscontrol == YES && model.isABControl == NO){//安检布控
            controlStr = @"已被安检布控";
        }else if (model.iscontrol == NO && model.isABControl == YES){//安保布控
            controlStr = @"已被安保布控";
        }
        
        self.ContorlView.hidden = NO;
        self.controltop.constant = 10;
        self.controlbottom.constant = 10;
        self.controllable.text = controlStr;
    }
    
    
}

//不可安检理由
- (void)dontCheckReasonWithModel:(ScanModel *)model{

    if ([model.msg isEqualToString:@""]) {//不可安检理由为空
        
        self.reasonContant.constant = 0;
        self.botomcontant.constant = 0;
        [self.reasonImageView setImage:[UIImage imageNamed:@""]];
        
        
    }else{
        self.reasonContant.constant = 10;
        self.botomcontant.constant = 10;
        [self.reasonImageView setImage:[UIImage imageWithColor:[UIColor redColor]]];
        
    }
    
    
    self.ReaonLable.text = model.msg;

}

//是否展示最后view
- (void)lastViewShowWithModel:(ScanModel *)model{
    
    self.lastView.hidden = YES;
    self.lastHeight.constant = 0;
//    if (model.iscontrol ==NO && [model.msg isEqualToString:@""]) {
//        self.lastView.hidden = YES;
//        self.lastHeight.constant = 0;
//
//    }else{
//        self.lastView.hidden = NO;
//        self.lastHeight.constant = 10;
//    }
}

@end
