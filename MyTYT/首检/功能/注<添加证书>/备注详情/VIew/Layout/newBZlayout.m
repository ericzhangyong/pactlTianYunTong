//
//  newBZlayout.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newBZlayout.h"
#import "NewBZModel.h"
#import "NSString+Helper.h"

@interface newBZlayout ()

@property (nonatomic,assign) CGFloat totolheight;

@property (nonatomic) NSMutableArray *attriArray;

@end

@implementation newBZlayout

- (NSMutableArray *)attriArray{
    if (!_attriArray) {
        _attriArray = [NSMutableArray array];
    }
    return _attriArray;
}

- (void)prepareLayout{
    
    [super prepareLayout];
    
    [self.attriArray removeAllObjects];
    
    self.delegate = (id)self.collectionView.delegate;
    
    self.totolheight = 50;
    
    NSInteger section = self.collectionView.numberOfSections;
    
    for (int i=0; i<section; i++) {
        
        
        UICollectionViewLayoutAttributes *headattri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathWithIndex:i]];
        
        [self.attriArray addObject:headattri];
        
        
        NSInteger row = [self.collectionView numberOfItemsInSection:i];
        
        for (int j=0; j<row; j++) {
            
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            
            UICollectionViewLayoutAttributes *attri =  [self layoutAttributesForItemAtIndexPath:indexpath];
            
            [self.attriArray addObject:attri];
        }
        
        UICollectionViewLayoutAttributes *footattri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathWithIndex:i]];
        
        [self.attriArray addObject:footattri];
        
    }
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(kuan, self.totolheight+50);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attriArray;
}


- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attibute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            return  [self layoutSectionZeroAttributeWith:attibute indepath:indexPath];
        }
            break;
            
            
        default:
        {
            if ([_delegate respondsToSelector:@selector(MymodelWithindexpath:)]) {
                NewBZModel *model =  [_delegate MymodelWithindexpath:indexPath];
                
                if ([model.type isEqualToString:@"0"] && model.CanUseCerArray.count>0) {//带证书类型
                    return  [self layouSectionOnetAttributeWith:attibute indepath:indexPath canuserArray:model.CanUseCerArray PM:model.goods_desc];

                }else{
                    return  [self layoutSectionTwoAttributeWith:attibute indepath:indexPath PM:model.goods_desc];

                }
                
            }
        }
            break;
    }
    
    return nil;
}


- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
      UICollectionViewLayoutAttributes *attibute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    attibute.frame = CGRectMake(0, 0, 0, 0);
    return attibute;
}

#pragma mark------------------------------------------------------------------------------------
- (UICollectionViewLayoutAttributes *)layoutSectionZeroAttributeWith:(UICollectionViewLayoutAttributes *)attibute indepath:(NSIndexPath *)indexpath{
    
   CGFloat y = self.totolheight;
    
    if (indexpath.row == 0) {
        attibute.frame = CGRectMake(0, y, kuan *0.3, 50);

    }else if(indexpath.row == 1){
        attibute.frame = CGRectMake(kuan *0.3, y, kuan *0.3, 50);

    }else if (indexpath.row == 2){
        attibute.frame = CGRectMake( kuan *0.6,y, kuan *0.3, 50);

    }else if (indexpath.row == 3){
        attibute.frame = CGRectMake(kuan *0.9,y, kuan *0.1, 50);

    }
    
    if (indexpath.row == [self.collectionView numberOfItemsInSection:indexpath.section] - 1) {
        self.totolheight += 50;
    }
    
    
    return attibute;
}

- (UICollectionViewLayoutAttributes *)layouSectionOnetAttributeWith:(UICollectionViewLayoutAttributes *)attibute indepath:(NSIndexPath *)indexpath canuserArray:(NSArray *)canuserarray PM:(NSString *)PM{
    
       NSInteger zscount = [canuserarray count];
        
        CGFloat maxheight = self.totolheight;
        
        CGFloat baseheight = 50;
        
        CGFloat height = baseheight *(zscount);

    CGFloat TitleHeight = [NSString autoHeightWithString:PM Width:(kuan*0.3-20) Font:[UIFont systemFontOfSize:17]];
    
    if (TitleHeight > height) {//文字比较高
        
        baseheight = TitleHeight/(zscount);

         height = baseheight *(zscount);
        
    }else{//证书比较高
        
    }
    
        if (indexpath.row == 0) {
            attibute.frame = CGRectMake(0, maxheight, kuan *0.3, height);

        }else if (indexpath.row == zscount +1){
            
            attibute.frame = CGRectMake(0.6*kuan, maxheight, kuan *0.3, height);

        }else if (indexpath.row == zscount +2){
            
            attibute.frame = CGRectMake(0.9*kuan, maxheight, kuan *0.1, height);

        }else{
            
            attibute.frame = CGRectMake(0.3*kuan, maxheight + (indexpath.row - 1)*baseheight, kuan *0.3, baseheight);
        }
        
        if (indexpath.row == [self.collectionView numberOfItemsInSection:indexpath.section] - 1) {
            self.totolheight = (self.totolheight + (zscount)*baseheight);

        }
  
    
    return attibute;
}
- (UICollectionViewLayoutAttributes *)layoutSectionTwoAttributeWith:(UICollectionViewLayoutAttributes *)attibute indepath:(NSIndexPath *)indexpath PM:(NSString *)PM{
    
 CGFloat MAxheight = self.totolheight;
    
    CGFloat height = 50;
    
    CGFloat TitleHeight = [NSString autoHeightWithString:PM Width:(kuan*0.3-20) Font:[UIFont systemFontOfSize:17]];

    if (TitleHeight > height) {
        
        height = TitleHeight;
        
    }
    
    if (indexpath.row == 0) {
        attibute.frame = CGRectMake(0,MAxheight , kuan *0.3, height);
        
    }else if(indexpath.row == 1){
        attibute.frame = CGRectMake(kuan *0.3, MAxheight, kuan *0.3, height);

    }else if (indexpath.row == 2){
        attibute.frame = CGRectMake( kuan *0.6,MAxheight, kuan *0.3, height);

    }else if (indexpath.row == 3){
        attibute.frame = CGRectMake(kuan *0.9,MAxheight, kuan *0.1, height);

    }
    
    if (indexpath.row == [self.collectionView numberOfItemsInSection:indexpath.section] - 1) {
        self.totolheight += height;
    }
    
    return attibute;
}

@end
