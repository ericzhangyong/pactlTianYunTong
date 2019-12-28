//
//  newBZlayout.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewBZModel;

@protocol newbZcolltionviewldelegate <UICollectionViewDelegate>

- (NewBZModel *)MymodelWithindexpath:(NSIndexPath *)indexpath;

@end;

@interface newBZlayout : UICollectionViewLayout

-(instancetype)initWithDetectionType:(DetectionType)detectionType;


@property (nonatomic,weak) id<newbZcolltionviewldelegate> delegate;

@end
