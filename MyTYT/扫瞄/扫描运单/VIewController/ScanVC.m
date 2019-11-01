//
//  ScanVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanVC.h"
#import "Masonry.h"
#import "RightView.h"
#import "RequestAuthor.h"
#import "PreSentScanVC.h"
#import "ScanNetViewModel.h"
#import "InfoView.h"
#import "LeftView.h"
#import "MBProgressHUD+FLyHUD.h"
#import "ScanModel.h"
#import "ScanSectionModel.h"

@interface ScanVC ()<leftViewDelegate>

@property (nonatomic) LeftView *leftView;

@property (nonatomic) RightView *rightVIew;

@property (nonatomic) ScanNetViewModel *NetViewModel;

@end

@implementation ScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotifiCation];
    
    [self creatUI];
    
    [self scanEvent];
    
    
}

//添加监听通知
- (void)addNotifiCation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InputYDHEventNotiDication:) name:YDNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InputYDSaveNotification:) name:YDSaveNotiFication object:nil];
}

//去除通知
- (void)removeNitocation{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YDNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YDSaveNotiFication object:nil];
}

//保存成功
- (void)InputYDSaveNotification:(NSNotification *)notification{
    FlyLog(@"%@",notification);
    NSDictionary *dic = notification.userInfo;
    
    NSString *SuccessStr = dic[@"data"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [MBProgressHUD showSuccessText:self.navigationController.view title:SuccessStr];
}

//扫出一票
- (void)InputYDHEventNotiDication:(NSNotification *)notification{
    
    FlyLog(@"%@",notification);
    NSDictionary *dic = notification.userInfo;
    ScanModel *model = dic[@"data"];
    [self successScanEventWithModel:model];
    
}


- (void)dealloc{
    
    [self removeNitocation];
        
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:YDArray];
    
    FlyLog(@"总扫描delloc");
}
#pragma mark------------------------------------------------------------------------------------
//扫描
- (void)scanEvent{
    
    [[RequestAuthor shareInstance] requestAVMediaTypeVideoWithAllow:^{
        
        [self PresentVC];
        
    } deny:^{
        
    } withVC:self];
}

//显示扫描页面
- (void)PresentVC{
    
    PreSentScanVC *scanvc = [[PreSentScanVC alloc] init];
    
    scanvc.type = SCANYGD;
    
    scanvc.MachID = self.machID;
    
    switch (self.intoScantype) {
            
        case FirstScanType:
        {
            scanvc.fromType = FromFirstCome;
        }
            break;
        case TwenTyScanType:
        {
            scanvc.fromType = FromTwentyCome;
        }
            break;
    }
    
    scanvc.block = ^(NSString *scanStr) {
        
        [self RequestDDinfoWithStr:scanStr];
        FlyLog(@"%@",scanStr);
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scanvc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nav animated:YES completion:nil];
}

//请求订单信息
- (void)RequestDDinfoWithStr:(NSString *)str{
    
    
    __weak typeof(self)weakself = self;
    
    [self.NetViewModel loaddataWithMachID:self.machID number:str TypeStr:[self MytypeStr] start:^{
        [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在加载"];
    } success:^(ScanModel *model) {
        
        [MBProgressHUD showSuccessView:weakself.view];
        
        [weakself successScanEventWithModel:model];
        
        
    } fail:^(NSString *failStr) {
        
        [MBProgressHUD showErrorView:weakself.view errorTitle:failStr];
        
        weakself.rightVIew.infoView.hidden = YES;
        
        [weakself.leftView.tableview reloadData];
        
    }];
}

//成功扫描
- (void)successScanEventWithModel:(ScanModel *)model{
    
    //如果已经存在单号，不需要重新添加
    
    int j = -1;
    
    for (int i=0; i<self.leftView.dataArray.count; i++) {
        
        ScanSectionModel *sectionModel  = self.leftView.dataArray[i];
        
        if ([sectionModel.scanModel.waybillno isEqualToString:model.waybillno]) {
            j = i;
            break;
        }
        
    }
    
    
    if (j>=0) {
        
        ScanSectionModel *sectionModel = [[ScanSectionModel alloc] initWithScanModel:model];

        [self.leftView.dataArray replaceObjectAtIndex:j withObject:sectionModel];
        
        [self.leftView setFreshDataWithRow:j];
        
    }else{//添加到第一个，刷新数据
        
        ScanSectionModel *sectionModel = [[ScanSectionModel alloc] initWithScanModel:model];
        [self.leftView.dataArray insertObject:sectionModel atIndex:0];
        [self.leftView setFreshDataWithRow:0];
        
    }
    
    [self.leftView changDataArray];
}

//选择展示对应数据
- (void)SelectRowShowModel:(ScanModel *)model{
    
    self.rightVIew.infoView.hidden = NO;
    [self.rightVIew.infoView loaddataWithscanModel:model];
    
}

//删除隐藏相应数据
- (void)deleteEvent{
    
    self.rightVIew.infoView.hidden = YES;
}

//保存数据
- (void)saveEventWith:(NSMutableArray *)dataarray{
    
    if (dataarray.count<=0) {
        [MBProgressHUD showTextView:self.navigationController.view textTitle:@"请先添加运单"];
        return;
    }
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (ScanSectionModel *sectionModel in dataarray) {
        
        ScanModel *model = sectionModel.scanModel;
        
        NSDictionary *needdic = @{
                                  @"waybillno":model.waybillno
                                  };
        
        if ([model.isCheck isEqualToString:@"1"]) {//可安检
            [array addObject:needdic];
        }
        
        
    }
    
    if (array.count<=0) {
        [MBProgressHUD showTextView:self.navigationController.view textTitle:@"运单不可安检"];
        return;
    }
    
    
    __weak typeof(self)weakself = self;
    
    [self.NetViewModel saveEventWithMachID:self.machID listArray:array TypeStr:[self MytypeStr] start:^{
        
        [MBProgressHUD showLoadView:weakself.navigationController.view loadTitle:@"正在保存"];
        
    } success:^(NSString *numStr) {
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
        if ([numStr intValue]>0) {
            [MBProgressHUD  showSuccessView:weakself.navigationController.view SuccessTitle:[NSString stringWithFormat:@"有%@条数据未能保存",numStr]];
        }else{
            [MBProgressHUD  showSuccessView:weakself.navigationController.view SuccessTitle:@"保存成功"];
        }
        
    } fail:^(NSString *failStr) {
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:failStr];
        
    }];
    
}

#pragma mark------------------------------------------------------------------------------------
- (NSString *)MytypeStr{
    
    NSString *typeStr;
    switch (self.intoScantype) {
        case FirstScanType:
        {
            typeStr = @"0";
        }
            break;
        case TwenTyScanType:
        {
            typeStr = @"1";
            
        }
            break;
    }
    
    return typeStr;
    
}

- (void)creatUI{
    
    self.title = @"扫描";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightVIew];
    
    [self layout];
    
    
    
}

- (void)layout{
    
    CGFloat pad = kuan *0.02;
    
    CGFloat VPad = self.view.bounds.size.height *0.02;
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(VPad);
        make.bottom.equalTo(self.view).offset(-VPad);
        make.left.equalTo(self.view).offset(pad);
        make.width.equalTo(self.view).multipliedBy(0.38);
    }];
    
    [_rightVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftView);
        make.right.equalTo(self.view).offset(-pad);
        make.left.equalTo(self.leftView.mas_right).offset(pad);
    }];
}

- (LeftView *)leftView{
    if (!_leftView) {
        _leftView = [[LeftView alloc] init];
        _leftView.layer.masksToBounds = YES;
        _leftView.layer.cornerRadius = 15;
        _leftView.backgroundColor = [UIColor whiteColor];
        _leftView.delelgate = self;
    }
    return _leftView;
}

- (RightView *)rightVIew{
    if (!_rightVIew) {
        _rightVIew = [[RightView alloc] init];
        _rightVIew.layer.masksToBounds = YES;
        _rightVIew.layer.cornerRadius = 15;
        _rightVIew.backgroundColor = [UIColor whiteColor];
        [_rightVIew.ScanBtn addTarget:self action:@selector(scanEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightVIew;
}

- (ScanNetViewModel *)NetViewModel{
    if (!_NetViewModel) {
        _NetViewModel = [[ScanNetViewModel alloc] init];
    }
    return _NetViewModel;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
