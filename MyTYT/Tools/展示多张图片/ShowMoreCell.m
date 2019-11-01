//
//  ShowMoreCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowMoreCell.h"
#import "UIImageView+WebCache.h"

@interface ShowMoreCell ()


@end

@implementation ShowMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)loadImageWithURlStr:(NSString *)urlStr{
    
    
    self.height.constant = gao;
    
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
    
    CGRect rect = [self windowAfterFrameWithimage:image];
    
    self.height.constant = rect.size.height;
    self.top.constant = rect.origin.y;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}


- (CGRect)windowAfterFrameWithimage:(UIImage *)image{
    
    
    CGSize size = image.size;
    
    CGSize newSize;
    newSize.width = kuan;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (gao - newSize.height) *0.5;
    
    if (imageY < 0 ) {
        imageY = 0;
    }
    
    CGRect rect = CGRectMake(0, imageY, newSize.width, newSize.height);
    
    return rect;
    
    
}
//

@end
