//
//  SelectPhotoVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/3.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectPhotoVC.h"

@interface SelectPhotoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSArray *dataarray;

@property (nonatomic) UITableView *tableview;

@end

@implementation SelectPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableview.frame = CGRectMake(0, 0, self.preferredContentSize.width, self.preferredContentSize.height);
}

- (CGSize)preferredContentSize{
    return CGSizeMake(200, 44*self.dataarray.count);
}

- (void)creatUI{
    
    [self.view addSubview:self.tableview];
    self.dataarray = @[@"相机",@"相册"];
    
}
#pragma mark------------------------------------------------------------------------------------

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain
                      ];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 44;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.tableHeaderView = [[UIView alloc] init];
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELLID"];
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataarray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    self.block(indexPath.row);
    
}


@end
