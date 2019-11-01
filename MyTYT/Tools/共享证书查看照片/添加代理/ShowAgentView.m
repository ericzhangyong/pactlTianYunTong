//
//  ShowAgentView.m
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowAgentView.h"
#import "AgentCell.h"
#import "SQDLCEll.h"
#import "AgenDataManagerer.h"
#import "AgentRowModel.h"
#import "AgentSectionModel.h"

#define itemCount 8

@interface ShowAgentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ShowAgentView


- (void)freshDataWithArray:(NSArray *)agentArray{
    self.datamanager = [[AgenDataManagerer alloc] initWithAgentArray:agentArray];
    [self.collectionview reloadData];
}

- (AgenDataManagerer *)datamanager{
    if (!_datamanager) {
        _datamanager = [[AgenDataManagerer alloc] init];
    }
    return _datamanager;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collectionview];

    }
    return self;
}



- (UICollectionView *)collectionview{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((kuan - (itemCount + 1) *20)/itemCount, 40);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        _collectionview = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = [UIColor orangeColor];
        
        [_collectionview registerNib:[UINib nibWithNibName:@"AgentCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([AgentCell class])];
        
            [_collectionview registerNib:[UINib nibWithNibName:@"SQDLCEll" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([SQDLCEll class])];
        
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
    }
    return _collectionview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datamanager.SectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    AgentSectionModel *sectionModel = self.datamanager.SectionArray[section];
    return sectionModel.rowArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentSectionModel *sectionModel = self.datamanager.SectionArray[indexPath.section];
    AgentRowModel *rowmodel = sectionModel.rowArray[indexPath.row];
    
    switch (rowmodel.cellType) {
        case SQRowCell:
        {
            SQDLCEll *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SQDLCEll class]) forIndexPath:indexPath];
            [cell loaddataWithModel:rowmodel.baseModel];
            return cell;
        }
            break;
            
        case AgentRowCell:
        {
            AgentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AgentCell class]) forIndexPath:indexPath];
            [cell loaddataWithModel:rowmodel.baseModel];
            return cell;

        }
            break;
    }
    
    return nil;

}

@end
