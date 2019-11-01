//
//  SelectVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/26.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectVC.h"
#import "SelectModel.h"

@interface SelectVC ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UISearchController *searchcontroller;

@property (nonatomic) UITableView *tableview;

@property (nonatomic) NSMutableArray *searchDataArray;

@end

@implementation SelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchcontroller;
        self.navigationItem.hidesSearchBarWhenScrolling = false;
        
    } else {
    }
    
    
    self.definesPresentationContext = YES;

    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self creatUI];

}

- (void)creatUI{
    
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(backEvent)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.title = @"筛选";
}



- (void)backEvent{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark------------------------------------Delegate------------------------------------------------
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [self.searchDataArray removeAllObjects];
    
    NSString *searchtext = searchController.searchBar.text;
    
    if ([searchtext isEqualToString:@""]) {//空
    
        self.searchDataArray = [NSMutableArray arrayWithArray:self.AgentArray];
        [self.tableview reloadData];
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",searchtext];

    
    self.searchDataArray = [NSMutableArray arrayWithArray:[self.AgentArray filteredArrayUsingPredicate:predicate]];
    
    if (self.searchDataArray.count>0) {
        
    }else{

    }
    
    [self.tableview reloadData];
}


#pragma mark------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchcontroller.active) {
        return self.searchDataArray.count;
    }
    return self.AgentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"selectCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (self.searchcontroller.active) {
       SelectModel *model = self.searchDataArray[indexPath.row];
        cell.textLabel.text = model.name;

    }else{
        SelectModel *model = self.AgentArray[indexPath.row];

        cell.textLabel.text = model.name;

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        if (self.searchcontroller.active) {
            SelectModel *model = self.searchDataArray[indexPath.row];
            self.block(model);
        }else{
            SelectModel *model = self.AgentArray[indexPath.row];
            self.block(model);
        }
    }];
   
}

#pragma mark--------------------------------------UI----------------------------------------------
- (UISearchController *)searchcontroller{
    if (!_searchcontroller) {
        _searchcontroller = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchcontroller.searchResultsUpdater = self;
        _searchcontroller.delegate = self;
        _searchcontroller.searchBar.delegate = self;
        _searchcontroller.dimsBackgroundDuringPresentation = NO;
        _searchcontroller.searchBar.placeholder = @"搜索代理";
    }
    
    return _searchcontroller;
}

- (UITableView *)tableview{
    if (!_tableview) {
//        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.preferredContentSize.width, self.navigationController.preferredContentSize.height) style:UITableViewStylePlain];
        _tableview = [[UITableView alloc] initWithFrame:self.navigationController.view.bounds style:UITableViewStylePlain];

        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 44;
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


- (NSMutableArray *)AgentArray{
    if (!_AgentArray) {
        _AgentArray = [NSMutableArray array];
    }
    return _AgentArray;
}

- (NSMutableArray *)searchDataArray{
    if (!_searchDataArray) {
        _searchDataArray = [NSMutableArray array];
    }
    return _searchDataArray;
}
@end
