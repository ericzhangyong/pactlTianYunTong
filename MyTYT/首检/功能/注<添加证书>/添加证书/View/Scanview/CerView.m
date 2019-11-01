//
//  CerView.m
//  MyTYT
//
//  Created by Fly on 2018/5/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CerView.h"
#import "Masonry.h"
#import "CerResultCell.h"
#import "ShowCerDataModel.h"

@interface CerView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation CerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatUI];
        
        [self layout];
                
            }
    return self;
}

- (void)freshDataWithcerStr:(NSString *)cerStr State:(NSString *)state model:(CerNeedDataModel *)model{
    
    self.model = [[ShowCerDataModel alloc] initWithStr:cerStr state:state model:model];
    
    [self.tableview reloadData];
}

- (void)creatUI{
    
    [self addSubview:self.scanBtn];
    
    [self addSubview:self.saveBtn];
    
    [self addSubview:self.saveAddBZBtn];
    
    [self addSubview:self.tableview];
}

- (void)layout{
    
    [_scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(@45);
    }];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-15);
        make.left.height.equalTo(self.scanBtn);
        make.right.height.equalTo(self.scanBtn);
        
    }];
    
    [_saveAddBZBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.saveBtn.mas_right).offset(15);
//        make.bottom.equalTo(self).offset(-15);
//        make.right.height.equalTo(self.scanBtn);
//        make.width.equalTo(self.saveBtn);
        make.left.right.height.equalTo(self.saveBtn);
        make.bottom.equalTo(self.saveBtn.mas_top).offset(-15);
    }];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scanBtn.mas_bottom).offset(15);
        make.left.right.equalTo(self.scanBtn);
        make.bottom.equalTo(self.saveAddBZBtn.mas_top).offset(-15);
    }];
    
}
- (UIButton *)scanBtn{
    if (!_scanBtn) {
        _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanBtn setTitle:@"扫描/输入证书号" forState:UIControlStateNormal];
        [_scanBtn setBackgroundColor:NavColor];
        _scanBtn.layer.masksToBounds = YES;
        _scanBtn.layer.cornerRadius = 5;
    }
    return _scanBtn;
}


- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存,返回运单列表" forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:NavColor];
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius = 5;
        _saveBtn.titleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _saveBtn;
}

- (UIButton *)saveAddBZBtn{
    if (!_saveAddBZBtn) {
        _saveAddBZBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveAddBZBtn setTitle:@"保存,继续添加备注" forState:UIControlStateNormal];
        [_saveAddBZBtn setBackgroundColor:[UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00]];
        _saveAddBZBtn.layer.masksToBounds = YES;
        _saveAddBZBtn.layer.cornerRadius = 5;
        _saveAddBZBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _saveAddBZBtn;
}


- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"CerResultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([CerResultCell class])];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc] init];
    }
    return _tableview;
}

#pragma mark------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.datararay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CerResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CerResultCell class]) forIndexPath:indexPath];
    
    [cell loaddataWithModel:self.model.datararay[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.height/6;
}

@end
