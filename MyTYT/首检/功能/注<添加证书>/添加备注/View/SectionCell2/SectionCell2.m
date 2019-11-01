//
//  SectionCell2.m
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SectionCell2.h"
#import "UIImage+UIImage_FLyColor.h"
#import "BZAddModel.h"
#import "UIButton+WebCache.h"


@implementation SectionCell2

- (void)awakeFromNib {
    [super awakeFromNib];

 
    self.addBtn.layer.cornerRadius = 17.5;
    self.addBtn.layer.masksToBounds = YES;
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.953 green:0.639 blue:0.012 alpha:1.00]] forState:UIControlStateNormal];

}

- (void)loaddataWithModel:(BZAddModel *)model{
    
  
    if ([model.content isEqualToString:@"请输入内容"]) {
        self.textVIew.textColor = [UIColor grayColor];
    }else{
        self.textVIew.textColor = [UIColor blackColor];

    }
    
    self.textVIew.text = model.content;
    
}

@end
