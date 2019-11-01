//
//  FlyPreViewCollectionViewCell.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/12/5.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyaViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FlyaViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadImageWith:(NSString *)URl{
    
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:URl] placeholderImage:[UIImage imageNamed:@"myplaaceimage"] options:SDWebImageAllowInvalidSSLCertificates];
}

- (void)loadImageViewWithPicData:(NSData *)data{
    self.imageview.image = [UIImage imageWithData:data];
}

@end
