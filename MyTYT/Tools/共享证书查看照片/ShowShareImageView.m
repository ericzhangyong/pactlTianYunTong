//
//  ShowShareImageView.m
//  MyTYT
//
//  Created by Fly on 2018/6/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowShareImageView.h"
#import "ShowAgentView.h"
#import "ShowShareCell.h"


#define distance 20

@interface ShowShareImageView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic) UICollectionView *collectionview;

@property (nonatomic) UIPageControl *pagecontrol;

@property (nonatomic) NSArray *urlarray;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic) NSArray *frameArray;

@property (nonatomic) NSArray *AgentArray;

@property (nonatomic) ShowAgentView *agentView;

@property (nonatomic) NSMutableArray *contentOffsetArray;

@end

@implementation ShowShareImageView

- (void)dealloc{
    
    FlyLog(@"查询共享证书delloc");
}

//展示代理用
+ (instancetype)showImageViewWithImageUrlArray:(NSArray *)urlarray selcectIndex:(NSInteger)selectIndex FrameArray:(NSArray *)frameArray AgentArray:(NSArray *)agentArray{
    
    ShowShareImageView *more = [[ShowShareImageView alloc] initWithshowWithURlArray:urlarray selcectIndex:selectIndex frameArray:frameArray AgentArray:agentArray];
    
    return more;
}

- (instancetype)initWithshowWithURlArray:(NSArray *)urlArray selcectIndex:(NSInteger)selectIndex frameArray:(NSArray *)framearray AgentArray:(NSArray *)agentArray{
    
    if (self = [super init]) {
        
        self.urlarray = urlArray;
        
        self.selectIndex =selectIndex;
        
        self.frameArray = framearray;
        
        self.AgentArray = agentArray;
        
        [self showAniamtion];
        
    }
    
    return self;
}

- (void)showAniamtion{
    
    UIWindow *keywind = [UIApplication sharedApplication].keyWindow;
    
    keywind.backgroundColor = [UIColor whiteColor];
    
    self.frame = keywind.bounds;
    
    self.backgroundColor = [UIColor blackColor];
    
    [keywind addSubview:self];
        
      NSInteger  line = (self.AgentArray.count + 1)/8 + 1;
        
        line = line >3 ? 3 : line;
 
    
    self.agentView = [[ShowAgentView alloc] initWithFrame:CGRectMake(0, 0, kuan,line *40 + (line + 1)*20)];
    
    [self addSubview:self.agentView];

    [self addSubview:self.collectionview];
    
    [self addSubview:self.pagecontrol];
    
    [self.agentView freshDataWithArray:self.AgentArray];
    
    [self setSelectIndex];
       
}


- (void)setSelectIndex{
    
    [self.collectionview setContentOffset:CGPointMake(self.collectionview.frame.size.width * self.selectIndex, self.collectionview.frame.size.height) animated:NO];
}

- (UICollectionView *)collectionview{
    if (!_collectionview) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kuan, gao-CGRectGetMaxY(self.agentView.frame));
        layout.minimumLineSpacing = distance;
        layout.sectionInset = UIEdgeInsetsMake(0, distance/2, 0, distance/2);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(-(distance/2), CGRectGetMaxY(self.agentView.frame), kuan+distance, gao-CGRectGetMaxY(self.agentView.frame)) collectionViewLayout:layout];
        [_collectionview registerNib:[UINib nibWithNibName:@"ShowShareCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ShowShareCellID"];
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
    ShowShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowShareCellID" forIndexPath:indexPath];
    [cell loadImageWithURlStr:self.urlarray[indexPath.row]];
    [self addgestureForScrollerview:cell.scrollerview];
    cell.scrollerview.delegate = self;
    cell.scrollerview.tag = indexPath.row + 100;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowShareCell *showcell = (ShowShareCell *)cell;
    
    [showcell.scrollerview setContentOffset:CGPointMake(0, [self.contentOffsetArray[indexPath.row] floatValue]) animated:NO];
}
//添加手势
- (void)addgestureForScrollerview:(UIScrollView *)scrollerview{
    UITapGestureRecognizer *singtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvenWith:)];
    [scrollerview addGestureRecognizer:singtap];
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
        
        NSInteger row = scrollView.tag - 100;
        [self.contentOffsetArray replaceObjectAtIndex:row withObject:@(targetContentOffset->y)];
    }
}

//单击
- (void)tapEvenWith:(UITapGestureRecognizer *)gesture{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
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
