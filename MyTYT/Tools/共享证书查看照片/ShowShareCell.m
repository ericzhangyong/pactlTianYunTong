//
//  ShowShareCell.m
//  MyTYT
//
//  Created by Fly on 2018/6/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowShareCell.h"
#import "UIImageView+WebCache.h"

@implementation ShowShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)loadImageWithURlStr:(NSString *)urlStr{
    
    self.height.constant = self.bounds.size.height;

    [self.imageview sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"myplaaceimage"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImageWithImage:image];
            });
        }
        
    }];
    
}

- (void)setImageWithImage:(UIImage *)image{
    
    self.imageview.image = image;
    
    if (self.height.constant != [self windowAfterFrameWithimage:image].size.height) {
        
        self.height.constant = [self windowAfterFrameWithimage:image].size.height;
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
    }
}


- (CGRect)windowAfterFrameWithimage:(UIImage *)image{
    
    
    CGSize size = image.size;
    
    CGSize newSize;
    newSize.width = self.frame.size.width;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (self.frame.size.height - newSize.height) *0.5;
    
    if (imageY < 0 ) {
        imageY = 0;
    }
    
    CGRect rect = CGRectMake(0, imageY, newSize.width, newSize.height);
    
    return rect;
    
    
}

@end
