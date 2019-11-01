//
//  ShowMachineRoadVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowMachineRoadVC.h"
#import "RoadModel.h"
#import "TwentyMachineModel.h"

@interface ShowMachineRoadVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableview;

@end

@implementation ShowMachineRoadVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self creatUI];

}

- (void)creatUI{
    
    switch (self.type) {
        case SHOWRoad:
        {
            self.title = @"选择24小时通道";

        }
            break;
        case SHOWMAChine:
        {
            self.title = @"选择安检机";

        }
            break;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview.frame = self.view.bounds;
    [self.view addSubview:self.tableview];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(backEvent)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)backEvent{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark------------------------------------------------------------------------------------

- (UITableView *)tableview{
    if (!_tableview) {
     
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 50;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.tableHeaderView = [[UIView alloc] init];
        _tableview.tableFooterView = [[UIView alloc] init];
        
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        } else {
            // Fallback on earlier versions
        }
        _tableview.tableFooterView = [[UIView alloc] init];
    }
    return _tableview;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *celliD = @"SHOWCELLID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celliD];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celliD];
    }
    
    switch (self.type) {
        case SHOWRoad:
        {
            RoadModel *mdoel = self.dataArray[indexPath.row];
            if ([mdoel.ID isEqualToString:self.roadModel.ID]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@通道",mdoel.name];
        }
            break;
            
        case SHOWMAChine:
        {
            TwentyMachineModel *mdoel = self.dataArray[indexPath.row];
            if ([mdoel.ID isEqualToString:self.machIneModel.ID]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@号安检机",mdoel.name];

        }
            break;
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    switch (self.type) {
        case SHOWRoad:
        {
            self.roadModel = self.dataArray[indexPath.row];
        }
            break;
            
        case SHOWMAChine:
        {
            self.machIneModel = self.dataArray[indexPath.row];

            
        }
            break;
    }
    [self.tableview reloadData];
    
    self.block(@[self.dataArray[indexPath.row]]);
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
   
}


@end
