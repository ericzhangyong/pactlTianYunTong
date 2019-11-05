//
//  YDDetailVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "YDDetailVC.h"
#import "DetailYDNetViewModel.h"
#import "MBProgressHUD+FLyHUD.h"
#import "LoadDataFailView.h"
#import "DetailDataManager.h"
#import "DetailSectionModel.h"
#import "DetailBookCell.h"
#import "DetailWayBillCell.h"
#import "DeailInfoCell.h"
#import "DeatilCheckCell.h"
#import "DetailRowMOdel.h"
#import "DetailTableheadView.h"
#import "DetailModel.h"
#import "DetailFDAllCell.h"
#import "AddBZVC.h"
#import "DeviceModel.h"
#import "infoModel.h"
#import "WayBillModel.h"
#import "LookCerNetViewModel.h"
#import "DetailBook.h"
#import "ShowMoreImageView.h"
#import "PDFImageModel.h"
#import "CheckModel.h"
#import "Masonry.h"

@interface YDDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) DetailYDNetViewModel *NetViewModel;

@property (nonatomic) DetailTableheadView *headview;

@property (nonatomic) UITableView *tableview;

@property (nonatomic) DetailDataManager *dataManager;

@property (nonatomic) LookCerNetViewModel *PDfNetViewModel;

@end

@implementation YDDetailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self creatUI];
    
    [self requestData];
    
}

//请求数据
- (void)requestData{
    
    
    NSString *type;
    
    switch (self.type) {
        case DetectionTypeFirst:
        {
            type = @"0";
        }
            break;
            
        case DetectionTypeTwentyFour:
        {
            type = @"1";
            
        }
            break;
        case DetectionType9610System:
         {
            type = @"2";
                   
        }
        break;
    }
    
    [self.NetViewModel loadDataWithView:self.view aWID:self.aWID deviceModel:self.deviceModel type:type success:^(GPModel *gpModel, DetailModel *detailModel) {
        [self SuccessEventWith:gpModel detailModel:detailModel];

    } fail:^(NSString *FailStr) {
        [MBProgressHUD showTextView:self.view textTitle:FailStr];
        [self FailEvent];
    }];
    
}

//成功
- (void)SuccessEventWith:(GPModel *)gpModel detailModel:(DetailModel *)detailModel{
    
   
    self.dataManager = [[DetailDataManager alloc] initWithWith:detailModel gpModel:gpModel];
    
    
    [self.headview setDataWithInfoModel:self.dataManager.detailModel.infomdel testModel:self.dataManager.detailModel.testModel gpModel:self.dataManager.gpModel testWord:self.testWord checkModel:[self.dataManager.detailModel.checkArray firstObject] AgentShortName:self.dataManager.detailModel.agentShortName iscontrol:detailModel.iscontrol isABControl:detailModel.isABcontrol detectionType:self.type];
    
    [self.tableview reloadData];

}

//失败
- (void)FailEvent{
    
    __weak typeof(self)weakself = self;
    
    [LoadDataFailView ShowLoadFailViewWith:self.view frame:FirstFrame clickBtn:^{
        
        [weakself requestData];
        
    }];
}

#pragma mark------------------------------------------------------------------------------------
//主单备注
- (void)ZDBZEvent{
  
    [self IntoBZEventWithaWID:self.dataManager.detailModel.infomdel.awId YDH:self.dataManager.detailModel.infomdel.waybillNo];
   
}

//分单备注
- (void)FDBZWithSender:(UIButton *)sender{
    
   NSInteger row = sender.tag;
    
    WayBillModel *model = self.dataManager.detailModel.waybillArray[row];
    
    [self IntoBZEventWithaWID:model.awId YDH:model.waybill_no];
    
    
}

//进入备注页面
- (void)IntoBZEventWithaWID:(NSString *)awID YDH:(NSString *)YDH{
    
    AddBZVC *addvc = [[AddBZVC alloc] init];
    
    addvc.block = ^{
        
        [self requestData];
    };
    
    addvc.opeartionModel = self.opeationModel;
    
    addvc.MachID = self.deviceModel.machinID;
    
    addvc.aWID = awID;
    
    addvc.YDH = YDH;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addvc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    nav.preferredContentSize = CGSizeMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 100);
    
    [self presentViewController:nav animated:YES completion:nil];
}

//查看证书
- (void)LookCerEventWithDataRow:(NSInteger)dataRow{
    
    DetailBook *bookModel = self.dataManager.detailModel.canUseBookArray[dataRow];
    
    NSString *bookid = [bookModel.bookId isEqualToString:@""] ? bookModel.ID : bookModel.bookId;

    [self.PDfNetViewModel RequestCerImageArrayWithBookID:bookid start:^{
        [MBProgressHUD showLoadView:self.view loadTitle:@"正在加载证书"];
    } Success:^(PDFImageModel *Pdfmodel) {
        [MBProgressHUD showSuccessView:self.view];
        
        [ShowMoreImageView showImageViewWithImageUrlArray:Pdfmodel.picArray selcectIndex:0];
    } fail:^(NSString *failStr) {
        [MBProgressHUD showErrorView:self.view errorTitle:failStr];
    }];
}
#pragma mark------------------------------------Delegate-----------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataManager.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    DetailSectionModel *model = self.dataManager.dataArray[section];
    
    return model.rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailSectionModel *sectionModel = self.dataManager.dataArray[indexPath.section];
    
    DetailRowMOdel *rowmodel = sectionModel.rowArray[indexPath.row];
    
    switch (rowmodel.rowType) {
            
        case RowInfoCellType:
        {
            DeailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeailInfoCellID" forIndexPath:indexPath];
            [cell.BZBtn addTarget:self action:@selector(ZDBZEvent) forControlEvents:UIControlEventTouchUpInside];
            [cell loaddataWithInfomationModel:rowmodel.infomdoel remakcount:self.dataManager.detailModel.count];

            return cell;
        }
            break;
        case RowFDCellType:
        {
            DetailWayBillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailWayBillCellID" forIndexPath:indexPath];
            cell.BZBtn.tag = rowmodel.dataRow;
            [cell.BZBtn addTarget:self action:@selector(FDBZWithSender:) forControlEvents:UIControlEventTouchUpInside];
            [cell loaddatawithModel:rowmodel.waymodel detectionType:self.type];
            return cell;
        }
            break;
        case RowCerCellType:
        {
            DetailBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookCellID" forIndexPath:indexPath];
            [cell loadDataWithModel:rowmodel.bookModel];
            return cell;
        }
            break;
        case RowCehckTYpe:
        {
            DeatilCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeatilCheckCellID" forIndexPath:indexPath];
            [cell loadDataWithModel:rowmodel.checmodel];
            return cell;
        }
            break;
            
            
        case RowCerFDALLCellType:
        {
            DetailFDAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFDAllCellID" forIndexPath:indexPath];
            [cell loaddataWithModel:rowmodel.allmodel];
            return cell;
        }
            break;
            
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailSectionModel *model = self.dataManager.dataArray[indexPath.section];
    
    if (model.cellType == SetionDetailBookCellType) {
    
        DetailRowMOdel *rowmodel = model.rowArray[indexPath.row];
        
        if (rowmodel.rowType == RowCerCellType) {
            [self LookCerEventWithDataRow:rowmodel.dataRow];
        }
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    DetailSectionModel *model = self.dataManager.dataArray[section];
    return model.sectionHeadHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    DetailSectionModel *model = self.dataManager.dataArray[section];
    return model.SectionFootHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DetailSectionModel *model = self.dataManager.dataArray[section];
    
    return model.SectionheadView;

}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    DetailSectionModel *model = self.dataManager.dataArray[section];
    
    return model.SectionFooterView;
}


#pragma mark------------------------------------------------------------------------------------

- (DetailYDNetViewModel *)NetViewModel{
    if (!_NetViewModel) {
        _NetViewModel = [[DetailYDNetViewModel alloc] init];
    }
    return _NetViewModel;
}

- (LookCerNetViewModel *)PDfNetViewModel{
    if (!_PDfNetViewModel) {
        _PDfNetViewModel = [[LookCerNetViewModel alloc] init];
    }
    return _PDfNetViewModel;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 300;
        _tableview.estimatedSectionFooterHeight = 35;
        _tableview.estimatedSectionHeaderHeight = 60;
        
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    
        
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
       
        
        [_tableview registerNib:[UINib nibWithNibName:@"DeailInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DeailInfoCellID"];
        
        [_tableview registerNib:[UINib nibWithNibName:@"DetailWayBillCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DetailWayBillCellID"];
        
        [_tableview registerNib:[UINib nibWithNibName:@"DetailBookCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DetailBookCellID"];
        
        [_tableview registerNib:[UINib nibWithNibName:@"DeatilCheckCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DeatilCheckCellID"];
        
        [_tableview registerNib:[UINib nibWithNibName:@"DetailFDAllCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DetailFDAllCellID"];
        
    }
    return _tableview;
}


- (void)creatUI{
    
    self.title = @"运单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headview];
    [self.view addSubview:self.tableview];
    
    [self layout];
}

- (void)layout{
    
    [_headview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headview.mas_bottom);
    }];
}

- (DetailTableheadView *)headview{
    
    if (!_headview) {
        _headview = [[DetailTableheadView alloc] init];
    }
    return _headview;
}

@end
