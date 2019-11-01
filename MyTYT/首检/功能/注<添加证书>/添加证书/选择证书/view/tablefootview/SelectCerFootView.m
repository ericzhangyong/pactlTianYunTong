//
//  SelectCerFootView.m
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectCerFootView.h"
#import "Masonry.h"

@implementation SelectCerFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self addSubview:self.saveBtn];
        
        [self layout];
    }
    return self;
}

- (void)layout{
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"确定" forState:UIControlStateNormal];
        _saveBtn.backgroundColor = BtnColor;
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius = 7;
    }
    return _saveBtn;
}

@end
