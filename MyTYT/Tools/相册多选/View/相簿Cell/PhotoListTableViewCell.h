//
//  PhotoListTableViewCell.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlyPhotoModel;
@interface PhotoListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *LastImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
@property (weak, nonatomic) IBOutlet UILabel *coulable;

- (void)loaddataWith:(FlyPhotoModel *)model;

@end
