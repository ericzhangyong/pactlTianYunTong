//
//  QueryStateCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryStateCell.h"
#import "QueryCerStateModel.h"

@implementation QueryStateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.Scanbtn.layer.masksToBounds = YES;
    self.Scanbtn.layer.cornerRadius = 5;
    self.Scanbtn.backgroundColor  = NavColor;
    
}

- (void)loaddataWithBaseModel:(QuerybaseModel *)model{
   
    QueryCerStateModel *stateModel = (QueryCerStateModel *)model;
    
    if ([stateModel.CerStr isEqualToString:@""]) {
        self.cerlable.hidden = YES;
        self.zhhLable.hidden = YES;
        
    }else{
        self.cerlable.hidden = NO;
        self.zhhLable.hidden = NO;
        self.cerlable.text = stateModel.CerStr;
    }
    
   
    
}

@end
