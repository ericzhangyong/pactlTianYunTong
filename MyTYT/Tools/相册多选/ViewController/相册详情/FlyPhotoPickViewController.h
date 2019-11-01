//
//  FlyPhotoPickViewController.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface FlyPhotoPickViewController : UIViewController

/*
 *  最大选择照片数目
 */
@property (nonatomic, assign) NSInteger MaxSelectPicCout;

/*
 *  选择的照片数组回调
 */
@property (nonatomic, copy) void(^Photoresult)(NSArray <NSData *>*picArray);

/*
 * 检索结果 <是传过来某个具体相册的检索结果>
 */
@property (nonatomic) PHFetchResult *fetchResult;


/*
 * 是不是第一次进来，进入相机胶卷
 */
@property (nonatomic, assign) BOOL isFirstGetIn;

@end
