//
//  WriteScanYDVC.m
//  MyTYT
//
//  Created by Fly on 2018/6/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "WriteScanYDVC.h"
#import "IQKeyboardManager.h"
#import "WriteScanCell.h"
#import "UIImage+UIImage_FLyColor.h"
#import "ScanNetViewModel.h"
#import "MBProgressHUD+FLyHUD.h"
#import "ScanModel.h"
#import "WriteScanhistoryCell.h"
#import "ScanSectionModel.h"
#import "ScanRowModel.h"
#import "WriteScanNewHeadView.h"
#import "CheckBillSelectView.h"

@interface WriteScanYDVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic) UITableView *tableview;

@property (nonatomic) WriteScanNewHeadView *headview;

@property (nonatomic) NSMutableArray *dataArray;

@property (nonatomic) ScanNetViewModel *NetViewModel;
@property (nonatomic,strong) CheckBillSelectView *view_billCheckSelect;

/// 是否正在选择bill
@property (nonatomic,assign) BOOL isSelectBilling;
@end

@implementation WriteScanYDVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
    
}

- (void)dealloc{
    FlyLog(@"手动输入delloc");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableview.frame = self.view.bounds;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

#pragma mark------------------------------------------Event------------------------------------------
- (void)creatUI{
    
   
    NSString *title = @"保存";
    if (self.scanVcType == ScanTypeCheck && self.type == ScanYDType9610Systm) {
        title = @"确定";
    }
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(saveEvent)];
    self.navigationItem.rightBarButtonItem = right;
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:YDArray];

    if (array) {//如果有数据
        for (NSDictionary *data in array) {
           ScanBillModel *model = [ScanBillModel convertModelWithJsonDic:data];
            ScanSectionModel *sectionModel = [[ScanSectionModel alloc] initWithScanModel:model];

            [self.dataArray addObject:sectionModel];
        }
//        for (NSData *data in array) {
//           ScanModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            ScanSectionModel *sectionModel = [[ScanSectionModel alloc] initWithScanModel:model];
//
//            [self.dataArray addObject:sectionModel];
//        }

    }
    
    if (self.dataArray.count >0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;

    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    [self.view addSubview:self.tableview];
    [self.headview.textfiled becomeFirstResponder];
    if (self.scanVcType == ScanTypeCheck) {
        self.headview.textfiled.returnKeyType = UIReturnKeySearch;
    }else{
        self.headview.textfiled.returnKeyType = UIReturnKeyDone;
    }
}

//保存
- (void)saveEvent{
    
    if (self.scanVcType == ScanTypeCheck) {
        [self requestInfoWithtext:self.headview.textfiled.text];
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    if (self.dataArray.count<=0) {
        [MBProgressHUD showTextView:self.navigationController.view textTitle:@"请先添加运单"];
        return;
    }
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (ScanSectionModel *sectionModel in self.dataArray) {
        
        ScanBillModel *model = sectionModel.scanModel;
        
        NSDictionary *needdic = @{
                                  @"waybillno":model.waybill.waybillno
                                  };
        
        if ([model.waybill.isCheck isEqualToString:@"1"]) {//可安检
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
        
        
        [MBProgressHUD showSuccessView:weakself.navigationController.view];
        
        NSString *SaveSuccessStr;
        
        if ([numStr intValue]>0) {
            SaveSuccessStr = [NSString stringWithFormat:@"有%@条数据未能保存",numStr];
        }else{
            SaveSuccessStr = @"保存成功";
        }
        
        [weakself.navigationController dismissViewControllerAnimated:YES completion:^{
            
            [weakself postSaveSuccessStr:SaveSuccessStr];
        }];

        
    } fail:^(NSString *failStr) {
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:failStr];
        
    }];
    
}

//请求数据
- (void)requestInfoWithtext:(NSString *)text{
    
    self.headview.textfiled.text = @"";
    
    [self.headview.textfiled resignFirstResponder];
    WEAK_SELF
    if (self.scanVcType == ScanTypeCheck) {
        [self.NetViewModel loaddataWitNumber:text start:^{
            [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在请求运单信息"];
        } success:^(id data) {
           
            [MBProgressHUD showSuccessView:weakSelf.navigationController.view];
            ScanBillModel *model = [ScanBillModel new];
            if ([data isKindOfClass:[NSArray class]]) {
               NSArray *dataArr  = data;
                for (ScanBillModel *billModel in dataArr) {
                    billModel.scanType = self.scanVcType;
                }
               ScanBillModel  *model = dataArr.firstObject;
//                model = scanBillModel.subWaybill;
                if (dataArr.count>1) {
                    weakSelf.view_billCheckSelect.dataSource = dataArr;
                    weakSelf.view_billCheckSelect.didSeleced = ^(ScanBillModel * _Nonnull billModel) {
                        weakSelf.isSelectBilling = YES;
                        [weakSelf successScanEventWithModel:billModel];
                    };
                    [weakSelf.view_billCheckSelect showBillSelectViewWithSuperView:weakSelf.view];
                }else{
                    [weakSelf successScanEventWithModel:model];
                }
            }else{
                [weakSelf successScanEventWithModel:model];
            }
        } fail:^(NSString *failStr) {
            NSString *str = [[NSString alloc] initWithFormat:@"%@,请重新输入",failStr];
            [MBProgressHUD showErrorView:self.navigationController.view errorTitle:str];
            
            [weakSelf.headview.textfiled becomeFirstResponder];
        }];
    }else{
        [self.NetViewModel loaddataWithMachID:self.machID number:text TypeStr:[self MytypeStr] start:^{
            
            [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在请求运单信息"];
            
        } success:^(ScanBillModel *model) {
            model.scanType = weakSelf.scanVcType;
            [MBProgressHUD showSuccessView:self.navigationController.view];
            [self successScanEventWithModel:model];
            
            
        } fail:^(NSString *failStr) {
            
            NSString *str = [[NSString alloc] initWithFormat:@"%@,请重新输入",failStr];
            [MBProgressHUD showErrorView:self.navigationController.view errorTitle:str];
            
            [self.headview.textfiled becomeFirstResponder];

            
        }];
    }
    
    
}

- (void)successScanEventWithModel:(ScanBillModel *)model{
    
    //发出通知
        [self postYDModel:model];
        
        //如果已经存在单号，不需要重新添加
        
        int j = -1;
        
        for (int i=0; i<self.dataArray.count; i++) {
            
            ScanSectionModel *sectionModel = self.dataArray[i];
            
            if ([sectionModel.scanModel.waybill.waybillno isEqualToString:model.waybill.waybillno]) {
                j = i;
                break;
            }
            
        }
    
        if (j>=0) {//已经存在
            
            ScanSectionModel *sectionModel = [[ScanSectionModel alloc] initWithScanModel:model];
            
            [self.dataArray replaceObjectAtIndex:j withObject:sectionModel];
            
            [self freshDataSelectDataWithsection:j];
            
        }else{//添加最新刷新数据
            
            ScanSectionModel *sectionModel = [[ScanSectionModel alloc] initWithScanModel:model];
            
            [self.dataArray insertObject:sectionModel atIndex:0];
            
            [self freshDataSelectDataWithsection:0];
            
        }
        
        if (self.dataArray.count>0) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    if (self.isSelectBilling) {
        self.isSelectBilling = NO;
        [self.headview.textfiled resignFirstResponder];
    }else{
        [self.headview.textfiled becomeFirstResponder];
    }
    
    if (self.scanVcType == ScanTypeCheck) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
//刷新并选中数据
- (void)freshDataSelectDataWithsection:(NSInteger)section{
  
    [self.tableview reloadData];
    
    [self.tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [self tableView:self.tableview didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
}

//发出扫描一票通知
- (void)postYDModel:(ScanBillModel *)model{
    
    NSDictionary *dic = @{
                          @"data":model
                          };
    [[NSNotificationCenter defaultCenter] postNotificationName:YDNOTIFICATION object:nil userInfo:dic];
    
}

//发出保存成功通知
- (void)postSaveSuccessStr:(NSString *)str{
    
    
    NSDictionary *dic = @{
                          @"data":str
                          };
    [[NSNotificationCenter defaultCenter] postNotificationName:YDSaveNotiFication object:nil userInfo:dic];
    
}

- (NSString *)MytypeStr{
    
    NSString *typeStr;
    
    switch (self.type) {
            
        case FirstScanYDType:
        {
            typeStr = @"0";
        }
            break;
        case TwentyScanYDType:
        {
            typeStr = @"1";
            
        }
            break;
        case ScanYDType9610Systm:
        {
            typeStr = @"2";
        }
    }
    
    return typeStr;
    
}

#pragma mark------------------------------------------------------------------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [self requestInfoWithtext:textField.text];
        return YES;
    }
    
    NSCharacterSet *charset = [NSCharacterSet decimalDigitCharacterSet];
    if (self.scanVcType == ScanTypeCheck) {
        charset = [NSCharacterSet alphanumericCharacterSet];
        if (textField.text.length>0) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
    }else{
        if ([[string stringByTrimmingCharactersInSet:charset] isEqualToString:@""]) {//数字
            
                FlyLog(@"%@",NSStringFromRange(range));
               
                if (range.location == 10) {
                    NSString *str = [NSString stringWithFormat:@"%@%@",textField.text,string];
                    [self requestInfoWithtext:str];
                    return YES;
                }else if (range.location>10){
        //            [MBProgressHUD showTextView:self.navigationController.view textTitle:@"运单号位数不正确"];
                    return YES;
                }else if (range.location<10){
                    
                    return YES;
                }
            }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
       
    [self requestInfoWithtext:textField.text];
    return YES;
}

#pragma mark------------------------------------------------------------------------------------

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"WriteScanCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([WriteScanCell class])];
        [_tableview registerNib:[UINib nibWithNibName:@"WriteScanhistoryCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([WriteScanhistoryCell class])];

        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
            // Fallback on earlier versions
        }
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableview.estimatedRowHeight = 60;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.tableHeaderView = self.headview;
        
    }
    return _tableview;
}

- (WriteScanNewHeadView *)headview{
    
    if (!_headview) {
        _headview = [[WriteScanNewHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
        _headview.textfiled.delegate = self;
    }
    return _headview;
}

- (ScanNetViewModel *)NetViewModel{
    if (!_NetViewModel) {
        _NetViewModel = [[ScanNetViewModel alloc] init];
    }
    return _NetViewModel;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    ScanSectionModel *model = self.dataArray[section];
    
    return model.rowArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    ScanSectionModel *model = self.dataArray[section];
    
    return model.sctionHeadHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];
    
    return model.sctionFootHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];
    return model.SectionHeadView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];
    return model.SectionFooterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScanSectionModel *model = self.dataArray[indexPath.section];
    
    ScanRowModel *rowModle = model.rowArray[indexPath.row];
    
    switch (rowModle.Type) {
            
        case ScanStateRowType:
        {
            WriteScanCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WriteScanCell class]) forIndexPath:indexPath];
            [cell loaddataWithModel:rowModle.scanModel row:indexPath.section ScanType:self.scanVcType];
            return cell;
        }
            break;
            
        case ScanHistoryRowType:
        {
            WriteScanhistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WriteScanhistoryCell class]) forIndexPath:indexPath];
            [cell loadDataWithModel:rowModle.hisModel ScanType:self.scanVcType];
            
            return cell;
        }
            break;
       
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *indexrow = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    WriteScanCell *cell = [tableView cellForRowAtIndexPath:indexrow];
    cell.selected = YES;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *indexrow = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    WriteScanCell *cell = [tableView cellForRowAtIndexPath:indexrow];
    cell.selected = NO;
}



#pragma mark- lazy
-(CheckBillSelectView *)view_billCheckSelect{
    if (!_view_billCheckSelect) {
        _view_billCheckSelect = [CheckBillSelectView new];
    }
    return _view_billCheckSelect;
}


@end
