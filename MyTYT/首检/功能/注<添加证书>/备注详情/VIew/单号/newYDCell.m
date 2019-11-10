//
//  newYDCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newYDCell.h"
#import "NewBZModel.h"
#import "NSString+RECategory.h"

@interface newYDCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_labelEle;

@end
@implementation newYDCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;

    self.EleLable.layer.cornerRadius = 10;
    self.EleLable.layer.masksToBounds = YES;
    self.EleLable.backgroundColor =  [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
}

- (void)loaddataWithModel:(NewBZModel *)model
            detectionType:(DetectionType)detectionType{
    
    self.ydLable.text = model.waybill_no;
    
    
    if ([model.wb_ele isEqualToString:@"1"]) {//电子运单
        self.EleLable.hidden = NO;
        self.layoutWidth_labelEle.constant = 20;
    }else{
        self.EleLable.hidden = YES;
        self.layoutWidth_labelEle.constant = 0;
    }
    
    
    self.label_control.hidden = YES;
       self.label_refResult.hidden = YES;
       self.layoutWidth_labelControl.constant = 0;
       self.layoutWidth_labelresResult.constant = 0;
       if (detectionType == DetectionType9610System) {
           
           
           if (![BaseVerifyUtils isNullOrSpaceStr:model.securityCheckResult]) {
               self.label_control.hidden = NO;
               self.layoutWidth_labelControl.constant = 20;
               self.label_control.backgroundColor = [UIColor colorWithHexString:model.securityCheckResultColor];
           }

           if (![BaseVerifyUtils isNullOrSpaceStr:model.refResult]) {
               self.label_refResult.hidden = NO;
               //通过pass 不合格 unqualified   暂扣 hold
                  NSString *title = @"通过";
                  if ([model.refResult isEqualToString:@"pass"]) {
                      title = @"通过";
                  }else if ([model.refResult isEqualToString:@"unqualified"]){
                      title = @"不合格";
                  }else if ([model.refResult isEqualToString:@"hold"]){
                      title = @"暂扣";
                  }
               CGFloat width = [title widthWithFont:[UIFont systemFontOfSize:13]]+8;
               self.layoutWidth_labelresResult.constant = width;
                  self.label_refResult.text = title;
               self.label_refResult.backgroundColor = [UIColor colorWithHexString:model.securityCheckResultColor];
           }
       }
    
}


@end
