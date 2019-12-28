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
#import "CheckBillSelectView.h"
#import "LookZSVC.h"
#import "LookCerNetViewModel.h"
#import "ShowMoreImageView.h"
#import "PDFImageModel.h"
#import "AddBZVC.h"
#import "WriteScanYDVC.h"


@interface ScanVC ()<leftViewDelegate>

@property (nonatomic) LeftView *leftView;

@property (nonatomic) RightView *rightVIew;
@property (nonatomic,strong) CheckBillSelectView *view_billCheckSelect;


@property (nonatomic) ScanNetViewModel *NetViewModel;

/// vctype:扫描  查验
@property (nonatomic,assign) ScanType vcType;

/// 当前选中index
@property (nonatomic,assign) NSInteger currentSelectIndex;
@property (nonatomic,copy) NSString *refResult;

/// 是否改变过当前运单
@property (nonatomic,assign) BOOL checkIsHaveControl;

@end

@implementation ScanVC
-(instancetype)initWithScanVCType:(ScanType)vcType{
    if (self = [super init]) {
        self.vcType = vcType;
    }
    return self;
}
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
    ScanBillModel *model = dic[@"data"];
    [self successScanEventWithModel:model];
    
}

//- (void)inputVC{
// 
//    switch (self.vcType) {
//        case SCANYGD:
//        {
//
//            WriteScanYDVC *vc = [[WriteScanYDVC alloc] init];
//            
//            vc.machID = self.machID;
//            vc.scanVcType = self.vcType;
//            
//            
//            switch (self.detectionType) {
//                    
//                case DetectionTypeFirst:
//                {
//                    vc.type = FirstScanYDType;
//                }
//                    break;
//                case DetectionTypeTwentyFour:
//                {
//                    vc.type = TwentyScanYDType;
//
//                }
//                    break;
//                case DetectionType9610System:
//                {
//                    vc.type = ScanYDType9610Systm;
//
//                }
//                    break;
//            }
//            
//            [self.navigationController pushViewController:vc animated:YES];
//
//            
//        }
//            break;
//       case ScanTypeCheck:
//       {
//
//           WriteScanYDVC *vc = [[WriteScanYDVC alloc] init];
//           
//           vc.machID = self.machID;
//           vc.scanVcType = self.vcType;
//           switch (self.detectionType) {
//                   
//               case DetectionTypeFirst:
//               {
//                   vc.type = FirstScanYDType;
//               }
//                   break;
//               case DetectionTypeTwentyFour:
//               {
//                   vc.type = TwentyScanYDType;
//
//               }
//                   break;
//               case DetectionType9610System:
//               {
//                   vc.type = ScanYDType9610Systm;
//
//               }
//                   break;
//           }
//           UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//              
//          nav.modalPresentationStyle = UIModalPresentationFormSheet;
//          
//          [self presentViewController:nav animated:YES completion:nil];
//           
//       }
//           break;
//
//    }
//    
// 
//}


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
    
    if (self.vcType == ScanTypeCheck && self.checkIsHaveControl) {
        [MBProgressHUD showTextView:self.view textTitle:@"请先保存当前分单查验结论再进行扫描！"];
        return;
    }
    
    PreSentScanVC *scanvc = [[PreSentScanVC alloc] init];
    
    if (self.vcType == ScanTypeCheck) {
        scanvc.type = ScanTypeCheck;
    }else{
        scanvc.type = SCANYGD;
    }
    
    scanvc.MachID = self.machID;
    
    switch (self.detectionType) {
            
        case DetectionTypeFirst:
        {
            scanvc.fromType = FromFirstCome;
        }
            break;
        case DetectionTypeTwentyFour:
        {
            scanvc.fromType = FromTwentyCome;
        }
            break;
        case DetectionType9610System:
        {
            scanvc.fromType = From9610System;
        }
            break;
            
    }
    WEAK_SELF;
    scanvc.block = ^(NSString *scanStr) {
        
        [weakSelf RequestDDinfoWithStr:scanStr];
        FlyLog(@"%@",scanStr);
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scanvc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nav animated:YES completion:nil];
}

//请求订单信息
- (void)RequestDDinfoWithStr:(NSString *)str{
    
    
    __weak typeof(self)weakself = self;
    
    
    
    if (self.vcType == ScanTypeCheck) {
    
        [self.NetViewModel loaddataWitNumber:str start:^{
            [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在加载"];
        } success:^(id data) {
            [MBProgressHUD showSuccessView:weakself.view];
            if ([data isKindOfClass:[NSArray class]]) {
                NSArray *dataArr  = data;
                ScanBillModel *model = dataArr.firstObject;
                if (dataArr.count>1) {
                    weakself.view_billCheckSelect.dataSource = dataArr;
                    [weakself.view_billCheckSelect showBillSelectViewWithSuperView:self.view];
                    weakself.view_billCheckSelect.didSeleced = ^(ScanBillModel * _Nonnull billModel) {
                        [weakself successScanEventWithModel:billModel];
                    };
                }else{
                    [weakself successScanEventWithModel:model];
                }
            }
        } fail:^(NSString *failStr) {
            [MBProgressHUD showErrorView:weakself.view errorTitle:failStr];
           weakself.rightVIew.infoView.hidden = YES;
           
           [weakself.leftView.tableview reloadData];
                       
        }];
    }else{
        [self.NetViewModel loaddataWithMachID:self.machID number:str TypeStr:[self MytypeStr] start:^{
            [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在加载"];
        } success:^(ScanBillModel *model) {
            model.scanType = weakself.vcType;
            [MBProgressHUD showSuccessView:weakself.view];
            
            [weakself successScanEventWithModel:model];
            
            
        } fail:^(NSString *failStr) {
            
            [MBProgressHUD showErrorView:weakself.view errorTitle:failStr];
            
            weakself.rightVIew.infoView.hidden = YES;
            
            [weakself.leftView.tableview reloadData];
            
        }];
    }

}

//成功扫描
- (void)successScanEventWithModel:(ScanBillModel *)model{
    
    if (self.vcType == ScanTypeCheck) {
        if (self.leftView.dataArray.count>0) {
            [self.leftView.dataArray removeAllObjects];
        }
    }
    //如果已经存在单号，不需要重新添加
    int j = -1;
    
    for (int i=0; i<self.leftView.dataArray.count; i++) {
        
        ScanSectionModel *sectionModel  = self.leftView.dataArray[i];
        
        if ([sectionModel.scanModel.waybill.waybillno isEqualToString:model.waybill.waybillno]) {
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
- (void)SelectRowShowModel:(ScanBillModel *)model{
    for (int i = 0; i<self.leftView.dataArray.count; i++) {
        ScanSectionModel *sectionModel = [self.leftView.dataArray lastObject];
        if ([sectionModel.scanModel.waybill.waybillno isEqualToString:model.waybill.waybillno]) {
            self.currentSelectIndex = i;
        }
    }
    
    
    [self.rightVIew configDataWithBillModel:model];
}

//删除隐藏相应数据
- (void)deleteEvent{
    
    [self.rightVIew configDataWithBillModel:nil];
}

//保存数据
- (void)saveEventWith:(NSMutableArray *)dataarray{
    
    //查验
    if (self.vcType == ScanTypeCheck && self.detectionType == DetectionType9610System) {
        self.checkIsHaveControl = NO;
        [self saveCheckOrderWithrefResult:self.refResult];
    }else{//扫描

        if (dataarray.count<=0) {
            [MBProgressHUD showTextView:self.navigationController.view textTitle:@"请先添加运单"];
            return;
        }
        
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (ScanSectionModel *sectionModel in dataarray) {
            
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
}
#pragma mark- 查看证书
//查看证书
- (void)lookZhengShu{
    
    
    ScanSectionModel *sectionModel = [self.leftView.dataArray lastObject];
    ScanBillModel *billModel = sectionModel.scanModel;
    if (billModel.books.count == 1) {//就一个证书
        
        [self LookZSPicWithModel:[billModel.books firstObject]];
        
    }else if(billModel.books.count>1){//多个证书
        
        LookZSVC *vc= [[LookZSVC alloc] init];
        
        vc.dataarray = billModel.books;
        
        WEAK_SELF
        vc.Block = ^(BooksModel *model) {
            [weakSelf LookZSPicWithModel:model];
        };
        
        vc.modalPresentationStyle = UIModalPresentationPopover;
        
        vc.popoverPresentationController.backgroundColor = [UIColor whiteColor];
        
        vc.popoverPresentationController.sourceView = self.rightVIew.view_checkInfo.imageView_pdf;
        
        vc.popoverPresentationController.sourceRect = self.rightVIew.view_checkInfo.imageView_pdf.bounds;
        
        vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionRight;
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    
}
//查看证书
- (void)LookZSPicWithModel:(BooksModel *)mdoel{
    
    
    NSString *bookid = [BaseVerifyUtils isNullOrSpaceStr:mdoel.BookID] ? mdoel.ID : mdoel.BookID;
    WEAK_SELF
    [[LookCerNetViewModel new] RequestCerImageArrayWithBookID:bookid start:^{
        [MBProgressHUD showLoadView:self.view loadTitle:@"正在加载证书"];
    } Success:^(PDFImageModel *Pdfmodel) {
        [MBProgressHUD showSuccessView:self.view];
        
        [ShowMoreImageView showImageViewWithImageUrlArray:Pdfmodel.picArray selcectIndex:0];
    } fail:^(NSString *failStr) {
        [MBProgressHUD showErrorView:weakSelf.view errorTitle:failStr];
    }];

}
#pragma mark- 备注
////进入备注页面
- (void)IntoBZVC{

    if (self.leftView.dataArray.count == 0) {
        [MBProgressHUD showTextView:self.view textTitle:@"没有运单,请扫描之后再添加备注"];
        return;
    }
    
    ScanSectionModel *sectionModel = self.leftView.dataArray[self.currentSelectIndex];
    ScanBillModel *billModel = sectionModel.scanModel;
    AddBZVC *addvc = [[AddBZVC alloc] init];

    addvc.block = ^{

//        [self requestData];
    };
    addvc.opeartionModel = self.operationModel;
    addvc.MachID = self.machID;
    addvc.aWID = billModel.subWaybill.awId;
    addvc.YDH = billModel.subWaybill.waybillno;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addvc];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.preferredContentSize = CGSizeMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 100);

    [self presentViewController:nav animated:YES completion:nil];
}

-(void)saveCheckOrderWithrefResult:(NSString *)refResult{
    ScanSectionModel *sectionModel = self.leftView.dataArray[self.currentSelectIndex];
    ScanBillModel *billModel = sectionModel.scanModel;
    if ([BaseVerifyUtils isNullOrSpaceStr:refResult]) {
        refResult = billModel.subWaybill.refResult;
    }
    if ([BaseVerifyUtils isNullOrSpaceStr:refResult]) {
        [MBProgressHUD showTextView:self.view textTitle:@"请先给出查验结论再保存！"];
        return;
    }
    
    WEAK_SELF
    [self.NetViewModel saveCheckActionWithAwId:billModel.subWaybill.awId refResult:refResult start:^{
        [MBProgressHUD showLoadView:weakSelf.view loadTitle:@"正在保存"];
    } success:^(id data) {
        [weakSelf.leftView.dataArray removeAllObjects];
        [weakSelf deleteEvent];
        [weakSelf.leftView.tableview reloadData];
        [weakSelf scanEvent];
        [MBProgressHUD showSuccessView:weakSelf.view];
    } fail:^(NSString *failStr) {
        [MBProgressHUD showTextView:weakSelf.view textTitle:failStr];
    }];
}
#pragma mark- click
/// 1.不合格 2.暂扣 3.通过 4.备注  // 通过pass 不合格 unqualified   暂扣 hold
-(void)hangdleCheckBottomClickType:(NSInteger)clickType{
    if (self.vcType == ScanTypeCheck) {
        self.checkIsHaveControl = YES;
    }
    if (clickType == 1) {
        self.refResult = unqualified;
    }else if (clickType == 2){
        self.refResult = hold;
    }else if (clickType == 3){
        self.refResult = pass;
    }else if (clickType == 4){
        [self IntoBZVC];
    }
}

#pragma mark------------------------------------------------------------------------------------
- (NSString *)MytypeStr{
    
    NSString *typeStr;
    switch (self.detectionType) {
        case DetectionTypeFirst:
        {
            typeStr = @"0";
        }
            break;
        case DetectionTypeTwentyFour:
        {
            typeStr = @"1";
            
        }
            break;
        case DetectionType9610System:
        {
            typeStr = @"2";
        }
            break;
    }
    return typeStr;
    
}

- (void)creatUI{
    
    
    self.title = self.vcType== ScanTypeCheck?@"查验":@"扫描";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];

    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightVIew];
    
    [self layout];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)layout{
    
    CGFloat pad = kuan *0.02;
    
    CGFloat VPad = self.view.bounds.size.height *0.02;
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(VPad);
        make.bottom.equalTo(self.view).offset(-VPad);
        make.left.equalTo(self.view).offset(pad);
        make.width.equalTo(self.view).multipliedBy(0.45);
    }];
    
    [_rightVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.leftView);
        make.right.equalTo(self.view).offset(-pad);
        make.left.equalTo(self.leftView.mas_right).offset(pad);
    }];
}

- (LeftView *)leftView{
    if (!_leftView) {
        CGFloat pad = kuan *0.02;
        CGFloat VPad = self.view.bounds.size.height *0.02;
        _leftView = [[LeftView alloc] initWithFrame:CGRectMake(pad, VPad, kScreenWidth*0.45, self.view.bounds.size.height) vcType:self.vcType Dectection:self.detectionType];
        _leftView.layer.masksToBounds = YES;
        _leftView.layer.cornerRadius = 15;
        _leftView.backgroundColor = [UIColor whiteColor];
        _leftView.delelgate = self;
    }
    return _leftView;
}

- (RightView *)rightVIew{
    if (!_rightVIew) {
        CGFloat pad = kuan *0.02;
        CGFloat VPad = self.view.bounds.size.height *0.02;
        CGFloat rightX = pad + kScreenWidth *0.45 + pad ;
        _rightVIew = [[RightView alloc] initWithFrame:CGRectMake(rightX, VPad, kScreenWidth - rightX-pad, self.view.bounds.size.height-2*pad) vcType:self.vcType];
        _rightVIew.layer.masksToBounds = YES;
        _rightVIew.layer.cornerRadius = 15;
        _rightVIew.backgroundColor = [UIColor whiteColor];
        [_rightVIew.ScanBtn addTarget:self action:@selector(scanEvent) forControlEvents:UIControlEventTouchUpInside];
        WEAK_SELF;
        _rightVIew.view_checkInfo.zhengShuClick = ^(BOOL isClick) {
            [weakSelf lookZhengShu];
        };
        _rightVIew.bottomClickBlock = ^(NSInteger clickType) {
            [weakSelf hangdleCheckBottomClickType:clickType];
        };
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


#pragma mark- lazy
-(CheckBillSelectView *)view_billCheckSelect{
    if (!_view_billCheckSelect) {
        _view_billCheckSelect = [CheckBillSelectView new];
    }
    return _view_billCheckSelect;
}


@end
