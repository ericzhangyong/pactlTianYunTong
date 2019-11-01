//
//  LeftView.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanModel;
@protocol leftViewDelegate <NSObject>

@required;

//选择展示对应数据
- (void)SelectRowShowModel:(ScanModel *)model;
//删除展示最后一个数据
- (void)deleteEvent;
//保存数据
- (void)saveEventWith:(NSMutableArray *)dataarray;

@end

@interface LeftView : UIView

@property (nonatomic) UILabel *titlelable;

@property (nonatomic) UIButton *saveBtn;

@property (nonatomic) UITableView *tableview;

@property (nonatomic) NSMutableArray *dataArray;

@property (nonatomic,weak) id<leftViewDelegate> delelgate;

//刷新数据
- (void)setFreshDataWithRow:(NSInteger)row;
//改变数据
- (void)changDataArray;

@end
