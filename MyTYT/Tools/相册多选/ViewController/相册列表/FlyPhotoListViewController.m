//
//  FlyPhotoListViewController.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotoListViewController.h"
#import "PhotoListTableViewCell.h"
#import "FlyPhotoData.h"
#import "FlyPhotoPickViewController.h"
#import "FlyPhotoModel.h"

@interface FlyPhotoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableview;

//获取相册数据的模型
@property (nonatomic) FlyPhotoData *photodata;
//盛放照片集合的数组
@property (nonatomic) NSMutableArray *albumArray;

@end

@implementation FlyPhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
}

//返回
- (void)goback{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark-----DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoListTableViewCellID"];
    
    [cell loaddataWith:self.albumArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    FlyPhotoModel *model = self.albumArray[indexPath.row];
    
    FlyPhotoPickViewController *pickPhotoVC = [[FlyPhotoPickViewController alloc] init];
    
    pickPhotoVC.fetchResult = model.fetResult;
    
    pickPhotoVC.Photoresult = self.Photoresult;
    
    pickPhotoVC.MaxSelectPicCout = self.MaxSelectPicCout;
    
    pickPhotoVC.title = model.Pictitle;
        
    [self.navigationController pushViewController:pickPhotoVC animated:YES];
}

#pragma mark---UI
- (void)creatUI{
    self.title = @"照片";
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    self.navigationItem.rightBarButtonItem = rightitem;
    [self.view addSubview:self.tableview];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kuan, gao-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.estimatedRowHeight = 80;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        
        _tableview.tableFooterView = [[UIView alloc] init];
        
        [_tableview registerNib:[UINib nibWithNibName:@"PhotoListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PhotoListTableViewCellID"];
        
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _tableview;
}

- (FlyPhotoData *)photodata{
    if (!_photodata) {
        _photodata = [[FlyPhotoData alloc] init];
    }
    return _photodata;
}

- (NSMutableArray *)albumArray{
    if (!_albumArray) {
        _albumArray = [self.photodata getPhotosListDatas];
    }
    return _albumArray;
}
@end
