//
//  QueryImageCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryImageCell.h"
#import "QuerybaseModel.h"
#import "UIImageView+WebCache.h"
#import "QueryCerImageModel.h"

@implementation QueryImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loaddataWithBaseModel:(QuerybaseModel *)model{
    
    QueryCerImageModel *imageModel = (QueryCerImageModel *)model;
    
     [self.imageview sd_setImageWithURL:[NSURL URLWithString:imageModel.picFilepath] placeholderImage:[UIImage imageNamed:@"myplaaceimage"] options:SDWebImageAllowInvalidSSLCertificates];
}

@end
