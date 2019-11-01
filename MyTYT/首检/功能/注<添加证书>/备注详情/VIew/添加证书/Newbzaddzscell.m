//
//  Newbzaddzscell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "Newbzaddzscell.h"

@implementation Newbzaddzscell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00];
    
    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;
}

@end
