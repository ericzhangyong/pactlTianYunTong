//
//  AddBZcollectionviewcell.m
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZcollectionviewcell.h"
#import "UIImageView+WebCache.h"

@implementation AddBZcollectionviewcell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadimgaeviewWith:(NSString *)filePath{
    
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:filePath] placeholderImage:[UIImage imageNamed:@"larpic"] options:SDWebImageAllowInvalidSSLCertificates|SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    

}

- (void)loadImageViewWithPicData:(NSData *)data{
    self.imageview.image = [UIImage imageWithData:data];
}

@end
