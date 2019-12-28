//
//  AddBZVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZVC.h"
#import "SectionCell2.h"
#import "AddBZCell.h"
#import "BZSectionHeadView.h"
#import "BZModle.h"
#import "SelectPhotoVC.h"
#import "FlyTakePhotoData.h"
#import "BZAddModel.h"
#import "ShowPIcView.h"
#import "AddMyBzViewModel.h"
#import "MBProgressHUD+FLyHUD.h"
#import "LoadDataFailView.h"
#import "FlyHttpTools.h"
#import "AddBZALlModel.h"
#import "OperationMachinModel.h"
#import "AddBZDataManager.h"
#import "AddBZSectionModel.h"
#import "AddBZRowModel.h"
#import "AddBZImageCell.h"
#import "AddBZImageModel.h"
#import "MyimageModel.h"
#import "FlypreViewController.h"
#import "FlyPhotoKitManager.h"
#import "FlyPhotoNav.h"
#import "NSString+Helper.h"
#import "CheckBottomView.h"

@interface AddBZVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,SelectPicDelegate>

@property (nonatomic) UITableView *tableview;

@property (nonatomic) AddMyBzViewModel *netViewModel;

@property (nonatomic) FlyTakePhotoData *photodata;

@property (nonatomic) AddBZDataManager *dataManager;

@property (nonatomic,strong) CheckBottomView *view_bottom;

@property (nonatomic,assign) DetectionType detectionType;
@end

@implementation AddBZVC
-(instancetype)initWithOpeartionModel:(OperationMachinModel *)opeartionModel
                                 aWID:(NSString *)aWID
                               MachID:(NSString *)MachID
                                  YDH:(NSString *)YDH
                        DetectionType:(DetectionType)detectionType;
{
    if (self = [super init]) {
        self.opeartionModel = opeartionModel;
        self.aWID = aWID;
        self.MachID = MachID;
        self.YDH = YDH;
        self.detectionType = detectionType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
  
    [self requestData];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{

    FlyLog(@"添加备注页面delloc");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableview.frame = CGRectMake(20, 20, self.view.bounds.size.width-40, self.view.bounds.size.height-40);
    if (self.detectionType == DetectionType9610System) {
        WEAK_SELF
        self.tableview.tableFooterView = self.view_bottom;
        self.view_bottom.bottomClickBlock = ^(NSInteger clickType) {
            if (clickType == 1) {
                [weakSelf buHeGeClick];
            }else if (clickType == 2){
                [weakSelf zanKouClick];
            }else if (clickType == 3){
                [weakSelf tongGuoClick];
            }
        };
    }
}

-(void)buHeGeClick{
    
}

-(void)zanKouClick{
    
}

-(void)tongGuoClick{
    
}


//返回 进入没有加载成功，之间取消返回，则取消网络
- (void)back{
    
    [FlyHttpTools canceltask];
    
    [self.view endEditing:YES];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    self.block();
}


- (void)requestData{
    
    __weak typeof(self)weakself = self;
    
    [self.netViewModel loadBZDataWithaWID:self.aWID view:self.view success:^(AddBZALlModel *allmodel) {
        
        if (allmodel.ok == 1) {
            
            if (allmodel.dataarray.count>0) {
                weakself.dataManager = [[AddBZDataManager alloc] initWithArray:allmodel.dataarray];
                
                [weakself.tableview reloadData];
                [weakself.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
            }else{
                weakself.dataManager = [[AddBZDataManager alloc] initWithArray:allmodel.dataarray];
                [weakself.tableview reloadData];

            }
            [weakself beiZhuContentChangedWithNum:allmodel.dataarray.count];
        }else{
            [MBProgressHUD showTextView:weakself.view textTitle:allmodel.msg];

        }
        
    } fail:^(NSString *fail) {
        [MBProgressHUD showTextView:weakself.view textTitle:fail];
        [weakself failEvent];

    }];
    
}

-(void)beiZhuContentChangedWithNum:(NSInteger)num{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beiZhuContentChange" object:@(num)];
}

- (void)failEvent{
    __weak typeof(self)weakself = self;

    [LoadDataFailView ShowLoadFailViewWith:self.view frame:self.view.bounds clickBtn:^{
        [weakself requestData];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (@available(iOS 11.0, *)) {
//        self.navigationController.navigationBar.prefersLargeTitles = YES;
//        self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
//    } else {
//        // Fallback on earlier versions
//    }

    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
//    if (@available(iOS 11.0, *)) {
//        self.navigationController.navigationBar.prefersLargeTitles = NO;
//    } else {
//        // Fallback on earlier versions
//    }

    
}

#pragma mark------------------------------------------------------------------------------------
//编辑
- (void)editEvent:(UIButton *)sender{
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;
    
    AddBZSectionModel *sectionModel = self.dataManager.SectionArray[0];
    
    AddBZRowModel *rowmodel = sectionModel.rowarray[row];

    BZModle *model = rowmodel.bzmodel;

    model.IsCanEditContent = YES;
    
    //获取焦点
    [self.tableview beginUpdates];
    AddBZCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    cell.textview.editable = YES;
    [cell.textview becomeFirstResponder];
    
    [self.tableview endUpdates];

    
}

//编辑事件
- (void)UpeditEventWithText:(NSString *)text model:(BZModle *)model{
    
    //编辑成功后上传数据，停止编辑红能
    
    if ([text isEqualToString:model.remark]) {//备注信息不变，不请求网络
        model.IsCanEditContent = NO;
        [self.tableview reloadData];
        return;
    }
    
    __weak typeof(self)weakself = self;

    [self.netViewModel editBZWithModel:model text:text start:^{
        [MBProgressHUD showLoadView:weakself.navigationController.view loadTitle:@"正在编辑"];

    } success:^(NSString *Str) {

        [MBProgressHUD showSuccessView:weakself.navigationController.view SuccessTitle:Str];
        
        model.IsCanEditContent = NO;
        model.remark = text;
        [weakself.tableview reloadData];


    } fail:^(NSString *fail) {
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:fail];
        
        model.IsCanEditContent = NO;
        [weakself.tableview reloadData];
    }];
}


//删除
- (void)deleteEvent:(UIButton *)sender{
    [self.view endEditing:YES];
    
    NSInteger row = sender.tag - 100;

    AddBZSectionModel *sectionModel = self.dataManager.SectionArray[0];
    
    AddBZRowModel *rowmodel = sectionModel.rowarray[row];
    
    BZModle *model = rowmodel.bzmodel;
    
    [self alertWithTitle:@"提示" message:@"确认删除此条备注信息?" ok:^{
        [self deleteEventWithModel:model row:row];
    } cancel:^{

    }];
  
}

//删除
- (void)deleteEventWithModel:(BZModle *)model row:(NSInteger)row{
    
    __weak typeof(self)weakself = self;
    
    
    [self.netViewModel deleteBZWithModel:model start:^{
        [MBProgressHUD showLoadView:weakself.navigationController.view loadTitle:@"正在删除"];
    } success:^(NSString *Str) {
        [MBProgressHUD showSuccessView:weakself.navigationController.view SuccessTitle:Str];

      AddBZSectionModel *sectionModel = weakself.dataManager.SectionArray[0];
        
        [sectionModel.rowarray removeObjectAtIndex:row];
        [weakself.tableview reloadData];
        [weakself.tableview scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionNone animated:NO];
        [weakself beiZhuContentChangedWithNum:sectionModel.rowarray.count];

    } fail:^(NSString *fail) {
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:fail];
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

#pragma mark------------------------------------------------------------------------------------

//照片选择
- (void)photoSelect:(UIButton *)sender{
    
    [self.view endEditing:YES];

    if (self.dataManager.imageModel.dataarray.count>=9) {
        [self alertWithTitle:@"提示" message:@"您最多只能添加9张照片" ok:^{
            
        } cancel:^{
            
        }];
        return;
    }
    
    __weak typeof(self)weakself = self;

    FlyPhotoType type = FlyTakePhoto;
    
    [self.photodata GetPhotoDataWithType:type VC:self picData:^(NSData *data) {
        
        [weakself upPicWithPicData:data];
        
    }];
    
    
//    
//    
//    SelectPhotoVC *vc = [[SelectPhotoVC alloc] init];
//    
//    
//    vc.block = ^(NSInteger row) {
//        
//        __weak typeof(self)weakself = self;
//
//        if (row == 0) {
//        
//        FlyPhotoType type;
//        if (row == 0) {
//            type = FlyTakePhoto;
//        }else{
//            type = FlyGetPhoto;
//
//        }
//        
//        [self.photodata GetPhotoDataWithType:type VC:self picData:^(NSData *data) {
//
//            [weakself upPicWithPicData:data];
//            
//        }];
//            
//        }else if (row == 1){
//
//            FlyPhotoKitManager *manager = [[FlyPhotoKitManager alloc] init];
//
//            manager.MaxSelectCount = 9 - weakself.dataManager.imageModel.dataarray.count;
//
//            [manager showInViewController:self result:^(NSArray<NSData *> *Picarray) {
//
//                [self.netViewModel upMorePicDataWithArray:Picarray start:^{
//                    
//                    [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在上传图片"];
//                } success:^(NSArray<MyimageModel *> *array) {
//                    [MBProgressHUD showSuccessView:self.navigationController.view SuccessTitle:@"上传成功"];
//                    [self.dataManager.imageModel.dataarray addObjectsFromArray:array];
//                    
//                    [self addImageSuccessEvent];
//                    
//                } fail:^(NSString *fail) {
//                    [MBProgressHUD showErrorView:self.navigationController.view errorTitle:fail];
//                }];
//                
//            }];
//
//        }
//
//    };
//    
//    vc.modalPresentationStyle = UIModalPresentationPopover;
//    
//    vc.popoverPresentationController.sourceView = sender;
//    
//    vc.popoverPresentationController.sourceRect = sender.bounds;
//    
//    vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
//    
//    vc.popoverPresentationController.backgroundColor = [UIColor whiteColor];
//    
//    [self presentViewController:vc animated:YES completion:nil];
}

//添加图片成功
- (void)addImageSuccessEvent{
    
    if (self.dataManager.imageModel.dataarray.count >0) {//拍好图片了,没有图片组添加图片组
        
        int j=-1;
        
        for (AddBZSectionModel *sectionModel in self.dataManager.SectionArray) {
            if (sectionModel.sectionType ==ImageType) {
                j=0;
            }
        }
        
        if (j==-1) {
            AddBZSectionModel *sectionModelTwo = [[AddBZSectionModel alloc] initWithSectionType:ImageType rowArray:@[@[self.dataManager.imageModel]]];
            
            [self.dataManager.SectionArray addObject:sectionModelTwo];
        }
        
    }
    
    if ([self.dataManager.addmodel.content isEqualToString:@"请输入内容"]) {//拍照成功后发现没输入内容填充操作人信息
        self.dataManager.addmodel.content = [NSString stringWithFormat:@"%@/%@",self.opeartionModel.ctName,self.opeartionModel.machineName];
    }
    
    [self.tableview reloadData];
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(self.dataManager.SectionArray.count - 1)] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

//上传图片
- (void)upPicWithPicData:(NSData *)picdata{
    
    __weak typeof(self)weakself = self;


    [self.netViewModel upPicDataWith:picdata start:^{
        
        [MBProgressHUD showLoadView:weakself.navigationController.view loadTitle:@"正在上传图片"];
        
    } success:^(NSString *FilID,NSString *picPath) {
        
        [MBProgressHUD showSuccessView:weakself.navigationController.view SuccessTitle:@"图片上传成功"];
        
        MyimageModel *imageModel = [[MyimageModel alloc] initWithFildID:FilID filePath:picPath data:picdata];
        
        [weakself.dataManager.imageModel.dataarray addObject:imageModel];
        
        [weakself addImageSuccessEvent];
     
    } fail:^(NSString *fail) {
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:fail];
    }];
}

- (CGRect)windowBefromFrameWithBtn:(UIButton *)btn{
    
    CGRect frame = btn.frame;
    
    CGRect beforframe = [btn.superview convertRect:frame toView:self.view.window];
    
    return beforframe;
}

- (CGRect)windowAfterFrameWithBtn:(UIButton *)Btn{
    
    
   CGSize size = Btn.imageView.image.size;
    
    CGSize newSize;
    newSize.height = gao;
    newSize.width = newSize.height / size.height * size.width;
    
    CGFloat imageX = (kuan - newSize.width) * 0.5;
    
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect =  CGRectMake(imageX, 0, newSize.width, newSize.height);
    
    return rect;

    
}

//添加
- (void)addEvent{
    [self.view endEditing:YES];
    

    if ([self.dataManager.addmodel.content isEqualToString:@"请输入内容"]) {//没有改变内容
        [MBProgressHUD showTextView:self.navigationController.view textTitle:@"请填写备注内容"];
        return;
    }
    
    __weak typeof(self)weakself = self;
    
    [self.netViewModel AddBZWithaWID:self.aWID machID:self.MachID dataManger:self.dataManager start:^{
                [MBProgressHUD showLoadView:weakself.navigationController.view loadTitle:@"正在添加备注"];

    } success:^(NSString *Str) {
        [MBProgressHUD showSuccessView:weakself.navigationController.view SuccessTitle:Str];
        
                weakself.dataManager.addmodel = [[BZAddModel alloc] init];//初始化数据
                [weakself requestData];
        
    } fail:^(NSString *fail) {
                [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:fail];

    }];

    
}

#pragma mark------------------------------------------------------------------------------------

- (void)creatUI{
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    self.navigationController.navigationBar.translucent = NO;
    self.title = [NSString stringWithFormat:@"运单号:%@",self.YDH];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = right;
    [self.view addSubview:self.tableview];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataManager.SectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   AddBZSectionModel *sectionModel = self.dataManager.SectionArray[section];
    return sectionModel.rowarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddBZSectionModel *sectiondmeol = self.dataManager.SectionArray[indexPath.section];
    
    AddBZRowModel *rowmodel = sectiondmeol.rowarray[indexPath.row];
    
    switch (rowmodel.type) {
        case CellcontentTYpe:
        {
            AddBZCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddBZCellID" forIndexPath:indexPath];
            
            cell.textview.delegate = self;
            
            [cell loaddataWithModel:rowmodel.bzmodel];
            
            cell.textview.tag = indexPath.row + 100;
            cell.deletBtn.tag = indexPath.row+100;
            cell.editBtn.tag = indexPath.row+ 100;
            
            [cell.deletBtn addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
            [cell.editBtn addTarget:self action:@selector(editEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
            break;
            
        case CelladdType:
        {
            SectionCell2*cell = [tableView dequeueReusableCellWithIdentifier:@"SectionCell2ID" forIndexPath:indexPath];
            [cell loaddataWithModel:rowmodel.addmodel];
            cell.textVIew.delegate = self;
            
            [cell.addBtn addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
            [cell.takephotoBtn addTarget:self action:@selector(photoSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
            break;
            
            
        case CellimageType:
        {
            AddBZImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddBZImageCellID" forIndexPath:indexPath];
            [cell loaddataWithModel:rowmodel.imageModel];
            cell.delegate = self;
            return cell;
        }
            break;
    }
    return nil;
  
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AddBZSectionModel *sectionModel = self.dataManager.SectionArray[section];
    return sectionModel.headheight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AddBZSectionModel *sectionModel = self.dataManager.SectionArray[section];
    return sectionModel.footerHeight;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AddBZSectionModel *sectionModel = self.dataManager.SectionArray[section];
    return sectionModel.headview;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AddBZSectionModel *sectionModel = self.dataManager.SectionArray[section];
    return sectionModel.footview;
    
}

#pragma mark------------------------------------------------------------------------------------
- (UITableView *)tableview{
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 200;
        _tableview.allowsSelection = NO;
        _tableview.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];

        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
            // Fallback on earlier versions
        }
        [_tableview registerNib:[UINib nibWithNibName:@"AddBZCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddBZCellID"];
        [_tableview registerNib:[UINib nibWithNibName:@"SectionCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SectionCell2ID"];
        [_tableview registerNib:[UINib nibWithNibName:@"AddBZImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddBZImageCellID"];
        _tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        

    }
    return _tableview;
}

- (FlyTakePhotoData *)photodata{
    if (!_photodata) {
        _photodata = [[FlyTakePhotoData alloc] init];
    }
    return _photodata;
}


- (AddMyBzViewModel *)netViewModel{
    if (!_netViewModel) {
        _netViewModel = [[AddMyBzViewModel alloc] init];
    }
    return _netViewModel;
}

#pragma mark----------------------TextViewDelegate-------------------------------
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    SectionCell2 *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    if ([textView isEqual:cell.textVIew]) {
        
        if ([textView.text isEqualToString:@"请输入内容"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
        
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    SectionCell2 *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

    if ([textView isEqual:cell.textVIew]) {//cell2

        if (textView.text.length<1) {
            textView.textColor = [UIColor grayColor];
            textView.text = @"请输入内容";
        }else{
            textView.textColor = [UIColor blackColor];
        }
        self.dataManager.addmodel.content = textView.text;

    }else{//cell1

       AddBZSectionModel *sectionModel = self.dataManager.SectionArray[0];

        NSInteger row = textView.tag - 100;
      AddBZRowModel *rowmodel = sectionModel.rowarray[row];

        [self UpeditEventWithText:textView.text model:rowmodel.bzmodel];

    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    NSInteger row = textView.tag - 100;
    
    AddBZCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    if ([textView isEqual:cell.textview]) {//内容
        CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), CGFLOAT_MAX)];
        
        CGRect frame = textView.frame;
        
        frame.size.height = size.height;
        
        textView.frame = frame;
        
        [self.tableview beginUpdates];
        [self.tableview endUpdates];
        
    }
 
}

//选择
- (void)selectIndex:(NSInteger)row{
    
    FlypreViewController *vc = [[FlypreViewController alloc] init];
    
    vc.photoarray = [NSMutableArray arrayWithArray:self.dataManager.imageModel.dataarray];
    
    vc.selectindex = row;
    
    vc.block = ^(NSArray *ImageArray) {
        
        self.dataManager.imageModel.dataarray = [NSMutableArray arrayWithArray:ImageArray];
        
        if (self.dataManager.imageModel.dataarray.count == 0) {
            [self.dataManager.SectionArray removeLastObject];
            self.dataManager.addmodel.content = @"请输入内容";
        }
        
        [self.tableview reloadData];
       
        
        };
    
    FlyPhotoNav *nav = [[FlyPhotoNav alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];

}




@end
