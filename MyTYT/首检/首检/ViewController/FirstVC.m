//
//  FirstVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FirstVC.h"
#import "LoginVC.h"
#import "HeadView.h"
#import "Mycell.h"
#import "FirstNetViewModel.h"
#import "SelectVC.h"
#import "ScanVC.h"
#import "NotificationVC.h"
#import "FirstModel.h"
#import "LookZSVC.h"
#import "NewBZVC.h"
#import "AllModel.h"
#import "LastLoginTimeModel.h"
#import "OperationMachinModel.h"
#import "MBProgressHUD+FLyHUD.h"
#import "DeviceModel.h"
#import "FirstAllModel.h"
#import "TwentyForuHourRoadModel.h"
#import "RoadModel.h"
#import "TestModel.h"
#import "SelectStateModel.h"
#import "LoadDataFailView.h"
#import "ShowMoreImageView.h"
#import "PDFImageModel.h"
#import "LookCerNetViewModel.h"
#import "BooksModel.h"
#import "YDDetailVC.h"
#import "QueryShareCerVC.h"
#import "CerNeedDataModel.h"
#import "LikeSystemAleartView.h"
#import "SelectModel.h"
#import "ShowUserAgreeVIew.h"
#import "ProtocolModel.h"
#import "ControlAlertView.h"
#import "ControlModel.h"
#import "ClickControlModel.h"

@interface FirstVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableview;

@property (nonatomic) HeadView *headview;

@property (nonatomic) NSMutableArray *dataarray;

@property (nonatomic) NSMutableArray *AgentArray;

@property (nonatomic) FirstNetViewModel *NetViewModel;

@property (nonatomic) LookCerNetViewModel *PDfNetViewModel;

@property (nonatomic,assign) NSInteger SelectCount;

@property (nonatomic,assign) BOOL isAgee;


@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    [self showLastTime];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestNetWork];
    
    
}

#pragma------------------------------------------------------------
- (void)requestNetWork{
    
    self.SelectCount = 0;
    self.isAgee = NO;
    
    __weak typeof(self)weakself = self;
    
    [self.NetViewModel loadDataWithView:self.view MachId:self.allmodel.deviceModel.machinID agentName:@"" success:^(FirstAllModel *firstAllModel) {
        
        if (firstAllModel.ok == 1) {
            
            if (firstAllModel.dataarray.count>0) {//有数据
                [weakself freshTableDataWithModel:firstAllModel];
                
                [weakself ControlAlerat];
                
            }else{
                [weakself freshTableDataWithModel:firstAllModel];
            }
            
            [weakself setAgentData];
            
            [weakself setYJTGState];
            
        }else{
            
            [MBProgressHUD showTextView:self.view textTitle:firstAllModel.msg];
        }
        
    } failStr:^(NSString *failStr) {
        
        [weakself failEvent];
        
    }];
}

//加载失败
- (void)failEvent{
    
    __weak typeof(self)weakself = self;
    
    [LoadDataFailView ShowLoadFailViewWith:weakself.view frame:weakself.view.bounds clickBtn:^{
        
        [weakself requestNetWork];
        
    }];
}

#pragma mark-------------------------------------设置数据-----------------------------------------------
//刷新事件
- (void)freshEvent{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (FirstModel *model in self.dataarray) {
        
        if ([model.THOrDD isEqualToString:@""] && ![model.LocalstateModel.state isEqualToString:@""]) {//是本地而且有状态
            
            [array addObject:model];
        }
        
    }
    
    
    if (array.count<=0) {//没有数据保存就刷新数据
        [self freshDataListWithType:FirstBtnFresh agent:@""];
    }else{
        
        [self alertWithTitle:@"提示" message:@"您有数据未保存,刷新您将丢失未保存的数据,是否继续刷新?" ok:^{
            [self freshDataListWithType:FirstBtnFresh agent:@""];
        } cancel:^{
            
        }];
    }
}

//刷新列表
- (void)freshTableDataWithModel:(FirstAllModel *)firstAllModel{
    
    [self setMyModel:firstAllModel];
    
    self.dataarray = [NSMutableArray arrayWithArray:firstAllModel.dataarray];
    
    [self.tableview reloadData];
    
}

//控提示
- (void)ControlAlerat{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.dataarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FirstModel *mdoel = (FirstModel *)obj;
        
        if ([mdoel.isnew isEqualToString:@"1"] && (mdoel.iscontrol == YES || mdoel.isABControl == YES)) {//新扫描的而且受布控
            ControlModel *controlModel = [[ControlModel alloc] initWithFirstModel:mdoel];
            [array addObject:controlModel];
        }
    }];
    
    if (array.count>0) {
        [ControlAlertView showControlAleratViewWithArray:array type:OnlySureBtn toptitle:@"布控提示" bottomTitle:@"确定" sure:^{
            
        } cancel:^{
            
        }];
    }
    
}

//设置24小时通道
- (void)setMyModel:(FirstAllModel *)myallmodel{
    
    
    for (FirstModel *model in myallmodel.dataarray) {
        
        model.testText = self.allmodel.textModel.regVal;
        
        if ([model.aisle24 isEqualToString:@""]) {
            
        }else{
            
            for (RoadModel *temmodel in self.allmodel.RoadModel.roadArray) {
                
                if ([temmodel.ID isEqualToString:model.aisle24] &&[temmodel.ctid isEqualToString:self.allmodel.operationModel.ctId]) {
                    model.aisle24 = temmodel.name;
                }
            }
        }
    }
    
}

//设置代理
- (void)setAgentData{
    
    [self.headview.allBtn setTitle:@"全部" forState:UIControlStateNormal];
    
    [self.AgentArray removeAllObjects];
    
    SelectModel *selectmodel = [[SelectModel alloc] initWithAgentName:@"" name:@"全部"];
    
    [self.AgentArray addObject:selectmodel];
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    for (FirstModel *mdoel in self.dataarray) {
        
        
        NSString *DL = [mdoel.agent_short_name isEqualToString:@""] ? mdoel.daili : mdoel.agent_short_name;
        
        if ([array containsObject:DL]) {
            
        }else{
            
            SelectModel *selectModel = [[SelectModel alloc] initWithAgentName:mdoel.daili name:DL];
            
            [array addObject:DL];
            
            [self.AgentArray addObject:selectModel];
        }
    }
    
}

//设置一键通过状态
- (void)setYJTGState{
    
    self.isAgee = NO;
    [self.headview.YJTGBTn setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
}

#pragma mark---------------------------------------Event---------------------------------------------

//扫瞄
- (void)scanEvent{
    ScanVC *scanvc = [[ScanVC alloc] init];
    
    scanvc.machID = self.allmodel.deviceModel.machinID;
    
    scanvc.intoScantype = FirstScanType;
    
    [self.navigationController pushViewController:scanvc animated:NO];
}

//筛选
- (void)selctEvent{
    
    
    SelectVC *vc = [[SelectVC alloc] init];
    
    vc.AgentArray = self.AgentArray;
    
    vc.block = ^(SelectModel *model) {
        [self.headview.allBtn setTitle:model.name forState:UIControlStateNormal];
        
        [self freshDataListWithType:FirsgFreshChengAgent agent:model.agentName];
    };
    
    UINavigationController *nav = [[UINavigationController alloc ] initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationPopover;
    
    nav.popoverPresentationController.sourceView = self.headview.allBtn;
    
    nav.popoverPresentationController.sourceRect = self.headview.allBtn.bounds;
    
    nav.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    //    nav.preferredContentSize = CGSizeMake(self.view.bounds.size.width*0.35, 200);
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

//查询共享证书
- (void)queryCerEvent{
    QueryShareCerVC *vc = [[QueryShareCerVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
}

//操作说明
- (void)OpeationEvent{
    
    [ShowUserAgreeVIew showUserTitle:@"操作说明" content:self.allmodel.protocolModel.protocolContrnt type:ShowOperationType agree:^{
        
    } dontAgree:^{
        
    }];
}

//查看总单号
- (void)lookZD:(UIButton *)sender{
    
    NSInteger row = sender.tag - 100;
    
    FirstModel *mdoel = self.dataarray[row];
    
    YDDetailVC *detailVC = [[YDDetailVC alloc] init];
    
    detailVC.type = FirstDetailType;
    
    detailVC.aWID = mdoel.awId;
    
    detailVC.testWord = mdoel.testText;
    
    detailVC.opeationModel = self.allmodel.operationModel;
    
    detailVC.deviceModel = self.allmodel.deviceModel;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

//查看证书
- (void)lookZS:(UIButton *)sender{
    
    NSInteger row = sender.tag - 100;
    
    FirstModel *mdoel = self.dataarray[row];
    
    if (mdoel.bookArray.count == 1) {//就一个证书
        
        [self LookZSPicWithModel:[mdoel.bookArray firstObject]];
        
    }else if(mdoel.bookArray.count>1){//多个证书
        
        LookZSVC *vc= [[LookZSVC alloc] init];
        
        vc.dataarray = mdoel.bookArray;
        
        vc.Block = ^(BooksModel *model) {
            [self LookZSPicWithModel:model];
        };
        
        vc.modalPresentationStyle = UIModalPresentationPopover;
        
        vc.popoverPresentationController.backgroundColor = [UIColor whiteColor];
        
        vc.popoverPresentationController.sourceView = sender;
        
        vc.popoverPresentationController.sourceRect = sender.bounds;
        
        vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionRight;
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    
}
//查看证书
- (void)LookZSPicWithModel:(BooksModel *)mdoel{
    
    NSString *bookid = [mdoel.BookID isEqualToString:@""] ? mdoel.ID : mdoel.BookID;
    
    [self.PDfNetViewModel RequestCerImageArrayWithBookID:bookid start:^{
        [MBProgressHUD showLoadView:self.view loadTitle:@"正在加载证书"];
    } Success:^(PDFImageModel *Pdfmodel) {
        [MBProgressHUD showSuccessView:self.view];
        
        [ShowMoreImageView showImageViewWithImageUrlArray:Pdfmodel.picArray selcectIndex:0];
    } fail:^(NSString *failStr) {
        [self ShowFailNetReasonWith:failStr];
    }];
    
}

//通知
- (void)notifiactionWith:(UIButton *)sender{
    
    NSInteger row = sender.tag - 100;
    
    FirstModel *mdoel = self.dataarray[row];
    
    Mycell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    NotificationVC *notificationVC = [[NotificationVC alloc] init];
    
    notificationVC.notifiarray = mdoel.noticeArray;
    
    notificationVC.MachID = self.allmodel.deviceModel.machinID;
    
    notificationVC.block = ^(NSArray *notifiarray) {
        mdoel.noticeArray = [NSArray arrayWithArray:notifiarray];
        [self.tableview reloadData];
    };
    
    notificationVC.YDH = mdoel.ALLNUmber;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:notificationVC];
    
    nav.modalPresentationStyle = UIModalPresentationPopover;
    
    nav.popoverPresentationController.sourceView = cell.TZBtn;
    
    nav.popoverPresentationController.sourceRect = cell.TZBtn.bounds;
    
    nav.preferredContentSize = CGSizeMake(self.view.bounds.size.width *0.4, 350);
    
    nav.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark------------------------------------------------------------------------------------
//保存
- (void)saveEvent{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (FirstModel *model in self.dataarray) {
        
        if ([model.THOrDD isEqualToString:@""] && ![model.LocalstateModel.state isEqualToString:@""]) {//是本地而且有状态
            
            [array addObject:model];
        }
        
    }
    
    
    if (array.count<=0) {//没有数据保存就刷新数据
        
        [self freshDataListWithType:FirstFreshOnly agent:@""];//请求刷新接口
        
    }else{
        
        __weak typeof(self)weakself = self;
        
        
        [self.NetViewModel updateCheckWithArray:array machineID:self.allmodel.deviceModel.machinID start:^{
            
            [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在保存"];
            
        } success:^{
            
            [weakself freshDataListWithType:FirstFreshSave agent:@""];
            
        } fail:^(NSString *failStr) {
            
            [weakself ShowFailNetReasonWith:failStr];
            
        } Failreason:^(NSString *reason) {
            
            [weakself ShowFailNetReasonWith:reason];
        }];
    }
    
}

#pragma mark------------------------------------------------------------------------------------
//刷新列表
- (void)freshDataListWithType:(FirstFreshDataType)type
                        agent:(NSString *)agent{
    
    __weak typeof(self)weakself = self;
    
    switch (type) {
            
        case FirstBtnFresh:
        {
            [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在刷新列表数据"];
            
        }
            break;
            
        case FirstFreshOnly:
        {
            [MBProgressHUD showLoadView:self.view loadTitle:@"正在刷新列表数据"];
            
        }
            break;
            
        case FirstFreshSave:
        {
            
        }
            break;
            
        case FirsgFreshChengAgent:
        {
            [MBProgressHUD showLoadView:self.view loadTitle:@"正在切换代理"];
            
        }
            break;
        case FirstFreshDelete:
        {
            
        }
            break;
    }
    
    [self.NetViewModel FreshDataListWitMachId:self.allmodel.deviceModel.machinID agentName:agent success:^(FirstAllModel *firstAllModel) {
        
        if (firstAllModel.ok == 1) {
            
            switch (type) {
                case FirstBtnFresh:
                {
                    [MBProgressHUD showSuccessView:self.navigationController.view SuccessTitle:@"刷新列表数据成功"];
                    
                }
                    break;
                    
                case FirstFreshOnly:
                {
                    
                    [MBProgressHUD showSuccessView:self.view SuccessTitle:@"刷新列表数据成功"];
                    
                }
                    break;
                    
                case FirstFreshSave:
                {
                    [MBProgressHUD showSuccessView:self.view SuccessTitle:@"保存成功"];
                    
                }
                    break;
                    
                case FirsgFreshChengAgent:
                {
                    [MBProgressHUD showSuccessView:self.view SuccessTitle:@"切换成功"];
                }
                    break;
                case FirstFreshDelete:
                {
                    
                }
                    break;
                    
            }
            
            if (firstAllModel.dataarray.count>0) {//有数据
                [weakself freshTableDataWithModel:firstAllModel];
            }else{
                [weakself freshTableDataWithModel:firstAllModel];
            }
            
            if ([agent isEqualToString:@""]) {//全部
                [weakself setAgentData];
            }
            
            [weakself setYJTGState];//改变一建按钮状态
            
        }else{
            
            [weakself ShowFailNetReasonWith:firstAllModel.msg];
        }
        
    } failStr:^(NSString *failStr) {
        [weakself ShowFailNetReasonWith:failStr];
    }];
    
}

#pragma mark------------------------------------------------------------------------------------

//一键通过
- (void)yjTGEventWithSender:(UIButton *)sender{
    
    NSMutableArray *uparray = [NSMutableArray array];
    
    [self.dataarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FirstModel *mdoel = (FirstModel *)obj;
        
        if (([mdoel.THOrDD isEqualToString:@""] && [mdoel.LocalstateModel.state isEqualToString:@""])) {//没有结论
            [uparray addObject:mdoel];
        }
    }];
    
    if (uparray.count==0) {
        [MBProgressHUD showTextView:self.navigationController.view textTitle:@"没有可操作的数据"];
        return;
    }
    
    [self isYJAgreeClick:YES upArray:uparray block:^{
        
        
        self.isAgee = !self.isAgee;
        
        if (self.isAgee == YES) {//选中
            
            [self.headview.YJTGBTn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
            
            NSMutableArray *array = [NSMutableArray array];
            
            [self.dataarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FirstModel *mdoel = (FirstModel *)obj;
                
                if ((mdoel.iscontrol == YES || mdoel.isABControl == YES) && ([mdoel.THOrDD isEqualToString:@""] && [mdoel.LocalstateModel.state isEqualToString:@""])) {//受布控而且没有结论
                    ControlModel *controlModel = [[ControlModel alloc] initWithFirstModel:mdoel];
                    [array addObject:controlModel];
                }
            }];
            
            if (array.count>0) {
                
                [ControlAlertView showControlAleratViewWithArray:array type:AllBtn toptitle:@"含有布控运单,仍确认\"通过\"" bottomTitle:@"通过" sure:^{
                    
                    [self YJAgreeEvent];
                    
                    [self.tableview reloadData];
                    
                    
                } cancel:^{
                    self.isAgee = !self.isAgee;
                    [self.headview.YJTGBTn setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
                    
                }];
                
            }else{
                [self YJAgreeEvent];
                
                [self.tableview reloadData];
                
            }
            
            
        }else{
            
            [self.headview.YJTGBTn setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
            
            
            for (FirstModel *model in self.dataarray) {
                
                if ([model.THOrDD isEqualToString:@""] && [model.LocalstateModel.state isEqualToString:@"1"] && model.LocalstateModel.isAllAgree == YES) {//本地等于1且是通过一键操作操作的数据
                    
                    model.LocalstateModel.state = @"";
                    model.LocalstateModel.isAllAgree = NO;
                    
                    model.LocalstateModel.operationcount = 0;
                    
                }
            }
            
            [self.tableview reloadData];
            
        }
        
    }];
    
    
}
//一键通过事件
- (void)YJAgreeEvent{
    
    for (FirstModel *model in self.dataarray) {
        
        if ([model.THOrDD isEqualToString:@""] && [model.LocalstateModel.state isEqualToString:@""]) {//本地且没有操作数据
            
            model.LocalstateModel.state = @"1";
            model.LocalstateModel.isAllAgree = YES;
            
            self.SelectCount++;
            model.LocalstateModel.operationcount = self.SelectCount;
            
        }
    }
    
}

#pragma mark------------------------------------------------------------------------------------
//通过
- (void)tongguoWith:(UIButton *)sender{
    
    NSInteger row = sender.tag - 100;
    
    FirstModel *model = self.dataarray[row];
    
    [self clieckSelectWithModel:model state:@"1"];
    
}

//待定
-  (void)daidingWith:(UIButton *)sender{
    
    NSInteger row = sender.tag - 100;
    
    FirstModel *model = self.dataarray[row];
    
    [self clieckSelectWithModel:model state:@"0"];
    
    
}

//选择逻辑
- (void)clieckSelectWithModel:(FirstModel *)model state:(NSString *)state{
    
    NSString *NetState = model.THOrDD;
    
    if ([NetState isEqualToString:state]) {//操作网络取消
        [self NetcancelEventWithModde:model];
        //网络取消通过状
    }else if (![NetState isEqualToString:state] && ![NetState isEqualToString:@""]) {//操作网络相反选择
        
        [self alertWtitcancelState:NetState];
        
        
    }else if ([NetState isEqualToString:@""]){//操作本地
        
        SelectStateModel *localModle = model.LocalstateModel;
        
        if ([localModle.state isEqualToString:state]) {//操作本地取消
            
            [self LocalqueryIsCancelStateWithLocalModel:localModle model:model];
            
        }else if (![localModle.state isEqualToString:@""] && ![localModle.state isEqualToString:state]){//操作相反选择
            [self alertWtitcancelState:localModle.state];
            
        }else if ([localModle.state isEqualToString:@""]){//本地为空选择
            
            [self controlSureWithModel:model state:state];
            
        }
        
    }
}

#pragma mark------------------------------------------------------------------------------------
//网络取消
- (void)NetcancelEventWithModde:(FirstModel *)model{
    
    NSString *state;
    
    if ([model.THOrDD isEqualToString:@"0"]) {
        state = @"\"待定\"";
    }else if ([model.THOrDD isEqualToString:@"1"]){
        state = @"\"通过\"";
    }
    
    NSString *title = [[NSString alloc] initWithFormat:@"确认取消%@状态",state];
    
    NSString *DL = [model.agent_short_name isEqualToString:@""] ? model.daili : model.agent_short_name;
    
    
    NSString *info = [NSString stringWithFormat:@"%@  %@\n%@/%@  %@ ",model.ALLNUmber,model.MUdigang,model.jianshu,model.zhongliang,DL];
    
    
    [LikeSystemAleartView showViewWithTitle:title subtitle:info sureTitle:@"确定"  success:^{
        [self requestCencelEventWithMdoel:model];
    } cancel:^{
        
    }];
    
}

//取消选定状态
- (void)requestCencelEventWithMdoel:(FirstModel *)mdoel{
    
    [self.NetViewModel CanCelStateWithModel:mdoel machineID:self.allmodel.deviceModel.machinID start:^{
        [MBProgressHUD showLoadView:self.view loadTitle:@"正在取消检测状态"];
    } success:^{
        
        [MBProgressHUD showSuccessView:self.view SuccessTitle:@"取消成功"];
        mdoel.THOrDD = @"";
        [self.tableview reloadData];
        
    } fail:^(NSString *failStr) {
        [self ShowFailNetReasonWith:failStr];
    } Failreason:^(NSString *reason) {
        [self ShowFailNetReasonWith:reason];
        
    }];
}

#pragma mark------------------------------------------------------------------------------------
//询问是否取消检测状态<本地取消>
- (void)LocalqueryIsCancelStateWithLocalModel:(SelectStateModel *)localModel model:(FirstModel *)model{
    
    NSString *state;
    
    if ([localModel.state isEqualToString:@"0"]) {
        state = @"\"待定\"";
    }else if ([localModel.state isEqualToString:@"1"]){
        state = @"\"通过\"";
    }
    
    NSString *title = [[NSString alloc] initWithFormat:@"确认取消%@状态",state];
    
    NSString *DL = [model.agent_short_name isEqualToString:@""] ? model.daili : model.agent_short_name;
    
    
    NSString *info = [NSString stringWithFormat:@"%@  %@\n%@/%@  %@ ",model.ALLNUmber,model.MUdigang,model.jianshu,model.zhongliang,DL];
    
    
    [LikeSystemAleartView showViewWithTitle:title subtitle:info sureTitle:@"确定" success:^{
        localModel.state = @"";
        localModel.isAllAgree = NO;
        localModel.operationcount = 0;
        
        [self.tableview reloadData];
        
    } cancel:^{
        
    }];
    
}

//布控确认提示
- (void)controlSureWithModel:(FirstModel *)model state:(NSString *)state{
    
    
    if ([state isEqualToString:@"1"]) {//选择确认
        
        [self isYJAgreeClick:NO upArray:@[model] block:^{
            
            if ((model.iscontrol == YES || model.isABControl == YES)) {//布控
                
                ControlModel *controlModle = [[ControlModel alloc] initWithFirstModel:model];
                
                [ControlAlertView showControlAleratViewWithArray:@[controlModle] type:AllBtn toptitle:@"运单已被布控,仍确认\"通过\"" bottomTitle:@"通过" sure:^{
                    [self selectLoaclStateWithModel:model state:state];
                    
                } cancel:^{
                    
                }];
                
            }else{//没有布控
                [self selectLoaclStateWithModel:model state:state];
            }
            
        }];
        
    }else{//待定
        [self selectLoaclStateWithModel:model state:state];
    }
}

//本地无状态点击通过，网络更新运单布控s状态
- (void)isYJAgreeClick:(BOOL)isYJagree upArray:(NSArray *)Uparray block:(void(^)(void))block{
    
    [self.NetViewModel clickAgreeWithArray:Uparray start:^{
        
        [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在加载..."];
        
    } Success:^(NSArray *array) {
        
        [MBProgressHUD showSuccessView:self.navigationController.view];
        
        if (isYJagree == NO) {//点击单个通过逻辑
            
            FirstModel *firstModel = [Uparray firstObject];
            
            ClickControlModel *controlmodle = [array firstObject];
            
            firstModel.iscontrol = controlmodle.iscontrol;
            
            firstModel.isABControl = controlmodle.isABControl;
            
            [self.tableview reloadData];
            
            block();
            
        }else{
            
            for (ClickControlModel *clickModel in array) {//返回数据
                
                for (FirstModel *firstModel in Uparray) {
                    
                    if ([clickModel.awID isEqualToString:firstModel.awId]) {
                        firstModel.iscontrol = clickModel.iscontrol;
                        firstModel.isABControl = clickModel.isABControl;
                    }
                }
            }
            
            [self.tableview reloadData];
            block();
        }
        
    } fail:^(NSString *FailStr) {
        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:FailStr];
    }];
}

//布控逻辑
- (NSString *)controlStateStrWithModel:(FirstModel *)model{
    
    NSString *controlStr;
    
    if (model.iscontrol == YES && model.isABControl == YES) {
        
        controlStr = @"安检布控和安保布控";
    }else if (model.iscontrol== YES && model.isABControl == NO){
        controlStr = @"安检布控";
    }else if (model.iscontrol == NO && model.isABControl == YES){
        controlStr = @"安保布控";
    }
    
    return controlStr;
}

//选择本地状态
- (void)selectLoaclStateWithModel:(FirstModel *)model state:(NSString *)state{
    
    SelectStateModel *localModle = model.LocalstateModel;
    self.SelectCount ++;
    localModle.operationcount = self.SelectCount;
    localModle.state = state;
    
    [self.tableview reloadData];
}

#pragma mark------------------------------------------------------------------------------------
//提示取消状态
- (void)alertWtitcancelState:(NSString *)state{
    
    if ([state isEqualToString:@"0"]) {
        [MBProgressHUD showTextView:self.view textTitle:@"请先取消待定"];
    }else if([state isEqualToString:@"1"]){
        [MBProgressHUD showTextView:self.view textTitle:@"请先取消通过"];
    }
}


#pragma mark-------------------------进入备注页面------------------------------------
//添加证书
- (void)addZSWithrow:(NSInteger)row{
    
    FirstModel *firstmodel = self.dataarray[row];
    
    [self comIngBZWithFirstModel:firstmodel Type:AddCerType];
}

//进入备注类型
- (void)comIngBZWithFirstModel:(FirstModel *)firstModel Type:(ComeIngType)type{
    
    NewBZVC *vc = [[NewBZVC alloc] init];
    
    vc.operationModel = self.allmodel.operationModel;
    
    vc.deviceModel = self.allmodel.deviceModel;
    
    vc.aWID = firstModel.awId;
    
    vc.agent_oprn_id = firstModel.agent_oprn_id;
    
    vc.airCode = firstModel.airCode;
    
    vc.comeType = type;
    
    vc.Type = FIRSTTYPE;
    
    vc.CerdataModel = [[CerNeedDataModel alloc] initWithFirstModel:firstModel];
    
    switch (type) {
        case AddRemarkType:
        {
            [self.navigationController pushViewController:vc animated:type];
        }
            break;
            
        case AddCerType:
        {
            [self.navigationController pushViewController:vc animated:NO];
            
        }
            break;
    }
    
}

//备注
- (void)BZWith:(UIButton *)sender{
    
    NSInteger row = sender.tag - 100;
    
    FirstModel *mdoel = self.dataarray[row];
    
    [self comIngBZWithFirstModel:mdoel Type:AddRemarkType];
}


#pragma mark------------------------------------------------------------------------------------
//删除运单
-  (void)deleteWithRow:(NSInteger)row{
    
    
    [self alertWithTitle:@"提示" message:@"确认删除?" ok:^{
        
        FirstModel *model = self.dataarray[row];
        
        [self deleteWithModel:model];
        
    } cancel:^{
        
    }];
    
}

//删除运单
- (void)deleteWithModel:(FirstModel *)model{
    
    __weak typeof(self)weakself = self;
    
    [self.NetViewModel deleteDataWithModel:model machinID:self.allmodel.deviceModel.machinID start:^{
        
        [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在删除"];
        
    } success:^(NSString *deleteSuccessStr) {
        
        [weakself ShowSuccessWith:deleteSuccessStr];
        
        [weakself freshDataListWithType:FirstFreshDelete agent:@""];
        
    } fail:^(NSString *deleteFailStr) {
        
        [weakself ShowFailNetReasonWith:deleteFailStr];
        
        [weakself freshDataListWithType:FirstFreshDelete agent:@""];
        
    }];
    
}

#pragma mark------------------------------------------------------------------------------------
//显示最新登录时间
- (void)showLastTime{
    
    NSString *lasttime = [[NSString alloc] initWithFormat:@"最近一次登录时间:%@",self.allmodel.lasttimeModel.lastLoginTime];
    FlyLog(@"%@",lasttime);
    [MBProgressHUD showMoreLongtext:self.navigationController.view title:lasttime];
    
}

#pragma mark------------------------------------------------------------------------------------

//警告
- (void)alertWithTitle:(NSString *)title message:(NSString *)message ok:(void (^)(void))ok cancel:(void(^)(void))cancel{
    
    UIAlertController *aleart = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okk = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ok();
    }];
    
    UIAlertAction *cancell = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancel();
    }];
    
    [aleart addAction:cancell];
    
    [aleart addAction:okk];
    
    [self presentViewController:aleart animated:YES completion:nil];
    
}
#pragma mark------------------------------------------------------------------------------------
//展示错误原因
- (void)ShowFailNetReasonWith:(NSString *)str{
    [MBProgressHUD showErrorView:self.view errorTitle:str];
    
}

//展示成功
- (void)ShowSuccessWith:(NSString *)str{
    [MBProgressHUD showSuccessView:self.view SuccessTitle:str];
}
#pragma mark---------------------------------Delegate---------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Mycell *cell = [tableView dequeueReusableCellWithIdentifier:@"MycellID" forIndexPath:indexPath];
    cell.detectionType = self.detectionType;
    [cell loaddtaWithModel:self.dataarray[indexPath.row] row:indexPath.row];
     
    cell.ZDBtn.tag = indexPath.row +100;
    cell.ZSBtn.tag = indexPath.row +100;
    cell.DisPlayZBBtn.tag = indexPath.row +100;
    cell.tongguoBtn.tag = indexPath.row +100;
    cell.daiDingBtn.tag = indexPath.row +100;
    cell.TZBtn.tag = indexPath.row +100;
    [cell.ZDBtn addTarget:self action:@selector(lookZD:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ZSBtn addTarget:self action:@selector(BZWith:) forControlEvents:UIControlEventTouchUpInside];
    [cell.DisPlayZBBtn addTarget:self action:@selector(lookZS:) forControlEvents:UIControlEventTouchUpInside];
    [cell.tongguoBtn addTarget:self action:@selector(tongguoWith:) forControlEvents:UIControlEventTouchUpInside];
    [cell.daiDingBtn addTarget:self action:@selector(daidingWith:) forControlEvents:UIControlEventTouchUpInside];
    [cell.TZBtn addTarget:self action:@selector(notifiactionWith:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return self.headview;
    
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}


- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteWithRow:indexPath.row];
    }];
    
    UITableViewRowAction *add = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"添加证书" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self addZSWithrow:indexPath.row];
    }];
    
    add.backgroundColor = [UIColor colorWithRed:0.212 green:0.671 blue:0.376 alpha:1.00];
    
    return @[delete];
    
}

#pragma mark---------------------------------------UI---------------------------------------------
- (void)creatUI{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSString *title = [NSString stringWithFormat:@"%@/%@ 安检机货物首检",self.allmodel.operationModel.ctName,self.allmodel.operationModel.machineName];
    if (self.detectionType == DetectionType9610System) {
        title = [NSString stringWithFormat:@"%@/%@ 安检机货物9610检测",self.allmodel.operationModel.ctName,self.allmodel.operationModel.machineName];
    }
    self.title = title;
    [self.view addSubview:self.tableview];
    
}


- (HeadView *)headview{
    if (!_headview) {
        _headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kuan,140)];
        [_headview.YJTGBTn addTarget:self action:@selector(yjTGEventWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [_headview.allBtn addTarget:self action:@selector(selctEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.scanBtn addTarget:self action:@selector(scanEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.saveBtn addTarget:self action:@selector(saveEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.shareBtn addTarget:self action:@selector(queryCerEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.operationBtn addTarget:self action:@selector(OpeationEvent) forControlEvents:UIControlEventTouchUpInside];
        _headview.detectionType = self.detectionType;
    }
    return _headview;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:FirstFrame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.allowsSelection = NO;
        _tableview.estimatedRowHeight = 90;
        _tableview.sectionHeaderHeight = 140;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.showsVerticalScrollIndicator = NO;
        
        [_tableview registerNib:[UINib nibWithNibName:@"Mycell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MycellID"];
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableview;
}

- (NSMutableArray *)dataarray{
    if (!_dataarray) {
        _dataarray = [NSMutableArray array];
    }
    return _dataarray;
}

- (FirstNetViewModel *)NetViewModel{
    if (!_NetViewModel) {
        _NetViewModel = [[FirstNetViewModel alloc] init];
    }
    return _NetViewModel;
}

- (LookCerNetViewModel *)PDfNetViewModel{
    if (!_PDfNetViewModel) {
        _PDfNetViewModel = [[LookCerNetViewModel alloc] init];
    }
    return _PDfNetViewModel;
}

- (NSMutableArray *)AgentArray{
    if (!_AgentArray) {
        _AgentArray = [NSMutableArray array];
    }
    return _AgentArray;
}


@end
