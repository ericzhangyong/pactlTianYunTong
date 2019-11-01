//
//  NewBZVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NewBZVC.h"
#import "newBZALLModel.h"
#import "newbzwzModel.h"
#import "NewBZModel.h"
#import "newbzWZCell.h"
#import "newYDCell.h"
#import "newbzZSCell.h"
#import "Newbzaddzscell.h"
#import "newbzkongcell.h"
#import "newBzPMCell.h"
#import "NewBZBZCell.h"
#import "newBZlayout.h"
#import "AddBZVC.h"
#import "ShowMoreImageView.h"
#import "AddCerVC.h"
#import "NewBZNetViewModel.h"
#import "LoadDataFailView.h"
#import "MBProgressHUD+FLyHUD.h"
#import "LookCerNetViewModel.h"
#import "BZCerModel.h"
#import "PDFImageModel.h"
#import "DeviceModel.h"

@interface NewBZVC ()<UICollectionViewDelegate,UICollectionViewDataSource,newbZcolltionviewldelegate>

@property (nonatomic) UICollectionView *colltionview;

@property (nonatomic) NSMutableArray *dataarray;

@property (nonatomic) NewBZNetViewModel *netViewModel;

@property (nonatomic) LookCerNetViewModel *PDfNetViewModel;


@end

@implementation NewBZVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self craetUI];
    
    [self requestData];

}

#pragma mark------------------------------------------------------------------------------------

- (void)craetUI{
    
    self.title = @"备注详情";
    [self.view addSubview:self.colltionview];
}


- (void)freshDataWithModel:(newBZALLModel *)mdoel{
    
    [self.dataarray removeAllObjects];
    
    newbzwzModel *wzmodel = [[newbzwzModel alloc] init];
    [self.dataarray addObject:wzmodel];//添加文字
    
   
    [self.dataarray addObjectsFromArray:mdoel.array];
    
    [self.colltionview reloadData];
}

- (void)requestData{
    
    
    __weak typeof(self)weakself =self;
    
    NSString *type;
    
    switch (self.Type) {
        case FIRSTTYPE:
        {
            type = @"0";
        }
            break;
            
        case TWenTYTYPE:
        {
            type = @"1";

        }
            break;
    }
    
    [self.netViewModel loadDataWithViewModel:self.view aWID:self.aWID Type:type deviceModel:self.deviceModel success:^(newBZALLModel *mdoel) {
        if (mdoel.ok == 1) {
            
            if (weakself.dataarray.count>0) {
                
                [weakself freshDataWithModel:mdoel];
                
            }else{
                [weakself freshDataWithModel:mdoel];
                
            }
            
        }else{
            [MBProgressHUD showTextView:weakself.view textTitle:mdoel.msg];
        }
    } fail:^(NSString *FailStr) {
        [weakself FailEvent];

    }];


}

- (void)FailEvent{
    
    __weak typeof(self)weakself = self;
    
    [LoadDataFailView ShowLoadFailViewWith:self.view frame:self.view.bounds clickBtn:^{
        [weakself requestData];
    }];
}

#pragma mark------------------------------------------------------------------------------------
//编辑备注
- (void)bZEventWith:(UIButton *)sender{
    
    NSInteger section = sender.tag -100;
    
   NewBZModel *model = self.dataarray[section];
    
    AddBZVC *addvc = [[AddBZVC alloc] init];
    
    
    addvc.block = ^{
        
        [self requestData];
    };
    
    addvc.opeartionModel = self.operationModel;
    
    addvc.MachID = self.deviceModel.machinID;
    
    addvc.aWID = model.awId;
    
    addvc.YDH = model.waybill_no;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addvc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    nav.preferredContentSize = CGSizeMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 100);
    
    [self presentViewController:nav animated:YES completion:nil];
}

//查看证书
- (void)quiryZSEventWith:(UIButton *)sender{
    
    NSInteger section = sender.tag/1000;
    NSInteger row = sender.tag % 1000;
    
    NewBZModel *mdoel = self.dataarray[section];
    BZCerModel *cerModel = mdoel.CanUseCerArray[row];
    
    [self lookZSWithModel:cerModel];
    
}

//加载证书图片
- (void)lookZSWithModel:(BZCerModel *)model{
    
    __weak typeof(self)weakself = self;
    
    NSString *bookid = [model.bookId isEqualToString:@""] ? model.ID : model.bookId;
    
    [self.PDfNetViewModel RequestCerImageArrayWithBookID:bookid start:^{
        [MBProgressHUD showLoadView:weakself.view loadTitle:@"正在加载证书"];
    } Success:^(PDFImageModel *Pdfmodel) {
        [MBProgressHUD showSuccessView:weakself.view];
        
        [ShowMoreImageView showImageViewWithImageUrlArray:Pdfmodel.picArray selcectIndex:0];
    } fail:^(NSString *failStr) {
        [MBProgressHUD showErrorView:weakself.view errorTitle:failStr];
    }];
    
}

#pragma mark------------------------------------------------------------------------------------
- (UICollectionView *)colltionview{
    if (!_colltionview) {
        newBZlayout *layout = [[newBZlayout alloc] init];
        _colltionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kuan, gao-64) collectionViewLayout:layout];
        _colltionview.delegate = self;
        _colltionview.dataSource = self;
        _colltionview.backgroundColor =  [UIColor groupTableViewBackgroundColor];
        
        
        _colltionview.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *)) {
            _colltionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        
        [_colltionview registerNib:[UINib nibWithNibName:@"newbzWZCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"newbzWZCellID"];
        [_colltionview registerNib:[UINib nibWithNibName:@"newYDCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"newYDCellID"];
        [_colltionview registerNib:[UINib nibWithNibName:@"newbzZSCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"newbzZSCellID"];
        [_colltionview registerNib:[UINib nibWithNibName:@"Newbzaddzscell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NewbzaddzscellID"];
        [_colltionview registerNib:[UINib nibWithNibName:@"newbzkongcell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"newbzkongcellID"];
        [_colltionview registerNib:[UINib nibWithNibName:@"newBzPMCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"newBzPMCellID"];
        [_colltionview registerNib:[UINib nibWithNibName:@"NewBZBZCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NewBZBZCellID"];
        
    }
    return _colltionview;
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

- (NewBZNetViewModel *)netViewModel{
    if (!_netViewModel) {
        _netViewModel = [[NewBZNetViewModel alloc] init];
    }
    return _netViewModel;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataarray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        newbzwzModel *mdoel = self.dataarray[section];
        return mdoel.wzarray.count;
    }
    
    NewBZModel *mdoel = self.dataarray[section];
    
    return mdoel.CanUseCerArray.count >0 ? mdoel.CanUseCerArray.count + 3 :mdoel.CanUseCerArray.count + 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        newbzwzModel *mdoel = self.dataarray[indexPath.section];
        
        newbzWZCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newbzWZCellID" forIndexPath:indexPath];
        [cell loaddataWithStr:mdoel.wzarray[indexPath.row]];
        
        return cell;
    }else {
        
        NewBZModel *model = self.dataarray[indexPath.section];
        
        if ([model.type isEqualToString:@"0"] && model.CanUseCerArray.count >0) {//带证书类型
            
            if (indexPath.item == 0) {
                
                newYDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newYDCellID" forIndexPath:indexPath];
                [cell loaddataWithModel:model];
                return cell;
                
            }else if (indexPath.item == model.CanUseCerArray.count + 1){
                
                newBzPMCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newBzPMCellID" forIndexPath:indexPath];
                [cell loaddataWithModel:model];
                return cell;
                
            }else if (indexPath.item == model.CanUseCerArray.count + 2){
                
                NewBZBZCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewBZBZCellID" forIndexPath:indexPath];
                [cell loaddataWithModel:model];
                cell.bzBtn.tag = indexPath.section + 100;
                [cell.bzBtn addTarget:self action:@selector(bZEventWith:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
                
            }else{
                
                newbzZSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newbzZSCellID" forIndexPath:indexPath];
                [cell loaddataWithModel:model.CanUseCerArray[indexPath.row-1]];
                cell.ZSImgBtn.tag = indexPath.section *1000 + indexPath.row - 1;
                cell.ZSTitleBtn.tag = indexPath.section *1000 + indexPath.row - 1;
                cell.deleteBtn.tag = indexPath.section *1000 + indexPath.row - 1;
                
                [cell.ZSTitleBtn addTarget:self action:@selector(quiryZSEventWith:) forControlEvents:UIControlEventTouchUpInside];
                [cell.ZSImgBtn addTarget:self action:@selector(quiryZSEventWith:) forControlEvents:UIControlEventTouchUpInside];
               
                
                return cell;
            }
            
            
        }else{//不带证书类型
            
            if (indexPath.item == 0) {
                
                
                newYDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newYDCellID" forIndexPath:indexPath];
                [cell loaddataWithModel:model];
                return cell;
            }else if (indexPath.item == 1){
                newbzkongcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newbzkongcellID" forIndexPath:indexPath];
                
                return cell;
            }else if (indexPath.item == 2){
                newBzPMCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newBzPMCellID" forIndexPath:indexPath];
                [cell loaddataWithModel:model];
                return cell;
            }else if(indexPath.item == 3){
                NewBZBZCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewBZBZCellID" forIndexPath:indexPath];
                cell.bzBtn.tag = indexPath.section + 100;
                [cell.bzBtn addTarget:self action:@selector(bZEventWith:) forControlEvents:UIControlEventTouchUpInside];
                [cell loaddataWithModel:model];
                return cell;
            }
        }
        
        
    }
  
    return nil;
    
}

#pragma mark------------------------------------------------------------------------------------

- (NewBZModel *)MymodelWithindexpath:(NSIndexPath *)indexpath{
    
    NewBZModel *model = self.dataarray[indexpath.section];
    return model;
}

@end
