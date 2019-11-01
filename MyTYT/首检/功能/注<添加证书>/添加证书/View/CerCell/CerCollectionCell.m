//
//  CerCollectionCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CerCollectionCell.h"
#import "UIImageView+WebCache.h"

@implementation CerCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)loadimageWithUrl:(NSString *)Url{
    
    [self.cerImageView sd_setImageWithURL:[NSURL URLWithString:Url] placeholderImage:[UIImage imageNamed:@"myplaaceimage"] options:SDWebImageAllowInvalidSSLCertificates];
    
}
@end
