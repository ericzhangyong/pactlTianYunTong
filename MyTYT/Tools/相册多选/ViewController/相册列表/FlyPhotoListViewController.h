//
//  FlyPhotoListViewController.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlyPhotoListViewController : UIViewController

/*
 *  最大选择照片数目
 */
@property (nonatomic, assign) NSInteger MaxSelectPicCout;

/*
 *  选择的照片数组回调
 */
@property (nonatomic, copy) void(^Photoresult)(NSArray <NSData *>*picArray);


@end
