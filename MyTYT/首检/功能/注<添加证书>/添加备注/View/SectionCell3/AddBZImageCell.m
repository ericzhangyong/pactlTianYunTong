//
//  AddBZImageCell.m
//  MyTYT
//
//  Created by Fly on 2018/6/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZImageCell.h"
#import "AddBZImageModel.h"
#import "AddBZcollectionviewcell.h"
#import "MyimageModel.h"

@interface AddBZImageCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) AddBZImageModel *imageModel;

@end

@implementation AddBZImageCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionview.collectionViewLayout = flowlayout;
    [self.collectionview registerNib:[UINib nibWithNibName:@"AddBZcollectionviewcell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([AddBZcollectionviewcell class])];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
}

- (void)loaddataWithModel:(AddBZImageModel *)model{
    
    self.imageModel = model;
    
    [self layoutIfNeeded];
    [self.collectionview reloadData];


}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageModel.dataarray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddBZcollectionviewcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AddBZcollectionviewcell class]) forIndexPath:indexPath];
    MyimageModel *mdoel = self.imageModel.dataarray[indexPath.row];
    
    [cell loadImageViewWithPicData:mdoel.data];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_delegate respondsToSelector:@selector(selectIndex:)]) {
        [_delegate selectIndex:indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
@end
