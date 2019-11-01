//
//  FlyPhotoData.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotoData.h"
#import "FlyPhotoModel.h"

@implementation FlyPhotoData

- (NSMutableArray <FlyPhotoModel *>*)getPhotosListDatas{
    
    NSMutableArray *array = [NSMutableArray array];
    
    PHAssetCollectionSubtype subtype = PHAssetCollectionSubtypeSmartAlbumUserLibrary | PHAssetCollectionSubtypeSmartAlbumRecentlyAdded | PHAssetCollectionSubtypeSmartAlbumScreenshots | PHAssetCollectionSubtypeSmartAlbumSelfPortraits;
    
    PHFetchResult *librayResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:subtype options:nil];
    
    for (PHAssetCollection * collection in librayResult) {
        
        FlyPhotoModel *model = [[FlyPhotoModel alloc] initWithAssetCollection:collection];
        
        if (model.count>0) {
            
            if ([model.Pictitle isEqualToString:@"相机胶卷"]) {//相册在第一个
                [array insertObject:model atIndex:0];
            }else{
                if ([model.Pictitle isEqualToString:@"最近删除"]) {
                    
                }else{
                    [array addObject:model];

                }
            }
        }
    }
    
    PHFetchResult *UserResult = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
    
    for (PHAssetCollection *abumCollection in UserResult) {
        
        FlyPhotoModel *model = [[FlyPhotoModel alloc] initWithAssetCollection:abumCollection];
        
        [array addObject:model];
    }
    
    return array;
}


- (PHFetchResult *)getFetResultWith:(PHAssetCollection *)assetCollection{
    PHFetchOptions *fetchOption = [[PHFetchOptions alloc] init];
    
    fetchOption.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];//只要照片不要视屏
    return [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOption];
}
#pragma mark----ScrolelrviewDelegate
- (NSMutableArray <PHAsset *> *)getPicAssetArrayWithFetResult:(PHFetchResult *)result{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (PHAsset *asset in result) {
        
        if (asset.mediaType == 1) {//1为图片，2为视屏,这里只加载图片
            [array addObject:asset];
        }
    }
    return array;
}

- (PHFetchResult*)getFetResultCameraDatas{
    
    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    PHAssetCollection *assetCollection = fetchResult.lastObject;
    
    return [self getFetResultWith:assetCollection];
}

@end
