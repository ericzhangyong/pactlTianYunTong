//
//  FlyPhotoModel.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/12/1.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface FlyPhotoModel : NSObject

//照片资源集合
@property (nonatomic) PHAssetCollection *assetCollection;

//相册名称
@property (nonatomic) NSString *Pictitle;

//照片个数
@property (nonatomic, assign) NSInteger count;

//照片
@property (nonatomic) UIImage *image;

//检测出来相册结果
@property (nonatomic) PHFetchResult *fetResult;

- (instancetype)initWithAssetCollection:(PHAssetCollection *)assetionCollection;

@end
