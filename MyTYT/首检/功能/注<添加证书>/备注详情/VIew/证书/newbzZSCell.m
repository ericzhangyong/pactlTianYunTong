//
//  newbzZSCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newbzZSCell.h"
#import "BZCerModel.h"

@implementation newbzZSCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;
}

- (void)loaddataWithModel:(BZCerModel *)model{
    
    
    if ([model.checkVisual isEqualToString:@"1"]) {//证书可见
        self.ZSImgBtn.hidden = NO;
        self.ZSTitleBtn.hidden = NO;
    }else{
        self.ZSImgBtn.hidden = YES;
        self.ZSTitleBtn.hidden = YES;
    }
    
    
//    if ([model.deviceId isEqualToString:@"1"] || [model.checkVisual isEqualToString:@"1"]) {//删除可见
//        self.deleteBtn.hidden = NO;
//    }else{
//        self.deleteBtn.hidden = YES;
//    }
    
    self.deleteBtn.hidden = YES;//删除一直隐藏

    
    [self.ZSTitleBtn setTitle:model.bookNo forState:UIControlStateNormal];
}

@end
