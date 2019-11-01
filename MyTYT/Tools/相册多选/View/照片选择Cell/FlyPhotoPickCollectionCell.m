//
//  FlyPhotoPickCollectionCell.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotoPickCollectionCell.h"

@implementation FlyPhotoPickCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (void)loaddataWith:(PHAsset *)asset selectarray:(NSMutableArray *)selectarray{
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result == nil) {
            self.ImageView.image = [UIImage imageNamed:@"no_data"];
        }else{
            self.ImageView.image = result;
        }
    }];
    
    if ([selectarray containsObject:asset]) {//选中
        [self.selectBtn setImage:[UIImage imageNamed:@"photo_sel_photoPickerVc"] forState:UIControlStateNormal];
    }else{
        [self.selectBtn setImage:[UIImage imageNamed:@"photo_def_previewVc"] forState:UIControlStateNormal];
    }
    
}

@end
