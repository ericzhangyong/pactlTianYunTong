//
//  FlyPhotoPickViewController.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotoPickViewController.h"
#import "PickBootomView.h"
#import "FlyPhotoPickCollectionCell.h"
#import "FlyPhotoData.h"
#import "FlyPhotoFooterResuabview.h"
#import "FlyPhotopreViewController.h"
#import "MBProgressHUD+FLyHUD.h"

@interface FlyPhotoPickViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) PickBootomView *BootomView;

@property (nonatomic) NSMutableArray *PicArray;

@property (nonatomic) FlyPhotoData *photoData;

@property (nonatomic) NSMutableArray *selectarray;

@end

@implementation FlyPhotoPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getPicData];
    
    [self creatUI];
}
//取消
- (void)cacelEvent{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc{
    NSLog(@"照片展示delloc");
}

#pragma mark---Event
- (void)selectImageWithBtn:(UIButton *)btn{
    
    
    
    
    BOOL Isselect = [self.selectarray containsObject:self.PicArray[btn.tag]];
    
    if (Isselect == YES) {//是否选中过
        
        [self.selectarray removeObject:self.PicArray[btn.tag]];
        [btn setImage:[UIImage imageNamed:@"photo_def_previewVc"] forState:UIControlStateNormal];
        
    }else{
        
        if (self.selectarray.count >= self.MaxSelectPicCout) {//添加照片达到最大数目返回
            [self jinggao];
            return;
        }else{
            [self selectAnimationWithBtn:btn];//选中动画
            [self.selectarray addObject:self.PicArray[btn.tag]];
            [btn setImage:[UIImage imageNamed:@"photo_sel_photoPickerVc"] forState:UIControlStateNormal];
        }
    }
    
    if (self.selectarray.count>0) {
        self.BootomView.topView.hidden = YES;
        [self.BootomView.completeBtn setTitle:[NSString stringWithFormat:@"完成(%lu)",(unsigned long)self.selectarray.count] forState:UIControlStateNormal];
    }else{
        self.BootomView.topView.hidden = NO;
        [self.BootomView.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        
    }
    
}

//选中按钮动画
- (void)selectAnimationWithBtn:(UIButton *)btn{
    
    CAKeyframeAnimation *keyanmation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    keyanmation.duration = 0.5;
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)]];
    [array addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)]];
    [array addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)]];
    [array addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    
    keyanmation.values = array;
    
    [btn.layer addAnimation:keyanmation forKey:@"transformanition"];
}
//警告
- (void)jinggao{
    UIAlertController *aleart = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您最多只能选择%ld张照片",(long)self.MaxSelectPicCout] message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
    [aleart addAction:ok];
    
    [self presentViewController:aleart animated:YES completion:nil];
}
//完成
- (void)completeSlectImageevent{
    
    [MBProgressHUD showLoadView:self.navigationController.view loadTitle:@"正在加载..."];
    
    __block  NSMutableArray *array = [NSMutableArray array];
    
    for (PHAsset *asset in self.selectarray) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];//同步，不会导致添加数组的顺序混乱(注意)
        option.synchronous = YES;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            FlyLog(@"%@",info);
            UIImage *image = [self scaleImageWIthscaleimage:result];
            NSData *data = UIImageJPEGRepresentation(image, 0.5);
            [array addObject:data];
            
            if (array.count == self.selectarray.count) {
                [MBProgressHUD showSuccessView:self.navigationController.view];
                NSArray *picarray = [NSArray arrayWithArray:array];
                self.Photoresult(picarray);
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }
            
        }];


    }
    
    
}
//image
- (UIImage *)scaleImageWIthscaleimage:(UIImage *)image{
    
    CGFloat scale = image.size.width/image.size.height;
    
    CGFloat Width = kuan;
    
    CGFloat height = Width /scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(Width, height));
    
    [image drawInRect:CGRectMake(0, 0, Width, height)];
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimage;
    
}
//预览
- (void)lookSlectimage{
    
    [self intoPreviewVcSelectIndex:0 photoarray:self.selectarray];
}

//进去预览
- (void)intoPreviewVcSelectIndex:(NSInteger)index photoarray:(NSMutableArray *)array{
    
    FlyPhotopreViewController *previewvc = [[FlyPhotopreViewController alloc] init];
    
    previewvc.selectindex = index;
    
    previewvc.photoarray = [NSArray arrayWithArray:array];
    
    previewvc.title = [NSString stringWithFormat:@"%ld/%ld",previewvc.selectindex+1,previewvc.photoarray.count];
    
    [self.navigationController pushViewController:previewvc animated:YES];
}

#pragma mark----CollectionViewDelegate & DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.PicArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FlyPhotoPickCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlyPhotoPickCollectionCellID" forIndexPath:indexPath];
    [cell loaddataWith:self.PicArray[indexPath.row] selectarray:self.selectarray];
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(selectImageWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        FlyPhotoFooterResuabview *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FlyPhotoFooterResuabviewID" forIndexPath:indexPath];
        footer.countlable.text = [NSString stringWithFormat:@"%lu 张照片",(unsigned long)self.PicArray.count];
        return footer;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self intoPreviewVcSelectIndex:indexPath.row photoarray:self.PicArray];
}
#pragma mark---UI

- (void)getPicData{
    
    if (self.isFirstGetIn == YES) {
        self.PicArray = [self.photoData getPicAssetArrayWithFetResult:[self.photoData getFetResultCameraDatas]];
        self.title = @"相机胶卷";
        
    }else{
        self.PicArray = [self.photoData getPicAssetArrayWithFetResult:self.fetchResult];
    }
}



- (void)creatUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *RightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cacelEvent)];
    self.navigationItem.rightBarButtonItem = RightItem;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.BootomView];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.PicArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        flowLayout.itemSize = CGSizeMake((kuan - (5 *5))/4, (kuan - (5 *5))/4);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.headerReferenceSize = CGSizeZero;
        flowLayout.footerReferenceSize = CGSizeMake(kuan, 44);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kuan, gao-64-50) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"FlyPhotoPickCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FlyPhotoPickCollectionCellID"];
        [_collectionView registerNib:[UINib nibWithNibName:@"FlyPhotoFooterResuabview" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FlyPhotoFooterResuabviewID"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _collectionView;
}

- (PickBootomView *)BootomView{
    if (!_BootomView) {
        _BootomView = [[PickBootomView alloc] initWithFrame:CGRectMake(0, gao-50, kuan, 50)];
        [_BootomView.completeBtn addTarget:self action:@selector(completeSlectImageevent) forControlEvents:UIControlEventTouchUpInside];
        [_BootomView.lookBtn addTarget:self action:@selector(lookSlectimage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _BootomView;
}

- (NSMutableArray *)PicArray{
    if (!_PicArray) {
        _PicArray = [NSMutableArray array];
    }
    return _PicArray;
}

- (FlyPhotoData *)photoData{
    if (!_photoData) {
        _photoData = [[FlyPhotoData alloc] init];
    }
    return _photoData;
}

- (NSMutableArray *)selectarray{
    if (!_selectarray) {
        _selectarray = [NSMutableArray array];
    }
    return _selectarray;
}
@end
