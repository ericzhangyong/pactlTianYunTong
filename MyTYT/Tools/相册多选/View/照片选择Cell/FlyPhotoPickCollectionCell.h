//
//  FlyPhotoPickCollectionCell.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface FlyPhotoPickCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

- (void)loaddataWith:(PHAsset *)asset selectarray:(NSMutableArray *)selectarray;


@end
