//
//  ShowAgentView.h
//  MyTYT
//
//  Created by Fly on 2018/6/6.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AgenDataManagerer;

@interface ShowAgentView : UIView

@property (nonatomic) UICollectionView *collectionview;

@property (nonatomic) AgenDataManagerer *datamanager;

- (void)freshDataWithArray:(NSArray *)agentArray;

@end
