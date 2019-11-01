//
//  FlyPhotopreViewController.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/12/5.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlypreViewController.h"
#import "FlyaViewCell.h"
#import "MyimageModel.h"

#define distance 20

@interface FlypreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *collectionview;

@property (nonatomic, assign) NSInteger deleteIndex;

@end

@implementation FlypreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteImage)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backEvent)];
    self.navigationItem.leftBarButtonItem = left;
    
    [self.view addSubview:self.collectionview];
    self.view.backgroundColor = [UIColor clearColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionview.frame = CGRectMake(-(distance/2), 0, self.view.bounds.size.width+distance,gao);
    
    if (self.selectindex == 0 ) {
        self.deleteIndex = 0;
        self.title = [NSString stringWithFormat:@"1/%ld", (unsigned long)self.photoarray.count];
    }else{
        [self.collectionview setContentOffset:CGPointMake(self.collectionview.bounds.size.width*self.selectindex, 0)];
    }
}



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.block(self.photoarray);
}
#pragma mark----Event
- (void)backEvent{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//删除图片
- (void)deleteImage{

    [self.photoarray removeObjectAtIndex:self.deleteIndex];
    
    [self.collectionview reloadData];
    
    CGFloat page =  self.collectionview.contentOffset.x/self.collectionview.frame.size.width;
    
    NSString *pageSTr = [NSString stringWithFormat:@"%.0f",page];
    
    self.deleteIndex = page;
    
    if (self.photoarray.count == 0) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
       
    }else{
        self.navigationItem.rightBarButtonItem.enabled = YES;

        self.title = [NSString stringWithFormat:@"%d/%ld",pageSTr.intValue+1,(unsigned long)self.photoarray.count];
    }
    
}
//添加手势
- (void)addgestureForScrollerview:(UIScrollView *)scrollerview{
    UITapGestureRecognizer *singtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvenWith:)];
    [scrollerview addGestureRecognizer:singtap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubletapWith:)];
    doubleTap.numberOfTapsRequired = 2;
    [scrollerview addGestureRecognizer:doubleTap];
    
    [singtap requireGestureRecognizerToFail:doubleTap];
    
}
//单击
- (void)tapEvenWith:(UITapGestureRecognizer *)gesture{
    
    if (self.navigationController.navigationBar.isHidden) {
        self.navigationController.navigationBar.hidden = NO;
        [UIApplication sharedApplication].statusBarHidden = NO;
    }else{
        self.navigationController.navigationBar.hidden = YES;
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
}

//双击
- (void)doubletapWith:(UITapGestureRecognizer *)gesture{
    UIScrollView *scrollerview =(UIScrollView *) gesture.view;
    
    CGFloat scale = 1;
    
    if (scrollerview.zoomScale !=3.0) {
        scale = 3;
    }else{
        scale = 1;
    }
    
    CGRect zoomrect = [self zoomrectForScale:scale size:scrollerview.frame.size center:[gesture locationInView:gesture.view]];
    [scrollerview zoomToRect:zoomrect animated:YES];
}


- (UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_collectionview registerNib:[UINib nibWithNibName:@"FlyaViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FlyaViewCellID"];
    }
    return _collectionview;
}
#pragma mark----CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoarray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 FlyaViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlyaViewCellID" forIndexPath:indexPath];
    
    MyimageModel *model = self.photoarray[indexPath.row];
//    [cell loadImageWith:model.FilepAth];
    [cell loadImageViewWithPicData:model.data];
    cell.scroolerview.delegate = self;
    
    [self addgestureForScrollerview:cell.scroolerview];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, distance/2, 0, distance/2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return distance;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return distance;
}
#pragma mark----ScrolelrviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView ==(UIScrollView *) self.collectionview) {
        
        CGFloat page =  scrollView.contentOffset.x/scrollView.frame.size.width;
        
        NSString *pageSTr = [NSString stringWithFormat:@"%.0f",page];
        
        self.deleteIndex = page;
        
        self.title = [NSString stringWithFormat:@"%d/%ld",pageSTr.intValue+1,(unsigned long)self.photoarray.count];
        
    }
  
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView.subviews[0];
}


#pragma mark----private
- (CGRect )zoomrectForScale:(float)scale size:(CGSize )size center:(CGPoint )center{
    CGRect zoomRect;
    zoomRect.size.height = size.height/scale;
    zoomRect.size.width = size.width/scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width/2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height/2.0);
    return zoomRect;
}


- (NSMutableArray *)photoarray{
    
    if (!_photoarray) {
        _photoarray = [NSMutableArray array];
    }
    return _photoarray;
}

@end
