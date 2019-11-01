//
//  FlyPreViewCollectionViewCell.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/12/5.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlyaViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scroolerview;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

- (void)loadImageWith:(NSString *)URl;

- (void)loadImageViewWithPicData:(NSData *)data;


@end
