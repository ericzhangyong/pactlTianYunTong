//
//  DetailFDAllCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailFDAllCell.h"
#import "FDAllModel.h"

@implementation DetailFDAllCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)loaddataWithModel:(FDAllModel *)model{
    

    self.ALlJSLable.text = [[NSString alloc] initWithFormat:@"%@",model.allcount.stringValue];
    
    
    self.AllWeightLable.text = [[NSString alloc] initWithFormat:@"%@",model.allWeight.stringValue];
    
   
}

@end
