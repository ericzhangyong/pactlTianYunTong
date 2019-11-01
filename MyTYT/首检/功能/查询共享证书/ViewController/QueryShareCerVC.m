//
//  QueryShareCerVC.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryShareCerVC.h"
#import "QueryShareNetViewModel.h"
#import "QueryDataManger.h"
#import "QueryStateCell.h"
#import "QueryAgentCell.h"
#import "QueryImageCell.h"
#import "QueryCollectionReusableHeadView.h"
#import "QueryRowModel.h"
#import "QuerySectionModle.h"
#import "QueryFootResuableView.h"
#import "Masonry.h"
#import "PreSentScanVC.h"
#import "RequestAuthor.h"
#import "SelctCerAllModel.h"
#import "MBProgressHUD+FLyHUD.h"
#import "SelectCerVC.h"
#import "SelectCerModel.h"
#import "QueryCerStateModel.h"
#import "ShowMoreImageView.h"
#import "QueryCerImageModel.h"
#import "ShowShareImageView.h"
#import "SQDLCEll.h"
#import "ShareLayout.h"

@interface QueryShareCerVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) QueryShareNetViewModel *NetViewModel;

@property (nonatomic) UICollectionView * collectionView;

@property (nonatomic) QueryDataManger *dataManager;

@end

@implementation QueryShareCerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
    
    [self scanEvent];
}

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
        
        [self requestDataWithStr:scanStr];
        FlyLog(@"%@",scanStr);
    };
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scanvc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nav animated:YES completion:nil];
}



- (void)creatUI{
    
    self.title = @"查询共享证书";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.collectionView];
    

    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}

- (void)requestDataWithStr:(NSString *)str{
    
    [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在查询证书信息"];
    
    __weak typeof(self)weakself = self;
    
    [self.NetViewModel queryShareCerBookNo:str suuccess:^(SelctCerAllModel *allModel) {
        
        if (allModel.ok == 1) {
            
            if (allModel.array.count == 0) {//没有数据
                
                [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:@"不存在的证书"];
                
                weakself.dataManager = [[QueryDataManger alloc] initBaseData];
                weakself.dataManager.stateModel.CerStr = str;
                weakself.dataManager.stateModel.FailStateStr = @"不存在的证书";
                [weakself setBaseData];
                
            }else if (allModel.array.count>1){//有多个
                
                [MBProgressHUD showSuccessView:weakself.navigationController.view];
                
                SelectCerVC *vc = [[SelectCerVC alloc] init];
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                vc.dataarray = allModel.array;
                
                vc.block = ^(SelectCerModel *mdoel) {
                    [weakself LogincalWithCerModel:mdoel];
                };
                
                nav.modalPresentationStyle = UIModalPresentationFormSheet;
                
                if (allModel.array.count > 4) {
                    nav.preferredContentSize = CGSizeMake(kuan*0.5, 4*110);
                }else{
                    nav.preferredContentSize = CGSizeMake(kuan*0.5, allModel.array.count*110);
                }
                
                [weakself presentViewController:nav animated:YES completion:nil];
                
            }else if(allModel.array.count == 1){//有一个
                
               SelectCerModel *mdoel = [allModel.array firstObject];
                
                [weakself LogincalWithCerModel:mdoel];
                
            }
            
        }else{
            
            
            [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:allModel.msg];
            
            weakself.dataManager = [[QueryDataManger alloc] initBaseData];
            weakself.dataManager.stateModel.CerStr = str;
            weakself.dataManager.stateModel.FailStateStr = allModel.msg;
            
            [weakself setBaseData];

            
        }
        
    } fail:^(NSString *FailStr) {
        
        [MBProgressHUD showErrorView:weakself.navigationController.view errorTitle:FailStr];
    
        weakself.dataManager = [[QueryDataManger alloc] initBaseData];
        weakself.dataManager.stateModel.CerStr = str;
        weakself.dataManager.stateModel.FailStateStr = FailStr;
        [weakself setBaseData];
    }];
}


//取得证书后的逻辑
- (void)LogincalWithCerModel:(SelectCerModel *)model{
    
    self.dataManager = [[QueryDataManger alloc] initWithModel:model];
    self.dataManager.stateModel.CerStr = model.bookNo;
    
    if ([model.returnStatus isEqualToString:@"100"]) {
        
        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:@"证书已停用，请重新选择证书"];
        self.dataManager.stateModel.FailStateStr = @"证书已停用，请重新选择证书";
        
    }else if ([model.returnStatus isEqualToString:@"102"]){
        
        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:@"证书已过期，请重新选择证书"];
        self.dataManager.stateModel.FailStateStr = @"证书已过期，请重新选择证书";

        
    }else if ([model.returnStatus isEqualToString:@"105"]){
        
        [MBProgressHUD showErrorView:self.navigationController.view errorTitle:model.returnReason];
        self.dataManager.stateModel.FailStateStr = model.returnReason;
        

    }else{
        self.dataManager.stateModel.FailStateStr = @"";

        [MBProgressHUD showSuccessView:self.navigationController.view];
    }
    
    [self.collectionView reloadData];
    
  
    
    if (self.dataManager.cermodel.CanUsePicArray.count >0) {
        [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];       
    }
    
}

- (void)setBaseData{
    
    [self.collectionView reloadData];
}


- (QueryShareNetViewModel *)NetViewModel{
    if (!_NetViewModel) {
        _NetViewModel = [[QueryShareNetViewModel alloc] init];
    }
    return _NetViewModel;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        ShareLayout *layout = [[ShareLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"QueryCollectionReusableHeadView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([QueryCollectionReusableHeadView class])];
          [_collectionView registerNib:[UINib nibWithNibName:@"QueryFootResuableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([QueryFootResuableView class])];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"QueryStateCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([QueryStateCell class])];
           [_collectionView registerNib:[UINib nibWithNibName:@"QueryAgentCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([QueryAgentCell class])];
           [_collectionView registerNib:[UINib nibWithNibName:@"QueryImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([QueryImageCell class])];
                [_collectionView registerNib:[UINib nibWithNibName:@"SQDLCEll" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([SQDLCEll class])];
    }
    return _collectionView;
}

- (QueryDataManger *)dataManager{
    if (!_dataManager) {
        _dataManager = [[QueryDataManger alloc] init];
    }
    return _dataManager;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataManager.sectionArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[section];
    
    return sectionModel.rowArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[indexPath.section];
    QueryRowModel *rowModel = sectionModel.rowArray[indexPath.row];
    
    switch (rowModel.cellType) {
        case RowCerStateType:
        {
            QueryStateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QueryStateCell class]) forIndexPath:indexPath];
            [cell.Scanbtn addTarget:self action:@selector(scanEvent) forControlEvents:UIControlEventTouchUpInside];
            [cell loaddataWithBaseModel:rowModel.model];
            return cell;
        }
            break;
            
            
        case RowSQDLType:
        {
            SQDLCEll *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SQDLCEll class]) forIndexPath:indexPath];
            [cell loaddataWithModel:rowModel.model];
            cell.lable.textColor = BtnColor;
            
            return cell;
        }
            break;
            
        case RowAgentType:
        {
            QueryAgentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QueryAgentCell class]) forIndexPath:indexPath];
            [cell loaddataWithBaseModel:rowModel.model];

            return cell;
        }
            break;
        case RowImageType:
        {
            QueryImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([QueryImageCell class]) forIndexPath:indexPath];
            [cell loaddataWithBaseModel:rowModel.model];

            return cell;
        }
            break;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[indexPath.section];
    QueryRowModel *rowModel = sectionModel.rowArray[indexPath.row];
    
    switch (rowModel.cellType) {
        case RowCerStateType:
        {
          
        }
            break;
        case RowSQDLType:
        {
            
        }
            break;
            
        case RowAgentType:
        {
          
        }
            break;
        case RowImageType:
        {

            [ShowShareImageView showImageViewWithImageUrlArray:self.dataManager.cermodel.CanUsePicArray selcectIndex:rowModel.dataRow FrameArray:[self firstImageViewFramesWithArray:self.dataManager.cermodel.CanUsePicArray] AgentArray:self.dataManager.AgentArray];
          
        }
            break;
    }
    
}


//构造图片Frame数组
- (NSArray<NSValue *> *)firstImageViewFramesWithArray:(NSArray *)picArray{
    
    NSMutableArray *imageFrames = [NSMutableArray new];
    for (int i = 0; i < picArray.count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:2];
        QueryImageCell * cell = (QueryImageCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        
        if (cell.imageview) {
            //获取当前view在Window上的frame
            CGRect frame = [self windowBefromFrameWithimageView:cell.imageview];
            [imageFrames addObject:[NSValue valueWithCGRect:frame]];
            
        }else{//当前不可见的cell,frame设为CGRectZero添加到数组中,防止数组越界
            
            CGRect frame = CGRectMake(self.collectionView.center.x-2.5, self.collectionView.center.y-2.5, 5, 5);
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
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[indexPath.section];

    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        
        QueryCollectionReusableHeadView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([QueryCollectionReusableHeadView class]) forIndexPath:indexPath];
        
        headview.title.text = sectionModel.Sectiontitle;
        
        return headview;
        
    }
    
        QueryFootResuableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([QueryFootResuableView class]) forIndexPath:indexPath];
        return footerview;
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[indexPath.section];
    QueryRowModel *rowModel = sectionModel.rowArray[indexPath.row];
    
    return rowModel.itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[section];
    return sectionModel.sectionInset;

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[section];
    return sectionModel.minlineSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[section];
    return sectionModel.minInterSpace;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[section];
    return sectionModel.SectionheadSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    QuerySectionModle *sectionModel = self.dataManager.sectionArray[section];
    return sectionModel.SectionfootSize;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    view.layer.zPosition = 0;
}

@end
