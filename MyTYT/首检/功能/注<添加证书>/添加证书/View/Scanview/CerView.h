//
//  CerView.h
//  MyTYT
//
//  Created by Fly on 2018/5/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowCerDataModel;
@class CerNeedDataModel;

@interface CerView : UIView

@property (nonatomic) UIButton *scanBtn;

@property (nonatomic) UIButton *saveBtn;

@property (nonatomic) UIButton *saveAddBZBtn;

@property (nonatomic) UITableView *tableview;

@property (nonatomic) ShowCerDataModel *model;

- (void)freshDataWithcerStr:(NSString *)cerStr State:(NSString *)state model:(CerNeedDataModel *)model;

@end
