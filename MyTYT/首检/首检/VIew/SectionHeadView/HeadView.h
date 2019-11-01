//
//  HeadView.h
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstVC.h"

@interface HeadView : UITableViewHeaderFooterView

//一键通过
@property (nonatomic) UIButton *YJTGBTn;

@property (nonatomic) UIButton *allBtn;

@property (nonatomic) UIButton *saveBtn;

@property (nonatomic) UIButton *scanBtn;

@property (nonatomic) UIButton *shareBtn;

@property (nonatomic) UIButton *operationBtn;

/// 检测类型
@property (nonatomic,assign) DetectionType detectionType;


@end
