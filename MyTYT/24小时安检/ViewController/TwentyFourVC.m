//
//  TwentyFourVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyFourVC.h"
#import "TwentyFourHourHeadView.h"
#import "LookCerNetViewModel.h"
#import "AllModel.h"
#import "OperationMachinModel.h"
#import "LastLoginTimeModel.h"
#import "MBProgressHUD+FLyHUD.h"
#import "TwentyHourNetViewViewModel.h"
#import "LoadDataFailView.h"
#import "DeviceModel.h"
#import "TwentyAllModel.h"
#import "TwentyModel.h"
#import "TestModel.h"
#import "RoadModel.h"
#import "TwentyForuHourRoadModel.h"
#import "TwentyCell.h"
#import "ScanVC.h"
#import "SelectVC.h"
#import "TwentyMachineAllModel.h"
#import "TwentyMachineModel.h"
#import "ShowMachineRoadVC.h"
#import "ExplainRoadVC.h"
#import "NewBZVC.h"
#import "TwentyLocalInfoModel.h"
#import "YDDetailVC.h"
#import "BooksModel.h"
#import "LookZSVC.h"
#import "ShowMoreImageView.h"
#import "PDFImageModel.h"
#import "SelectStateModel.h"
#import "QueryShareCerVC.h"
#import "UIColor+ColorString.h"
#import "CerNeedDataModel.h"
#import "LikeSystemAleartView.h"
#import "SelectModel.h"
#import "twentyAletartView.h"
#import "ControlAlertView.h"
#import "ControlModel.h"
#import "ClickControlModel.h"

@interface TwentyFourVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic) UITableView *tableview;

@property (nonatomic) TwentyFourHourHeadView *headview;

@property (nonatomic) NSMutableArray *dataarray;

@property (nonatomic) NSMutableArray *AgentArray;

@property (nonatomic) NSMutableArray *ALlRoadArray;

@property (nonatomic) NSMutableArray *canShowRoadArray;

@property (nonatomic) NSMutableArray *canShowMachineArray;

@property (nonatomic) LookCerNetViewModel *PDfNetViewModel;

@property (nonatomic,assign) NSInteger SelectCount;

@property (nonatomic) TwentyHourNetViewViewModel *NetViewModel;

@end

@implementation TwentyFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    [self baseSet];
    
    [self showLastTime];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestNetWork];
}

#pragma------------------------------------------------------------
- (void)baseSet{
    
    //所有的通道说明
    self.ALlRoadArray = [NSMutableArray arrayWithArray:self.allmodel.RoadModel.roadArray];
    
    //同一个货站的通道可以展示，找出货站相关的24小时通道
    for (RoadModel *temmodel in self.allmodel.RoadModel.roadArray) {
        
        if ([temmodel.ctid isEqualToString:self.allmodel.operationModel.ctId]) {//同一个货站的通道可以展示
            [self.canShowRoadArray addObject:temmodel];
        }
    }
    
    //找出同一个货站所有的安检机
    for (TwentyMachineModel *MachinModel in self.allmodel.machineAllModel.MachineArray) {
        if ([MachinModel.ctid isEqualToString:self.allmodel.operationModel.ctId] && ![MachinModel.deleted isEqualToString:@"1"]) {
            [self.canShowMachineArray addObject:MachinModel];
        }
    }
    
}
- (void)requestNetWork{
    
    self.SelectCount = 0;
    
    [self.NetViewModel loadDataWithView:self.view MachId:self.allmodel.deviceModel.machinID agentName:@"" success:^(TwentyAllModel *allModel) {
        
        if (allModel.ok == 1) {
            if (allModel.dataarray.count>0) {//有数据
                [self freshTableDataWithModel:allModel];
                
                [self ControlAlerat];
            }else{
                [self freshTableDataWithModel:allModel];
            }
            
            [self setAgentData];
            
        }else{
            [MBProgressHUD showTextView:self.view textTitle:allModel.msg];
        }
    } failStr:^(NSString *FailStr) {
        
        [self failEvent];
        
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
    
    [self.view endEditing:YES];
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (TwentyModel *model in self.dataarray) {
        
        if (([model.fstatus isEqualToString:@""] && ![model.LocalstateModel.state isEqualToString:@""]) || ![model.infoModel.aislecount isEqualToString:model.aislecount] || ![model.infoModel.machine24 isEqualToString:model.machine24] || ![model.infoModel.roadModel.ID isEqualToString: model.aisle24] || ![model.infoModel.machineModel.ID isEqualToString: model.mcid]) {//改变了数据
            
            [array addObject:model];
        }
        
    }
    
    
    if (array.count<=0) {//没有数据保存就刷新数据
        
        [self freshDataListWithType:twentyBtnFresh agent:@""];
        
    }else{
        
        [self alertWithTitle:@"提示" message:@"您有数据未保存,刷新您将丢失未保存的数据,是否继续刷新?" ok:^{
            [self freshDataListWithType:twentyBtnFresh agent:@""];
        } cancel:^{
            
        }];
    }
    
    
}

//刷新列表
- (void)freshTableDataWithModel:(TwentyAllModel *)allModel{
    
    [self setMyModel:allModel];
    
    self.dataarray = [NSMutableArray arrayWithArray:allModel.dataarray];
    
    [self.tableview reloadData];
    
}

//控提示
- (void)ControlAlerat{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.dataarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TwentyModel *mdoel = (TwentyModel *)obj;
        
        if ([mdoel.isnew isEqualToString:@"1"] && (mdoel.iscontrol == YES || mdoel.isABControl == YES)) {//新扫描的而且受布控
            ControlModel *controlModel = [[ControlModel alloc] initWithTwentyModel:mdoel];
            [array addObject:controlModel];
        }
    }];
    
    if (array.count>0) {
        [ControlAlertView showControlAleratViewWithArray:array type:OnlySureBtn toptitle:@"布控提示" bottomTitle:@"确定" sure:^{
            
        } cancel:^{
            
        }];
    }
    
}

//设置安检机 测字 24小时通道等数据
- (void)setMyModel:(TwentyAllModel *)myallmodel{
    
    
    
    for (TwentyModel *model in myallmodel.dataarray) {
        
        model.testWord = self.allmodel.textModel.regVal;//测字
        
        if ([model.aisle24 isEqualToString:@""]) {//默认创建了24小时通道模型
            
        }else{
            
            for (RoadModel *roadModel in self.canShowRoadArray) {
                
                if ([roadModel.ID isEqualToString:model.aisle24]) {
                    model.infoModel.roadModel.ID = roadModel.ID;
                    model.infoModel.roadModel.name = roadModel.name;
                }
            }
        }
        
        
        if ([model.mcid isEqualToString:@""]) {//默认创建了安检机模型
            
        }else{
            
            for (TwentyMachineModel *machModel in self.canShowMachineArray) {
                
                if ([machModel.ID isEqualToString:model.mcid]) {
                    
                    model.infoModel.machineModel.ID = machModel.ID;
                    model.infoModel.machineModel.name = machModel.name;
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
    
    
    for (TwentyModel *mdoel in self.dataarray) {
        
        NSString *DL = [mdoel.agent_short_name isEqualToString:@""] ? mdoel.agent_oprn : mdoel.agent_short_name;
        
        
        if ([array containsObject:DL]) {
            
        }else{
            
            SelectModel *selectModel = [[SelectModel alloc] initWithAgentName:mdoel.agent_oprn name:DL];
            
            [array addObject:DL];
            
            [self.AgentArray addObject:selectModel];
        }
    }
    
}

#pragma mark------------------------------------------------------------------------------------
//刷新列表
- (void)freshDataListWithType:(TwentyDataType)type
                        agent:(NSString *)agent{
    
    __weak typeof(self)weakself = self;
    
    switch (type) {
        case twentyBtnFresh:
        {
            [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在刷新列表数据"];
            
        }
            break;
            
        case TwentyFreshOnly:
        {
            [MBProgressHUD showLoadView:self.view loadTitle:@"正在刷新列表数据"];
            
        }
            break;
            
        case TwentyFreshSave:
        {
            
        }
            break;
            
        case TwentyFreshChengAgent:
        {
            [MBProgressHUD showLoadView:self.view loadTitle:@"正在切换代理"];
            
        }
            break;
        case TwentyFreshDelete:
        {
            
        }
            break;
        case TwentySaveMsgFresh:
        {
            
        }
            break;
    }
    
    [self.NetViewModel FreshDataListWitMachId:self.allmodel.deviceModel.machinID agentName:agent success:^(TwentyAllModel *allModel) {
        
        if (allModel.ok == 1) {
            
            switch (type) {
                case twentyBtnFresh:
                {
                    
                    [MBProgressHUD showSuccessView:self.navigationController.view SuccessTitle:@"刷新列表数据成功"];
                    
                }
                    break;
                case TwentyFreshOnly:
                {
                    
                    [MBProgressHUD showSuccessView:self.view SuccessTitle:@"刷新列表数据成功"];
                    
                }
                    break;
                    
                case TwentyFreshSave:
                {
                    [MBProgressHUD showSuccessView:self.view SuccessTitle:@"保存成功"];
                    
                }
                    break;
                    
                case TwentyFreshChengAgent:
                {
                    [MBProgressHUD showSuccessView:self.view SuccessTitle:@"切换成功"];
                }
                    break;
                case TwentyFreshDelete:
                {
                    
                }
                    break;
                case TwentySaveMsgFresh:
                {
                    
                }
                    break;
                    
            }
            
            if (allModel.dataarray.count>0) {//有数据
                [weakself freshTableDataWithModel:allModel];
            }else{
                [weakself freshTableDataWithModel:allModel];
            }
            
            if ([agent isEqualToString:@""]) {//全部
                [weakself setAgentData];
            }
            
        }else{
            
            [weakself ShowFailNetReasonWith:allModel.msg];
        }
        
    } failStr:^(NSString *FailStr) {
        
        [weakself ShowFailNetReasonWith:FailStr];
        
    }];
    
}
#pragma mark-----------------------------------HeadEvent-------------------------------------------------


//扫瞄
- (void)scanEvent{
    
    [self.view endEditing:YES];
    
    ScanVC *scanvc = [[ScanVC alloc] initWithScanVCType:SCANYGD];
    
    scanvc.machID = self.allmodel.deviceModel.machinID;
    
    scanvc.detectionType = DetectionTypeTwentyFour;
    
    [self.navigationController pushViewController:scanvc animated:NO];
}

//筛选
- (void)selctEvent{
    
    [self.view endEditing:YES];
    
    SelectVC *vc = [[SelectVC alloc] init];
    
    vc.AgentArray = self.AgentArray;
    
    
    vc.block = ^(SelectModel *model) {
        
        [self.headview.allBtn setTitle:model.name forState:UIControlStateNormal];
        
        [self freshDataListWithType:TwentyFreshChengAgent agent:model.agentName];
        
    };
    
    
    UINavigationController *nav = [[UINavigationController alloc ] initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationPopover;
    
    nav.popoverPresentationController.sourceView = self.headview.allBtn;
    
    nav.popoverPresentationController.sourceRect = self.headview.allBtn.bounds;
    
    nav.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    //    nav.preferredContentSize = CGSizeMake(self.view.bounds.size.width*0.35, 200);
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

//保存
- (void)saveEvent{
    
    [self.view endEditing:YES];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (TwentyModel *model in self.dataarray) {
        
        if (([model.fstatus isEqualToString:@""] && ![model.LocalstateModel.state isEqualToString:@""]) || ![model.infoModel.aislecount isEqualToString:model.aislecount] || ![model.infoModel.machine24 isEqualToString:model.machine24] || ![model.infoModel.roadModel.ID isEqualToString: model.aisle24] || ![model.infoModel.machineModel.ID isEqualToString: model.mcid]) {//改变了数据
            
            [array addObject:model];
        }
        
    }
    
    
    if (array.count<=0) {//没有数据保存就刷新数据
        
        [self freshDataListWithType:TwentyFreshOnly agent:@""];//请求刷新接口
        
    }else{
        
        for (TwentyModel *model in array) {//保存条件
            
            
            if ([model.fstatus isEqualToString:@""] && [model.LocalstateModel.state isEqualToString:@""]) {//网络无状态，而且本地没有给结论
                [MBProgressHUD showTextView:self.view textTitle:[NSString stringWithFormat:@"运单%@请选择\"通过\"或者\"待定\"",model.waybill_no]];
                
                return;
            }
            
        }
        
        __weak typeof(self)weakself = self;
        
        [self.NetViewModel updateCheckWithArray:array machineID:self.allmodel.deviceModel.machinID  start:^{
            [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在保存"];
        } success:^{
            [weakself freshDataListWithType:TwentyFreshSave agent:@""];
        } fail:^(NSString *failStr) {
            [weakself ShowFailNetReasonWith:failStr];
            
        } SpecilFailMsg:^(NSString *msg) {
            
            msg = [msg stringByReplacingOccurrencesOfString:@"<br>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 5)];
            msg = [[msg componentsSeparatedByString:@"<br>"] componentsJoinedByString:@"\n"];
            
            msg = [[msg componentsSeparatedByString:@"请使用"] componentsJoinedByString:@"\n                请使用"];
            
            [MBProgressHUD showSuccessView:weakself.view];
            
            [weakself freshDataListWithType:TwentySaveMsgFresh agent:@""];
            
            [weakself showSaveAleatWithMsg:msg];
            
        }];
        
    }
    
}
//保存提示
- (void)showSaveAleatWithMsg:(NSString *)msg{
    
    [twentyAletartView showViewWithTitle:@"提示" subtitle:msg success:^{
        
    }];
}

//查新共享证书
- (void)queryCerEvent{
    QueryShareCerVC *vc = [[QueryShareCerVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
}

//通道说明
- (void)explainEvent{
    
    [self.view endEditing:YES];
    
    ExplainRoadVC *vc = [[ExplainRoadVC alloc] init];
    
    vc.dataarray = self.ALlRoadArray;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark-----------------------------------数据按钮事件-------------------------------------------------

//查看总单号
- (void)lookZD:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    TwentyModel *mdoel = self.dataarray[row];
    
    YDDetailVC *detailVC = [[YDDetailVC alloc] init];
    
    detailVC.type = DetectionTypeTwentyFour;
    
    detailVC.testWord = mdoel.testWord;
    
    detailVC.aWID = mdoel.awId;
    
    detailVC.opeationModel = self.allmodel.operationModel;
    
    detailVC.deviceModel = self.allmodel.deviceModel;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


//查看证书
- (void)lookZS:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    TwentyModel *mdoel = self.dataarray[row];
    
    if (mdoel.booksArray.count == 1) {//就一个证书
        
        [self LookZSPicWithModel:[mdoel.booksArray firstObject]];
        
    }else if(mdoel.booksArray.count>1){//多个证书
        
        LookZSVC *vc= [[LookZSVC alloc] init];
        
        vc.dataarray = mdoel.booksArray;
        
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


//展示错误原因
- (void)ShowFailNetReasonWith:(NSString *)str{
    [MBProgressHUD showErrorView:self.view errorTitle:str];
    
}

//展示成功
- (void)ShowSuccessWith:(NSString *)str{
    [MBProgressHUD showSuccessView:self.view SuccessTitle:str];
}
#pragma mark------------------------------------------------------------------------------------
//通过
- (void)tongguoWith:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    TwentyModel *model = self.dataarray[row];
    
    [self clieckSelectWithModel:model state:@"1"];
    
}

//待定
-  (void)daidingWith:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    TwentyModel *model = self.dataarray[row];
    
    [self clieckSelectWithModel:model state:@"0"];
    
    
}

//选择逻辑
- (void)clieckSelectWithModel:(TwentyModel *)model state:(NSString *)state{
    
    NSString *NetState = model.fstatus;
    
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
            
        }else if ([localModle.state isEqualToString:@""]){//本地为空
            
            [self controlSureWithModel:model state:state];
        }
        
    }
}

#pragma mark------------------------------------------------------------------------------------
//网络取消
- (void)NetcancelEventWithModde:(TwentyModel *)model{
    
    NSString *state;
    
    if ([model.fstatus isEqualToString:@"0"]) {
        state = @"\"待定\"";
    }else if ([model.fstatus isEqualToString:@"1"]){
        state = @"\"通过\"";
    }
    
    NSString *title = [[NSString alloc] initWithFormat:@"确认取消%@状态",state];
    
    NSString *DL = [model.agent_short_name isEqualToString:@""] ? model.agent_oprn : model.agent_short_name;
    
    
    NSString *info = [NSString stringWithFormat:@"%@  %@\n%@/%@  %@ ",model.waybill_no,model.dest1,model.total_count.stringValue,model.gross_weight.stringValue,DL];
    
    [LikeSystemAleartView showViewWithTitle:title subtitle:info sureTitle:@"确定"  success:^{
        [self requestCencelEventWithMdoel:model];
    } cancel:^{
        
    }];
    
}


//布控确认提示
- (void)controlSureWithModel:(TwentyModel *)model state:(NSString *)state{
    
    [self.view endEditing:YES];
    
    if ([state isEqualToString:@"1"]) {//选择确认
        
        [self upArray:@[model] block:^{
            
            if ((model.iscontrol == YES || model.isABControl == YES)) {//而且订单是布控
                
                ControlModel *controlModle = [[ControlModel alloc] initWithTwentyModel:model];
                
                [ControlAlertView showControlAleratViewWithArray:@[controlModle] type:AllBtn toptitle:@"运单已被布控,仍确认\"通过\"" bottomTitle:@"通过" sure:^{
                    [self selectLoaclStateWithModel:model state:state];
                    
                } cancel:^{
                    
                }];
                
            }else{
                [self selectLoaclStateWithModel:model state:state];
            }
            
        }];
        
        
    }else{
        [self selectLoaclStateWithModel:model state:state];
    }
}

//本地无状态点击通过，网络更新运单布控s状态
- (void)upArray:(NSArray *)Uparray block:(void(^)(void))block{
    
    [self.NetViewModel clickAgreeWithArray:Uparray start:^{
        
        [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在加载..."];
        
    } Success:^(NSArray *array) {
        
        [MBProgressHUD showSuccessView:self.navigationController.view];
        
        TwentyModel *twentyModel = [Uparray firstObject];
        
        ClickControlModel *controlmodle = [array firstObject];
        
        twentyModel.iscontrol = controlmodle.iscontrol;
        
        twentyModel.isABControl = controlmodle.isABControl;
        
        [self.tableview reloadData];
        
        block();
        
        
    } fail:^(NSString *FailStr) {
        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:FailStr];
    }];
}

- (NSString *)controlStateStrWithModel:(TwentyModel *)model{
    
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
- (void)selectLoaclStateWithModel:(TwentyModel *)model state:(NSString *)state{
    
    SelectStateModel *localModle = model.LocalstateModel;
    self.SelectCount ++;
    localModle.operationcount = self.SelectCount;
    localModle.state = state;
    
    [self.tableview reloadData];
}

//取消选定状态
- (void)requestCencelEventWithMdoel:(TwentyModel *)mdoel{
    
    
    [self.NetViewModel CanCelStateWithaWID:mdoel.awId machineID:self.allmodel.deviceModel.machinID start:^{
        [MBProgressHUD showLoadView:self.view loadTitle:@"正在取消检测状态"];
    } success:^{
        [MBProgressHUD showSuccessView:self.view SuccessTitle:@"取消成功"];
        
        mdoel.fstatus = @"";
        //        mdoel.infoModel.roadModel = [[RoadModel alloc] init];
        //        mdoel.infoModel.machineModel = [[TwentyMachineModel alloc] init];
        //        mdoel.infoModel.aislecount = @"";
        //        mdoel.infoModel.machine24 = @"";
        //        mdoel.aisle24 = @"";
        //        mdoel.machine24 = @"";
        //        mdoel.mcid = @"";
        //        mdoel.aislecount = @"";
        
        [self.tableview reloadData];
        
    } fail:^(NSString *failStr) {
        [self ShowFailNetReasonWith:failStr];
        
    }];
    
}

#pragma mark------------------------------------------------------------------------------------
//询问是否取消检测状态<本地取消>
- (void)LocalqueryIsCancelStateWithLocalModel:(SelectStateModel *)localModel model:(TwentyModel *)model{
    
    
    NSString *state;
    
    if ([localModel.state isEqualToString:@"0"]) {
        state = @"\"待定\"";
    }else if ([localModel.state isEqualToString:@"1"]){
        state = @"\"通过\"";
    }
    
    NSString *title = [[NSString alloc] initWithFormat:@"确认取消%@状态",state];
    
    NSString *DL = [model.agent_short_name isEqualToString:@""] ? model.agent_oprn : model.agent_short_name;
    
    
    NSString *info = [NSString stringWithFormat:@"%@  %@\n%@/%@  %@ ",model.waybill_no,model.dest1,model.total_count.stringValue,model.gross_weight.stringValue,DL];
    
    [LikeSystemAleartView showViewWithTitle:title subtitle:info sureTitle:@"确定"  success:^{
        localModel.state = @"";
        localModel.isAllAgree = NO;
        localModel.operationcount = 0;
        
        [self.tableview reloadData];
        
    } cancel:^{
        
    }];
    
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

//展示24小时通道
- (void)showRoadListWithBtn:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    TwentyModel *model = self.dataarray[row];
    
    if (![model.infoModel.aislecount isEqualToString:@""] && [model.infoModel.aislecount integerValue]<=0) {
        
        return;
    }
    
    
    TwentyCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    ShowMachineRoadVC *vc = [[ShowMachineRoadVC alloc] init];
    
    vc.type = SHOWRoad;
    
    vc.dataArray = self.canShowRoadArray;
    
    vc.roadModel = model.infoModel.roadModel;
    
    vc.block = ^(NSArray *array) {
        
        model.infoModel.roadModel = [array firstObject];
        [self.tableview reloadData];
        
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationPopover;
    
    nav.popoverPresentationController.sourceView = cell.RoadBtn;
    
    nav.popoverPresentationController.sourceRect = CGRectMake(0, 0, 0, cell.RoadBtn.frame.size.height);
    
    nav.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    nav.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    
    nav.preferredContentSize = CGSizeMake(300, self.canShowRoadArray.count *50);
    
    [self presentViewController:nav animated:YES completion:nil];
}

//展示安检机
- (void)showMachIneListWithBtn:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    TwentyModel *model = self.dataarray[row];
    
    if ([model.infoModel.machine24 integerValue]<=0) {
        return;
    }
    
    TwentyCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    ShowMachineRoadVC *vc = [[ShowMachineRoadVC alloc] init];
    
    vc.type = SHOWMAChine;
    
    vc.dataArray = self.canShowMachineArray;
    
    vc.machIneModel = model.infoModel.machineModel;
    
    vc.block = ^(NSArray *array) {
        
        model.infoModel.machineModel = [array firstObject];
        [self.tableview reloadData];
        
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationPopover;
    
    nav.popoverPresentationController.sourceView = cell.AJJBtn;
    
    nav.popoverPresentationController.sourceRect = CGRectMake(0, 0, 0, cell.AJJBtn.frame.size.height);
    
    nav.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    nav.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    
    nav.preferredContentSize = CGSizeMake(300, self.canShowMachineArray.count *50);
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark-------------------------进入备注页面------------------------------------
//添加证书
- (void)addZSWithrow:(NSInteger)row{
    
    [self.view endEditing:YES];
    
    TwentyModel *model = self.dataarray[row];
    
    [self comIngBZWithFirstModel:model Type:AddCerType];
}

//备注
- (void)BZWith:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    TwentyModel *mdoel = self.dataarray[row];
    
    [self comIngBZWithFirstModel:mdoel Type:AddRemarkType];
}

//进入备注类型
- (void)comIngBZWithFirstModel:(TwentyModel *)twentyModel Type:(ComeIngType)type{
    
    NewBZVC *vc = [[NewBZVC alloc] init];
    
    vc.operationModel = self.allmodel.operationModel;
    
    vc.deviceModel = self.allmodel.deviceModel;
    
    vc.aWID = twentyModel.awId;
    
    vc.agent_oprn_id = twentyModel.agent_oprn_id;
    
    vc.airCode = twentyModel.airCode;
    
    vc.comeType = type;
    
    vc.Type = DetectionTypeTwentyFour;
    
    vc.CerdataModel = [[CerNeedDataModel alloc] initWithTwentyModel:twentyModel];
    
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

#pragma mark------------------------------------------------------------------------------------
//删除运单
-  (void)deleteWithRow:(NSInteger)row{
    
    [self.view endEditing:YES];
    
    [self alertWithTitle:@"提示" message:@"确认删除?" ok:^{
        
        TwentyModel *model = self.dataarray[row];
        
        [self deleteWithModel:model];
        
    } cancel:^{
        
    }];
    
}

//删除运单
- (void)deleteWithModel:(TwentyModel *)model{
    
    __weak typeof(self)weakself = self;
    
    [self.NetViewModel deleteDataWithaWID:model.awId machinID:self.allmodel.deviceModel.machinID start:^{
        [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在删除"];
        
    } Success:^(NSString *deleteSuccessStr) {
        
        [weakself ShowSuccessWith:deleteSuccessStr];
        
        [weakself freshDataListWithType:TwentyFreshDelete agent:@""];
        
        
    } fail:^(NSString *deletefailStr) {
        [weakself ShowFailNetReasonWith:deletefailStr];
        
        [weakself freshDataListWithType:TwentyFreshDelete agent:@""];
    }];
    
}

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

#pragma mark--------------------------------TextFiledDelegae--------------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger row = textField.tag - 100;
    
    TwentyCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    TwentyModel *model = self.dataarray[row];
    
    NSCharacterSet *charet = [NSCharacterSet decimalDigitCharacterSet];
    
    if ([[string stringByTrimmingCharactersInSet:charet] isEqualToString:@""]) {//输入的为数字
        
        FlyLog(@"string---------%@",string);
        FlyLog(@"text----%@",textField.text);
        FlyLog(@"rang-----%@",NSStringFromRange(range));
        
        NSString *str;
        if (range.length>0) {//在删除
            str = [textField.text stringByReplacingCharactersInRange:range withString:@""];
            
        }else{//在添加
            str  = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        
        
        if ([str isEqualToString:@""]) {//数据都为空
            
            textField.text = @"";
            model.infoModel.aislecount = @"";
            model.infoModel.machine24 = @"";
            
            cell.AJJTextFiled.text = @"";
            cell.RoadTextfiled.text = @"";
            
            model.infoModel.machineModel = [[TwentyMachineModel alloc] init];
            [cell.AJJBtn setTitle:@"" forState:UIControlStateNormal];
            [cell.AJJBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
            
            model.infoModel.roadModel = [[RoadModel alloc] init];
            [cell.RoadBtn setTitle:@"" forState:UIControlStateNormal];
            [cell.RoadBtn setBackgroundColor:[UIColor colorWithHexString:@"#00B32C"]];
            
            return NO;
            
        }else if ([str integerValue] >[model.total_count integerValue]){//大于数据
            str = [[NSString alloc] initWithFormat:@"%@",model.total_count.stringValue];
        }
        
        
        
        FlyLog(@"str----%@",str);
        
        if ([textField isEqual:cell.RoadTextfiled]) {//通道货物数量
            
            model.infoModel.aislecount = str;
            model.infoModel.machine24 = [NSString stringWithFormat:@"%ld",[model.total_count integerValue] - [str integerValue]];
            
        }else if([textField isEqual:cell.AJJTextFiled]){//待过安检机
            
            model.infoModel.machine24 = str;
            model.infoModel.aislecount = [NSString stringWithFormat:@"%ld",[model.total_count integerValue] - [str integerValue]];
            
        }
        
        //安检机 24通道
        cell.AJJTextFiled.text = model.infoModel.machine24;
        cell.RoadTextfiled.text = model.infoModel.aislecount;
        
        
        if ([model.infoModel.machine24 isEqualToString:@"0"]) {
            model.infoModel.machineModel = [[TwentyMachineModel alloc] init];
            [cell.AJJBtn setTitle:@"" forState:UIControlStateNormal];
        }
        
        if ([model.infoModel.machine24 integerValue]<=0) {
            [cell.AJJBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
        }else{
            [cell.AJJBtn setBackgroundColor:[UIColor colorWithHexString:@"#00B32C"]];
            
        }
        
        
        
        if ([model.infoModel.aislecount isEqualToString:@"0"]) {
            model.infoModel.roadModel = [[RoadModel alloc] init];
            [cell.RoadBtn setTitle:@"" forState:UIControlStateNormal];
        }
        
        if ([model.infoModel.aislecount integerValue] <=0) {
            [cell.RoadBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
            
        }else{
            [cell.RoadBtn setBackgroundColor:[UIColor colorWithHexString:@"#00B32C"]];
        }
        
        
        return NO;
        
    };
    
    return NO;
    
}

#pragma mark---------------------------------Delegate---------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TwentyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwentyCellID" forIndexPath:indexPath];
    [cell loaddataWithModel:self.dataarray[indexPath.row] row:indexPath.row];
    
    cell.RoadBtn.tag = indexPath.row + 100;
    cell.AJJBtn.tag = indexPath.row + 100;
    cell.BZBtn.tag = indexPath.row + 100;
    cell.ZSBtn.tag = indexPath.row + 100;
    cell.YDHBTn.tag = indexPath.row + 100;
    cell.AgreeBtn.tag = indexPath.row + 100;
    cell.WaitBtn.tag = indexPath.row + 100;
    cell.AJJTextFiled.tag = indexPath.row + 100;
    cell.RoadTextfiled.tag = indexPath.row + 100;
    
    cell.AJJTextFiled.delegate = self;
    cell.RoadTextfiled.delegate = self;
    [cell.RoadBtn addTarget:self action:@selector(showRoadListWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.AJJBtn addTarget:self action:@selector(showMachIneListWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.BZBtn addTarget:self action:@selector(BZWith:) forControlEvents:UIControlEventTouchUpInside];
    [cell.YDHBTn addTarget:self action:@selector(lookZD:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ZSBtn addTarget:self action:@selector(lookZS:) forControlEvents:UIControlEventTouchUpInside];
    [cell.AgreeBtn addTarget:self action:@selector(tongguoWith:) forControlEvents:UIControlEventTouchUpInside];
    [cell.WaitBtn addTarget:self action:@selector(daidingWith:) forControlEvents:UIControlEventTouchUpInside];
    
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


#pragma mark---------------------------------------UI---------------------------------------
- (void)creatUI{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = [NSString stringWithFormat:@"%@/24小时首检",self.allmodel.operationModel.ctName];
    [self.view addSubview:self.tableview];
    
}

//显示最新登录时间
- (void)showLastTime{
    
    NSString *lasttime = [[NSString alloc] initWithFormat:@"最近一次登录时间:%@",self.allmodel.lasttimeModel.lastLoginTime];
    FlyLog(@"%@",lasttime);
    [MBProgressHUD showMoreLongtext:self.navigationController.view title:lasttime];
    
}

- (TwentyFourHourHeadView *)headview{
    if (!_headview) {
        _headview = [[TwentyFourHourHeadView alloc] initWithFrame:CGRectMake(0, 0, kuan,160)];
        [_headview.RoadExplainBtn addTarget:self action:@selector(explainEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.allBtn addTarget:self action:@selector(selctEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.scanBtn addTarget:self action:@selector(scanEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.saveBtn addTarget:self action:@selector(saveEvent) forControlEvents:UIControlEventTouchUpInside];
        [_headview.shareBtn addTarget:self action:@selector(queryCerEvent) forControlEvents:UIControlEventTouchUpInside];
        
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
        _tableview.sectionHeaderHeight = 160;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableview.showsVerticalScrollIndicator = NO;
        
        [_tableview registerNib:[UINib nibWithNibName:@"TwentyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TwentyCellID"];
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
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


- (TwentyHourNetViewViewModel *)NetViewModel{
    if (!_NetViewModel) {
        _NetViewModel = [[TwentyHourNetViewViewModel alloc] init];
    }
    return _NetViewModel;
}

- (NSMutableArray *)ALlRoadArray{
    if (!_ALlRoadArray) {
        _ALlRoadArray = [NSMutableArray array];
    }
    return _ALlRoadArray;
}

- (NSMutableArray *)canShowRoadArray{
    if (!_canShowRoadArray) {
        _canShowRoadArray = [NSMutableArray array];
    }
    return _canShowRoadArray;
}

- (NSMutableArray *)canShowMachineArray{
    if (!_canShowMachineArray) {
        _canShowMachineArray = [NSMutableArray array];
    }
    return _canShowMachineArray;
}


@end
