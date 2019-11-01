//
//  WriteScanCell.m
//  MyTYT
//
//  Created by Fly on 2018/6/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "WriteScanCell.h"
#import "ScanModel.h"
#import "UIImage+UIImage_FLyColor.h"
#import "UIColor+ColorString.h"

@implementation WriteScanCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.YDHLAble.adjustsFontSizeToFitWidth = YES;
    self.DLLAble.adjustsFontSizeToFitWidth = YES;
    self.MDGLAble.adjustsFontSizeToFitWidth = YES;
    self.JSZLLAble.adjustsFontSizeToFitWidth = YES;
    self.stateLable.adjustsFontSizeToFitWidth = YES;
  
    [self.controlImageivew setImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#005493"]]];
    self.elelable.layer.masksToBounds = YES;
    self.elelable.layer.cornerRadius = 10;
    
    self.eleimageVIew.layer.masksToBounds = YES;
    self.eleimageVIew.layer.cornerRadius = 10;
    [self.eleimageVIew setImage:[UIImage imageWithColor: [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00]]];


}


- (void)loaddataWithModel:(ScanModel *)model row:(NSInteger)row{
    
    //序号
    self.XHLAble.text = [NSString stringWithFormat:@"%ld",row+1];
    
    //运单号
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", model.waybillno];
    
    [str insertString:@"-" atIndex:3];
    
    self.YDHLAble.text = str;
    
    //代理
    self.DLLAble.text = [model.agentShortName isEqualToString:@""] ? model.agentOprn : model.agentShortName;
        
    //目的港
    self.MDGLAble.text = model.airportDest;
    
    //件数重量
    self.JSZLLAble.text = [NSString stringWithFormat:@"%@ / %@",model.rcpNo,model.grossWeight];
    
    //安检状态
    if ([model.isCheck isEqualToString:@"1"]) {
        self.stateLable.textColor = [UIColor colorWithRed:0.212 green:0.671 blue:0.376 alpha:1.00];
        self.stateLable.textColor = [UIColor colorWithRed:0.212 green:0.671 blue:0.376 alpha:1.00];
        self.stateLable.text = @"可安检";
        
    }else{
        self.stateLable.textColor = [UIColor colorWithRed:1.000 green:0.494 blue:0.475 alpha:1.00];
        self.stateLable.textColor = [UIColor colorWithRed:1.000 green:0.494 blue:0.475 alpha:1.00];
        
        self.stateLable.text = @"不可安检";
    }
    
    //电子运单
    [self eleEventWithModel:model];

    //布控
    [self CheckControlWithModel:model];
    
    //不可安检理由
    [self dontCheckReasonWithModel:model];
  
    [self lastViewShowWithModel:model];
}

//电子运单
- (void)eleEventWithModel:(ScanModel *)model{
    
    if ([model.Ele isEqualToString:@"1"]) {
        self.elelable.hidden = NO;
        self.eleimageVIew.hidden = NO;
    }else{
        self.elelable.hidden = YES;
        self.eleimageVIew.hidden = YES;
    }
}


//安检布控
- (void)CheckControlWithModel:(ScanModel *)model{
   
    if (model.iscontrol == NO && model.isABControl == NO) {//没有布控
        self.controlBackView.hidden = YES;
        self.controlLableTop.constant = 0;
        self.controllableBootom.constant = 0;
        self.controlLable.text = @"";
    }else{
        
        NSString *controlStr = @"";
        
        if (model.iscontrol == YES && model.isABControl == YES) {//都被布控
            controlStr = @"已被安检布控和安保布控";
        }else if (model.iscontrol == YES && model.isABControl == NO){//安检布控
            controlStr = @"已被安检布控";
        }else if (model.iscontrol == NO && model.isABControl == YES){//安保布控
            controlStr = @"已被安保布控";
        }
        
        self.controlBackView.hidden = NO;
        self.controlLableTop.constant = 10;
        self.controllableBootom.constant = 10;
        self.controlLable.text = controlStr;
    }
    
}

//不可安检理由
- (void)dontCheckReasonWithModel:(ScanModel *)model{
    
    if ([model.msg isEqualToString:@""]) {//不可安检理由为空
        
        self.lableTopConstant.constant = 0;
        self.lableBootomConstant.constant = 0;
        [self.BackImageView setImage:[UIImage imageNamed:@""]];

        
    }else{
        self.lableTopConstant.constant = 10;
        self.lableBootomConstant.constant = 10;
        [self.BackImageView setImage:[UIImage imageWithColor:[UIColor redColor]]];

    }
    
    self.MSGLable.text = model.msg;
    
}

//是否展示最后view
- (void)lastViewShowWithModel:(ScanModel *)model{
    
    self.lastView.hidden = YES;
    self.lastHeight.constant = 0;
//    if (model.iscontrol ==NO && [model.msg isEqualToString:@""] ) {
//        self.lastView.hidden = YES;
//        self.lastHeight.constant = 0;
//
//    }else{
//        self.lastView.hidden = NO;
//        self.lastHeight.constant = 10;
//    }
}
@end
