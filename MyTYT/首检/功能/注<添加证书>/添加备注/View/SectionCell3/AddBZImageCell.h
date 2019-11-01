//
//  AddBZImageCell.h
//  MyTYT
//
//  Created by Fly on 2018/6/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectPicDelegate <NSObject>

- (void)selectIndex:(NSInteger)row;

@end

@class AddBZImageModel;

@interface AddBZImageCell : UITableViewCell

@property (nonatomic,weak) id<SelectPicDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

- (void)loaddataWithModel:(AddBZImageModel *)model;

@end
