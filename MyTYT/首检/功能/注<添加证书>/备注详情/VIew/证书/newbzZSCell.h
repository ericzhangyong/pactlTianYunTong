//
//  newbzZSCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BZCerModel;

@interface newbzZSCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *ZSImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *ZSTitleBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (void)loaddataWithModel:(BZCerModel *)model;

@end
