//
//  ExplainRoadVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ExplainRoadVC.h"
#import "ExplainRoadCell.h"
#import "ExplainHeadView.h"

@interface ExplainRoadVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableview;

@end

@implementation ExplainRoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = right;
    self.title = @"通道说明";
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    self.tableview.frame = self.view.bounds;
   
    
}

- (void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)tableview{
    if (!_tableview) {
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 50;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.sectionHeaderHeight = 60;
        _tableview.tableHeaderView = [[UIView alloc] init];
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.allowsSelection = NO;
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        } else {
            // Fallback on earlier versions
        }
        _tableview.tableFooterView = [[UIView alloc] init];
        [_tableview registerNib:[UINib nibWithNibName:@"ExplainRoadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ExplainRoadCellID"];
    }
    return _tableview;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExplainRoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExplainRoadCellID" forIndexPath:indexPath];
    
    [cell loaddataWithModel:self.dataarray[indexPath.row]];
    
    return cell;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[ExplainHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

@end
