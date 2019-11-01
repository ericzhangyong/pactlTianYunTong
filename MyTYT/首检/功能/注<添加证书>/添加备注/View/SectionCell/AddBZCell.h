//
//  AddBZCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BZModle;

@interface AddBZCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yglable;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@property (weak, nonatomic) IBOutlet UILabel *timelable;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableheight;

- (void)loaddataWithModel:(BZModle *)model;
@end
