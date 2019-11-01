//
//  NotificationVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NotificationVC.h"
#import "notificatonCell.h"
#import "NotifyViewModel.h"
#import "NotifiModel.h"
#import "MBProgressHUD+FLyHUD.h"

@interface NotificationVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView *tableview;

@property (nonatomic) NotifyViewModel *viewModel;

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];


}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableview.frame = self.view.bounds;

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置Large Title偏好为YES。
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setPrefersLargeTitles:YES];

    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setPrefersLargeTitles:NO];
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)creatUI{
    
    
    self.title = [NSString stringWithFormat:@"%@",self.YDH];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(backEvent)];
    self.navigationItem.rightBarButtonItem = right;
    
  
    [self.view addSubview:self.tableview];
        
}

#pragma mark------------------------------------------------------------------------------------
- (void)backEvent{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark------------------------------------------------------------------------------------
- (NotifyViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[NotifyViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
            // Fallback on earlier versions
        }
        [_tableview registerNib:[UINib nibWithNibName:@"notificatonCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"notificatonCellID"];
        _tableview.tableFooterView = [[UIView alloc] init];
    }
    return _tableview;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notifiarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    notificatonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificatonCellID" forIndexPath:indexPath];
    [cell loaddataWithModel:self.notifiarray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NotifiModel *model = self.notifiarray[indexPath.row];
    
    [self changeNotifyWithModel:model row:indexPath.row];
  
}

- (void)changeNotifyWithModel:(NotifiModel *)model row:(NSInteger)row{
    
    [MBProgressHUD showLoadView:nil loadTitle:@"正在修改通知状态"];
    
    [self.viewModel notifyWithModel:model MachID:self.MachID success:^{
        
        [MBProgressHUD showSuccessView:nil SuccessTitle:@"通知状态更改成功"];
        
        if ([model.status isEqualToString:@"1"]) {
            model.status = @"0";
        }else if ([model.status isEqualToString:@"0"]){
            model.status = @"1";
        }
        
        self.block(self.notifiarray);
        
        notificatonCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        
        if ([model.status isEqualToString:@"1"]) {
            
            cell.notificationimageview.image = [UIImage imageNamed:@"haveread"];
            
        }else if([model.status isEqualToString:@"0"]){
            
            cell.notificationimageview.image = [UIImage imageNamed:@"noready"];
            
        }
        
    } fail:^(NSString *failStr) {
        [MBProgressHUD showErrorView:nil errorTitle:failStr];
    }];
    
   
}

@end
