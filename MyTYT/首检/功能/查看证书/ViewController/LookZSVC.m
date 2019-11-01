//
//  LookZSVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LookZSVC.h"
#import "BooksModel.h"

@interface LookZSVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableview;


@end

@implementation LookZSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];

}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableview.frame = CGRectMake(0, 0, self.preferredContentSize.width, self.preferredContentSize.height);
}

- (CGSize)preferredContentSize{
    return CGSizeMake(180, 50*self.dataarray.count);
}

- (void)creatUI{
    
    [self.view addSubview:self.tableview];
    
}
#pragma mark------------------------------------------------------------------------------------

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain
                      ];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 50;
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
    
    BooksModel *model = self.dataarray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = model.BookNo;
    cell.textLabel.textColor = BtnColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BooksModel *model = self.dataarray[indexPath.row];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.Block(model);

}


@end
