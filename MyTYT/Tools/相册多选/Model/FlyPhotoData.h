//
//  FlyPhotoData.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@class FlyPhotoModel;
@interface FlyPhotoData : NSObject

/*
 *  获取全部相册集合
 */

- (NSMutableArray <FlyPhotoModel *>*)getPhotosListDatas;


/*
 *  根据相片集合返回具体放有照片资源的检索结果
 */
- (PHFetchResult *)getFetResultWith:(PHAssetCollection *)assetCollection;

/*
 *  根据检索结果集返回图片资源的照片集合
 */
- (NSMutableArray <PHAsset *> *)getPicAssetArrayWithFetResult:(PHFetchResult *)result;

/*
 *  相机胶卷资源结果
 */
- (PHFetchResult*)getFetResultCameraDatas;

@end
