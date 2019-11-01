//
//  SelectCerVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectCerVC.h"
#import "SelectcerCell.h"
#import "SelectCerFootView.h"
#import "SelectCerModel.h"

@interface SelectCerVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableview;

@property (nonatomic) NSMutableArray *statearray;

@end

@implementation SelectCerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
}

#pragma mark------------------------------------------------------------------------------------
- (void)saveEvent{
    
    for (int i=0; i<self.statearray.count; i++) {
        
        BOOL state = [self.statearray[i]boolValue];
        if (state == YES) {
         SelectCerModel *model  = self.dataarray[i];
            [self dismissViewControllerAnimated:YES completion:nil];
            self.block(model);
        }
    }
}
- (void)creatUI{
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(backEvent)];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(saveEvent)];
    
    self.navigationItem.rightBarButtonItem = right;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;

    
    for (int i=0; i<self.dataarray.count; i++) {
        
        [self.statearray addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self.view addSubview:self.tableview];
    
    
}

- (void)backEvent{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    SelectCerFootView *view = [[SelectCerFootView alloc] initWithFrame:CGRectMake(0, 0, _tableview.frame.size.width, 75)];
//    [view.saveBtn addTarget:self action:@selector(saveEvent) forControlEvents:UIControlEventTouchUpInside];
//    _tableview.tableFooterView =view;
    self.tableview.frame = self.view.bounds;
}


- (NSMutableArray *)statearray{
    if (!_statearray) {
        _statearray = [NSMutableArray array];
    }
    return _statearray;
}
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 110;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight =0;
       
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
            // Fallback on earlier versions
        }
        [_tableview registerNib:[UINib nibWithNibName:@"SelectcerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SelectcerCellID"];
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectcerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectcerCellID" forIndexPath:indexPath];
    [cell loadDataWithModel:self.dataarray[indexPath.row] isselet:[self.statearray[indexPath.row] boolValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL isselect = [self.statearray[indexPath.row] boolValue];
    
    isselect = !isselect;
    
    [self.statearray removeAllObjects];
    
    for (int i=0; i<self.dataarray.count; i++) {
        
        if (i== indexPath.row) {
            
            if (isselect == YES) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }else{
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            
            [self.statearray addObject:[NSNumber numberWithBool:isselect]];
        }else{
            [self.statearray addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    [self.tableview reloadData];
}

@end
