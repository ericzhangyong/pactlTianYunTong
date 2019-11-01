//
//  ShowMoreImageView.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowMoreImageView.h"
#import "ShowMoreCell.h"
#import "UIImageView+WebCache.h"

#define distance 20

@interface ShowMoreImageView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic) UICollectionView *collectionview;

@property (nonatomic) UIPageControl *pagecontrol;

@property (nonatomic) NSArray *urlarray;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic) NSArray *frameArray;

@property (nonatomic) NSArray *AgentArray;

@property (nonatomic) NSMutableArray *contentOffsetArray;

@end

@implementation ShowMoreImageView

- (void)dealloc{
    
    FlyLog(@"证书查看delloc----");
}



+ (instancetype)showImageViewWithImageUrlArray:(NSArray *)urlarray selcectIndex:(NSInteger)selectIndex FrameArray:(NSArray *)frameArray{
    
    
    ShowMoreImageView *moreview = [[ShowMoreImageView alloc] initWithshowWithURlArray:urlarray selcectIndex:selectIndex frameArray:frameArray];
    
    return moreview;

}


- (instancetype)initWithshowWithURlArray:(NSArray *)urlArray selcectIndex:(NSInteger)selectIndex frameArray:(NSArray *)framearray{
    
    if(self = [super init]){
        
        self.urlarray = urlArray;
        
        self.selectIndex =selectIndex;
        
        self.frameArray = framearray;
        
        [self creatAnimation];
        
      
        
    }
    return self;
}

- (void)creatAnimation{
    
    UIWindow *keywind = [UIApplication sharedApplication].keyWindow;
    
    keywind.backgroundColor = [UIColor whiteColor];
    
    self.frame = keywind.bounds;
    
    self.backgroundColor = [UIColor blackColor];
    
    [keywind addSubview:self];
    
    [self addSubview:self.collectionview];
    
    [self addSubview:self.pagecontrol];
    
    [self setSelectIndex];
    
    
}

- (CGRect)windowAfterFrameWithimage:(UIImage *)image{


    CGSize size = image.size;

    CGSize newSize;
    
    newSize.width = kuan;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (gao - newSize.height) *0.5;
    
    if (imageY < 0 ) {
        imageY = 0;
    }
    
    CGRect rect = CGRectMake(0, imageY, newSize.width, newSize.height);

    return rect;


}


+ (instancetype)showImageViewWithImageUrlArray:(NSArray *)urlarray selcectIndex:(NSInteger)selectIndex{
    
    ShowMoreImageView *moreview = [[ShowMoreImageView alloc] initWithshowWithURlArray:urlarray selcectIndex:selectIndex];
    
    return moreview;
}


- (instancetype)initWithshowWithURlArray:(NSArray *)urlArray selcectIndex:(NSInteger)selectIndex{
    
    if(self = [super init]){
       
        self.urlarray = urlArray;
        
        self.selectIndex =selectIndex;
        
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    UIWindow *keywind = [UIApplication sharedApplication].keyWindow;
    
    self.frame = keywind.bounds;
    
    self.backgroundColor = [UIColor blackColor];
    
    [keywind addSubview:self];
    
    [self addSubview:self.collectionview];
    
    [self addSubview:self.pagecontrol];
    
    [self setSelectIndex];
    
    self.alpha = 0;
    
    
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1;
    }];
    
}

- (void)setSelectIndex{
    
    [self.collectionview setContentOffset:CGPointMake(self.collectionview.frame.size.width * self.selectIndex, self.collectionview.frame.size.height) animated:NO];
}

- (UICollectionView *)collectionview{
    if (!_collectionview) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kuan, gao);
        layout.minimumLineSpacing = distance;
        layout.sectionInset = UIEdgeInsetsMake(0, distance/2, 0, distance/2);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(-(distance/2), 0, kuan+distance, gao) collectionViewLayout:layout];
        [_collectionview registerNib:[UINib nibWithNibName:@"ShowMoreCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ShowMoreCellID"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        _collectionview.pagingEnabled = YES;
        _collectionview.showsHorizontalScrollIndicator = NO;
    }
    return  _collectionview;
}
- (UIPageControl *)pagecontrol{
    if (!_pagecontrol) {
        _pagecontrol = [[UIPageControl alloc] init];
        _pagecontrol.pageIndicatorTintColor = [UIColor grayColor];
        _pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pagecontrol.frame = CGRectMake(200, gao-40, kuan-400, 30);
        _pagecontrol.numberOfPages = self.urlarray.count > 1 ? self.urlarray.count : 0;
    }
    return _pagecontrol;
}

#pragma mark------------------------------------------------------------------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.urlarray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowMoreCellID" forIndexPath:indexPath];
    [cell loadImageWithURlStr:self.urlarray[indexPath.row]];
    [self addgestureForScrollerview:cell.scrollerview];
    cell.scrollerview.delegate = self;
    cell.scrollerview.tag = indexPath.row +100;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowMoreCell *morecell = (ShowMoreCell *)cell;
    
    [morecell.scrollerview setContentOffset:CGPointMake(0,[self.contentOffsetArray[indexPath.row] floatValue]) animated:NO];
    FlyLog(@"--willplay %@",self.contentOffsetArray[indexPath.row]);
}

#pragma mark------------------------------------------------------------------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.collectionview]) {
        
  NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    
    self.pagecontrol.currentPage = page;
    }

}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if ([scrollView isEqual:self.collectionview]) {
        
    }else{
        
        FlyLog(@"%@",NSStringFromCGPoint(*targetContentOffset));
        
        NSInteger row = scrollView.tag - 100;
        
        [self.contentOffsetArray replaceObjectAtIndex:row withObject:@(targetContentOffset->y)];
    }
   
}


#pragma mark------------------------------------------------------------------------------------
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
   
    if (self.frameArray.count >0) {
    
    self.collectionview.hidden = YES;
    self.pagecontrol.hidden = YES;
    
  ShowMoreCell *cell = (ShowMoreCell *) [self.collectionview cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.pagecontrol.currentPage inSection:0]];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:cell.imageview.frame];
    
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    
    imageview.image = cell.imageview.image;
    
    imageview.clipsToBounds = YES;
    
    [self addSubview:imageview];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = [self.frameArray[self.pagecontrol.currentPage] CGRectValue];

        imageview.frame = frame;

        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
        
    }else{
        [UIView animateWithDuration:0.15 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];

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


//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    return scrollView.subviews[0];
//}


#pragma mark----private
- (CGRect )zoomrectForScale:(float)scale size:(CGSize )size center:(CGPoint )center{
    CGRect zoomRect;
    zoomRect.size.height = size.height/scale;
    zoomRect.size.width = size.width/scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width/2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height/2.0);
    return zoomRect;
}

- (NSMutableArray *)contentOffsetArray{
    if (!_contentOffsetArray) {
        _contentOffsetArray = [NSMutableArray array];
        for (int i=0; i<self.urlarray.count; i++) {
            [_contentOffsetArray addObject:@0];
        }
    }
    return _contentOffsetArray;
}
@end
