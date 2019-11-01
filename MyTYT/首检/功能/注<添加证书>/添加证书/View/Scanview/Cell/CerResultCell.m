//
//  CerResultCell.m
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CerResultCell.h"
#import "ShowCerModel.h"

@implementation CerResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.Mytitlelable.adjustsFontSizeToFitWidth = YES;
    self.mytextlable.adjustsFontSizeToFitWidth = YES;
}

- (void)loaddataWithModel:(ShowCerModel *)mdoel{
   
    self.Mytitlelable.text = mdoel.title;
    
    self.mytextlable.text = mdoel.content;
    
}
@end
