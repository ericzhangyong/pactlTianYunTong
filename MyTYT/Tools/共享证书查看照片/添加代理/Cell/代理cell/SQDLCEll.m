//
//  SQDLCEll.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SQDLCEll.h"
#import "SQModel.h"

@implementation SQDLCEll

- (void)loaddataWithModel:(QuerybaseModel *)model{
    
    SQModel *sqmodl = (SQModel *)model;
    
    self.lable.text = sqmodl.title;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
