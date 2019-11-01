//
//  FlyPhotopreViewController.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/12/5.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotopreViewController.h"
#import "FlyPreViewCollectionViewCell.h"

#define distance 20

@interface FlyPhotopreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *collectionview;

@end

@implementation FlyPhotopreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionview];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.collectionview setContentOffset:CGPointMake((kuan + distance)*self.selectindex, 0)];
}

#pragma mark----Event

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
        flowlayout.itemSize = CGSizeMake(kuan, gao);
        flowlayout.minimumLineSpacing = distance;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, distance/2, 0, distance/2);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(-(distance/2), 0, kuan+distance, gao) collectionViewLayout:flowlayout];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_collectionview registerNib:[UINib nibWithNibName:@"FlyPreViewCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FlyPreViewCollectionViewCellID"];
    }
    return _collectionview;
}
#pragma mark----CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoarray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 FlyPreViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlyPreViewCollectionViewCellID" forIndexPath:indexPath];
    
    [cell loadImageWithPhasset:self.photoarray[indexPath.item]];
    cell.scroolerview.delegate = self;
    
    [self addgestureForScrollerview:cell.scroolerview];
    return cell;
}

#pragma mark----ScrolelrviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView ==(UIScrollView *) self.collectionview) {
        
        CGFloat page =  scrollView.contentOffset.x/scrollView.frame.size.width;
        
        NSString *pageSTr = [NSString stringWithFormat:@"%.0f",page];
        
        self.title = [NSString stringWithFormat:@"%d/%ld",pageSTr.intValue+1,self.photoarray.count];
        
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

@end
