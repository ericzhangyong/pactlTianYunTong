//
//  SelectcerCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectcerCell.h"
#import "SelectCerModel.h"

@implementation SelectcerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadDataWithModel:(SelectCerModel *)model isselet:(BOOL)isselect{
    
    if (isselect) {
        self.selectimageView.image = [UIImage imageNamed:@"haveread"];
    }else{
        self.selectimageView.image = [UIImage imageNamed:@"selectNO"];
    }
    
    self.name.text = model.shortName;
    
    self.number.text = model.bookNo;
    
}

@end
