//
//  ShareLayout.m
//  MyTYT
//
//  Created by Fly on 2018/6/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShareLayout.h"
#import "ShareDecortionView.h"

@interface ShareLayout ()

@property (nonatomic) NSMutableDictionary *dic;

@end

@implementation ShareLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    [self registerNib:[UINib nibWithNibName:@"ShareDecortionView" bundle:[NSBundle mainBundle]] forDecorationViewOfKind:@"ShareDecortionViewID"];
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attibute = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    
    NSMutableArray *array = self.dic[[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    UICollectionViewLayoutAttributes *first = array[0];//第一个

    UICollectionViewLayoutAttributes *last = [array lastObject];//最后一个

    attibute.zIndex = -1;

    if (indexPath.section == 1) {
           attibute.frame = CGRectMake(0,  CGRectGetMinY(first.frame), self.collectionView.bounds.size.width, CGRectGetMaxY(last.frame)-CGRectGetMinY(first.frame)+20);
    }else{
          attibute.frame = CGRectMake(0,  CGRectGetMinY(first.frame), self.collectionView.bounds.size.width, CGRectGetMaxY(last.frame)-CGRectGetMinY(first.frame));
    }
    
 
    FlyLog(@"%@",NSStringFromCGRect(attibute.frame));
    return attibute;
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *superAttrs = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *attrs = [NSMutableArray arrayWithArray:superAttrs];
    
    FlyLog(@"%@",superAttrs);
    [self.dic removeAllObjects];
    
    NSMutableArray *arrayzero  = [NSMutableArray array];
    NSMutableArray *arrayone  = [NSMutableArray array];

    for (UICollectionViewLayoutAttributes *attr in superAttrs) {
      
        if (attr.indexPath.section == 0) {
            
            [arrayzero addObject:attr];
            
            NSString *str = [[NSString alloc] initWithFormat:@"%ld",attr.indexPath.section];

            [self.dic setValue:arrayzero forKey:str];
            
        }else if (attr.indexPath.section == 1){
            [arrayone addObject:attr];
            NSString *str = [[NSString alloc] initWithFormat:@"%ld",attr.indexPath.section];
            
            [self.dic setValue:arrayone forKey:str];
            
           
        }
        
    }
    
    
    for (UICollectionViewLayoutAttributes *attr in superAttrs) {
        
        if (attr.indexPath.section == 0) {
           UICollectionViewLayoutAttributes *deco = [self layoutAttributesForDecorationViewOfKind:@"ShareDecortionViewID" atIndexPath:attr.indexPath];
            [attrs addObject:deco];
            break;
        }
    }
    
    for (UICollectionViewLayoutAttributes *attr in superAttrs) {
        
        if (attr.indexPath.section == 1) {
            UICollectionViewLayoutAttributes *deco = [self layoutAttributesForDecorationViewOfKind:@"ShareDecortionViewID" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:attr.indexPath.section]];
            [attrs addObject:deco];
            break;
        }
    }
    
    return attrs;
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}


@end
