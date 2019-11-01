//
//  AddBZCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZCell.h"
#import "BZModle.h"
#import "UIButton+WebCache.h"
#import "AddBZcollectionviewcell.h"
#import "ShowMoreImageView.h"

#define lineImagecount 3

@interface AddBZCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic)BZModle *model;

@end

@implementation AddBZCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.timelable.adjustsFontSizeToFitWidth = YES;
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionview.collectionViewLayout = flowlayout;
    [self.collectionview registerNib:[UINib nibWithNibName:@"AddBZcollectionviewcell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([AddBZcollectionviewcell class])];
    

  
}

- (void)loaddataWithModel:(BZModle *)model{
  
    self.model = model;

    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;

    
    [self.collectionview reloadData];

  
    //更新collectionview高度
    self.heightContant.constant = self.collectionview.collectionViewLayout.collectionViewContentSize.height;

    //员工
    self.yglable.text =model.employid;
    //时间
    self.timelable.text = model.time;
    //内容
    self.textview.text = model.remark;
    
    //是否可以编辑
    if (model.IsCanEditContent == YES) {
        self.textview.editable = YES;
    }else{
        self.textview.editable = NO;
    }
    
    //删除编辑按钮是否可以点击
    if ([model.isedit isEqualToString:@"1"]) {//可以编辑
        
        self.deletBtn.enabled = YES;
        self.editBtn.enabled = YES;
        
        [self.deletBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        
    }else{
        
        self.deletBtn.enabled = NO;
        self.editBtn.enabled = NO;
        
        [self.deletBtn setImage:[UIImage imageNamed:@"cantDelete"] forState:UIControlStateNormal];
        [self.editBtn setImage:[UIImage imageNamed:@"cantEDIt"] forState:UIControlStateNormal];
        
    }

    [self updateConstraints];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

#pragma mark------------------------------------------------------------------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.FileArray.count >0 ? self.model.FileArray.count :0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddBZcollectionviewcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AddBZcollectionviewcell class]) forIndexPath:indexPath];
    if (self.model.FileArray.count>0) {
        [cell loadimgaeviewWith:self.model.FileArray[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [ShowMoreImageView showImageViewWithImageUrlArray:self.model.FileArray selcectIndex:indexPath.row];
}


#pragma mark------------------------------------------------------------------------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
return  CGSizeMake((self.collectionview.bounds.size.width - (lineImagecount-1)*5)/lineImagecount, (self.collectionview.bounds.size.width - (lineImagecount - 1)*5)/lineImagecount);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

@end
