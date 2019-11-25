//
//  AddCerVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddCerVC.h"
#import "CerView.h"
#import "Masonry.h"
#import "CerCollectionCell.h"
#import "ShowPIcView.h"
#import "RequestAuthor.h"
#import "PreSentScanVC.h"
#import "SelectCerVC.h"
#import "SelctCerAllModel.h"
#import "AddCerNetViewModel.h"
#import "MBProgressHUD+FLyHUD.h"
#import "ShowMoreImageView.h"
#import "SelectCerModel.h"
#import "AddBZVC.h"
#import "ShowCerDataModel.h"
#import "CerNeedDataModel.h"

@interface AddCerVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) CerView *cerview;

@property (nonatomic) UIView *leftview;

@property (nonatomic) UICollectionView *collectionview;

@property (nonatomic) SelectCerModel *model;

@property (nonatomic) AddCerNetViewModel *netViewModel;

@end

@implementation AddCerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    [self scanEvent];
    
}

- (void)creatUI{
    
    self.title = @"添加证书";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [self.view addSubview:self.leftview];
    [self.view addSubview:self.cerview];
    [self.view addSubview:self.collectionview];

    
    [self layout];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

}

#warning ---
//
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.isReturnToRootVC == YES) {//直接返回
       

    }else{
        
        if (self.type == FromFirst) {//
            self.block();
        }
        
        [MBProgressHUD showSuccessView:self.navigationController.view];
        
    }
   

}



#pragma mark------------------------------------------------------------------------------------
//扫描证书
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
    
    scanvc.type = SCANYCER;
    
    scanvc.block = ^(NSString *scanStr) {
        
        [self requestWithScanStr:scanStr];
        FlyLog(@"%@",scanStr);
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scanvc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:nav animated:YES completion:nil];
    
   
}

//请求
- (void)requestWithScanStr:(NSString *)scanStr{
    
    
    __weak typeof(self)weakself = self;
    
    [self.netViewModel loadDataWithBookNo:scanStr aWID:self.aWID agentOprnId:self.agentOprnId airCode:self.airCode  start:^{
        [MBProgressHUD showLoadView:weakself.navigationController.view loadTitle:@"正在查询证书信息"];
    } success:^(SelctCerAllModel *allmodel) {
        
        if (allmodel.ok == 1) {
            
            if (allmodel.array.count == 0) {//没有数据
                
                [weakself setBaseData];
                
                [self.cerview freshDataWithcerStr:scanStr State:@"不存在的证书" model:self.CerdataModel];
                
                [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:@"不存在的证书"];
                
            }else if (allmodel.array.count>1){//有多个
                
                [MBProgressHUD showSuccessView:weakself.navigationController.view];
                
                SelectCerVC *vc = [[SelectCerVC alloc] init];
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                vc.dataarray = allmodel.array;
                
                vc.block = ^(SelectCerModel *mdoel) {
                    weakself.model = mdoel;
                    [weakself LogincalWithCerModel:weakself.model];
                };
                
                nav.modalPresentationStyle = UIModalPresentationFormSheet;
                
                if (allmodel.array.count > 4) {
                   nav.preferredContentSize = CGSizeMake(kuan*0.5, 4*110);
                }else{
                   nav.preferredContentSize = CGSizeMake(kuan*0.5, allmodel.array.count*110);
                }
                
                [weakself presentViewController:nav animated:YES completion:nil];
                
            }else if(allmodel.array.count == 1){//有一个
                
            self.model = [allmodel.array firstObject];
                
                [weakself LogincalWithCerModel:weakself.model];
                
            }
            
        }else{
            
            [weakself setBaseData];
            
            [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:allmodel.msg];
            
            [self.cerview freshDataWithcerStr:scanStr State:allmodel.msg model:self.CerdataModel];

        }
        
        
    } fail:^(NSString *FailStr) {
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:FailStr];
        [self.cerview freshDataWithcerStr:scanStr State:FailStr model:self.CerdataModel];
    }];
}

//取得证书后的逻辑
- (void)LogincalWithCerModel:(SelectCerModel *)model{
    
    NSString *CerState;
    
    if ([model.returnStatus isEqualToString:@"100"]) {
        
        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:@"证书已停用，请重新选择证书"];
        CerState = @"证书已停用，请重新选择证书";

    }else if ([model.returnStatus isEqualToString:@"102"]){

        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:@"证书已过期，请重新选择证书"];
        CerState = @"证书已过期，请重新选择证书";
        
    }else if ([model.returnStatus isEqualToString:@"105"]){

        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:model.returnReason];
        
        CerState = model.returnReason;

    }else{

        CerState = @"";
        [MBProgressHUD showSuccessView:self.navigationController.view];
    }
    
    [self.cerview freshDataWithcerStr:model.bookNo State:CerState model:self.CerdataModel];
    
    [self.collectionview reloadData];

    [self.collectionview selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];

    [self collectionView:self.collectionview didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];


}

- (void)setBaseData{
    
    self.model = [[SelectCerModel alloc] init];
    [self.collectionview reloadData];
}

//保存添加备注
- (void)saveAddBZEvent{
    
    self.isReturnToRootVC = NO;
    [self savEvent];
}

- (void)saveReturnEvent{
    
    self.isReturnToRootVC = YES;
    [self savEvent];
}

//保存返回首页
- (void)savEvent{
    
    if ([self.model.bookId isEqualToString:@""] && self.model.ID ==nil) {//没有查询证书
        
        if (self.isReturnToRootVC == YES) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
        
    }
    
    __weak typeof(self)weakself = self;
    
    [self.netViewModel saveDataWithaWID:self.aWID SelectCerModel:self.model start:^{
        [MBProgressHUD showLoadView:weakself.navigationController.view loadTitle:@"正在保存"];
    } success:^{
        
        [weakself saveSuccessEvent];
       
        
    } fail:^(NSString *failStr) {
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:failStr];
    }];
}

//保存成功后返回 防止从首页进入点击保存，返回block调用两次
- (void)saveSuccessEvent{
    
    if (self.isReturnToRootVC == YES) {//直接返回
        
         [MBProgressHUD showSuccessView:self.navigationController.view SuccessTitle:[NSString stringWithFormat:@"运单%@添加证书成功",self.cerview.model.mdoel.YDH]];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    
    switch (self.type) {
            
        case FromRemark:
        {
             self.block();
        }
            break;
        case FromFirst:
        {
            
        }
            break;
      
    }
    [MBProgressHUD showSuccessView:self.navigationController.view];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark------------------------------------------------------------------------------------

- (void)layout{
    
    CGFloat Xpad = kuan *0.02;
    
    CGFloat YPad = self.view.bounds.size.height *0.02;
    
    [_leftview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Xpad);
        make.top.equalTo(self.view).offset(YPad);
        make.bottom.equalTo(self.view).offset(-YPad);
        make.width.equalTo(self.view).multipliedBy(0.64);
    }];
    
    [_cerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(YPad);
        make.bottom.equalTo(self.view).offset(-YPad);
        make.right.equalTo(self.view).offset(-Xpad);
        make.left.equalTo(self.leftview.mas_right).offset(Xpad);
    }];
    
    [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.leftview);
    }];
    
}

- (CerView *)cerview{
    if (!_cerview) {
        _cerview = [[CerView alloc] init];
        _cerview.backgroundColor = [UIColor whiteColor];
        _cerview.layer.masksToBounds = YES;
        _cerview.layer.cornerRadius = 10;
        [_cerview.scanBtn addTarget:self action:@selector(scanEvent) forControlEvents:UIControlEventTouchUpInside];
        [_cerview.saveBtn addTarget:self action:@selector(saveReturnEvent) forControlEvents:UIControlEventTouchUpInside];
        [_cerview.saveAddBZBtn addTarget:self action:@selector(saveAddBZEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cerview;
}

- (UIView *)leftview{
    if (!_leftview) {
        _leftview = [[UIView alloc] init];
        _leftview.backgroundColor = [UIColor whiteColor];
        _leftview.layer.masksToBounds = YES;
        _leftview.layer.cornerRadius = 10;
    }
    return _leftview;
}

- (SelectCerModel *)model{
    if (!_model) {
        _model = [[SelectCerModel alloc] init];
    }
    return _model;
}

- (AddCerNetViewModel *)netViewModel{
    if (!_netViewModel) {
        _netViewModel = [[AddCerNetViewModel alloc] init];
    }
    return _netViewModel;
}
- (UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        flowlayout.minimumLineSpacing = 20;
        flowlayout.minimumLineSpacing = 20;
        flowlayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        _collectionview.layer.masksToBounds = YES;
        _collectionview.layer.cornerRadius = 10;
        [_collectionview registerNib:[UINib nibWithNibName:@"CerCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CerCollectionCellID"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionview;
}

#pragma mark------------------------------------------------------------------------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     return CGSizeMake((self.collectionview.frame.size.width - (20 * 3))/2, (self.collectionview.frame.size.height - (20 * 3))/2);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.CanUsePicArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CerCollectionCellID" forIndexPath:indexPath];
    [cell loadimageWithUrl:self.model.CanUsePicArray[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    [ShowMoreImageView showImageViewWithImageUrlArray:self.model.CanUsePicArray selcectIndex:indexPath.row FrameArray:[self firstImageViewFrames]];
}

//构造图片Frame数组
- (NSArray<NSValue *> *)firstImageViewFrames{
    
    NSMutableArray *imageFrames = [NSMutableArray new];
    for (int i = 0; i < self.model.CanUsePicArray.count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CerCollectionCell * cell = (CerCollectionCell *)[self.collectionview cellForItemAtIndexPath:indexPath];
        
        if (cell.cerImageView) {
            //获取当前view在Window上的frame
            CGRect frame = [self windowBefromFrameWithimageView:cell.cerImageView];
            [imageFrames addObject:[NSValue valueWithCGRect:frame]];
            
        }else{//当前不可见的cell,frame设为CGRectZero添加到数组中,防止数组越界

            CGRect frame = CGRectMake(self.collectionview.center.x-2.5, self.collectionview.center.y-2.5, 5, 5);
            [imageFrames addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    
    return imageFrames;
}

- (CGRect)windowBefromFrameWithimageView:(UIImageView *)imageview{
    
    CGRect frame = imageview.frame;
    
    CGRect beforframe = [imageview.superview convertRect:frame toView:self.view.window];
    
    return beforframe;
}

- (CGRect)windowAfterFrameWithimageView:(UIImageView *)imageview{
    
    
    //    CGSize size = imageview.image.size;
    //
    //    CGSize newSize;
    //    newSize.height = gao;
    //    newSize.width = newSize.height / size.height * size.width;
    //
    //    CGFloat imageX = (kuan - newSize.width) * 0.5;
    //
    //    if (imageX < 0) {
    //        imageX = 0;
    //    }
    //    CGRect rect =  CGRectMake(imageX, 0, newSize.width, newSize.height);
    
    //    return rect;
    
    return [UIScreen mainScreen].bounds;
}

@end
