//
//  newbzkongcell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newbzkongcell.h"

@implementation newbzkongcell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.borderColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00].CGColor;
    self.layer.borderWidth = 0.6;

}

@end
