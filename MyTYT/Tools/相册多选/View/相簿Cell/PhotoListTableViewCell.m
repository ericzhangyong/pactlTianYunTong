//
//  PhotoListTableViewCell.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "PhotoListTableViewCell.h"
#import "FlyPhotoModel.h"

@implementation PhotoListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)loaddataWith:(FlyPhotoModel *)model{
    
    self.LastImageView.image = model.image;
    
    self.coulable.text = [NSString stringWithFormat:@"%ld",(long)model.count];
    
    self.titlelable.text = model.Pictitle;
}


@end
