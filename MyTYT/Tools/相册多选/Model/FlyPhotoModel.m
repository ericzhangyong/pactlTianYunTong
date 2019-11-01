//
//  FlyPhotoModel.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/12/1.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotoModel.h"
#import "UIImage+UIImage_FLyColor.h"

@implementation FlyPhotoModel

- (instancetype)initWithAssetCollection:(PHAssetCollection *)assetionCollection{
    
    if (self = [super init]) {
        
        self.assetCollection = assetionCollection;
        
        self.fetResult = [self getlastImageFetResultWith:assetionCollection];
        
        self.count = self.fetResult.count;
        
        self.Pictitle = [self titleWithAssetionCollectionStr:assetionCollection.localizedTitle];
        
        [[PHImageManager defaultManager] requestImageForAsset:self.fetResult.lastObject targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            if (result == nil) {
                self.image = [UIImage imageNamed:@"no_data"];
            }else{
                self.image = result;
            }
            
        }];
    }
    return self;
}

//获取检索结果
- (PHFetchResult *)getlastImageFetResultWith:(PHAssetCollection *)assetCollection{
    
    PHFetchOptions *fetchOption = [[PHFetchOptions alloc] init];
    
    fetchOption.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];//只要照片不要视屏
    return [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOption];
}

//改变标题
- (NSString *)titleWithAssetionCollectionStr:(NSString *)Str{
  
    if ([Str isEqualToString:@"Animated"]) {
        return @"动物";
    }
    
    if ([Str isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    }
    
    if ([Str isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    }
    
    if ([Str isEqualToString:@"Selfies"]) {
        return @"自拍";
    }
    
    if ([Str isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    }
    
    if ([Str isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    
    return Str;
    
}

@end
