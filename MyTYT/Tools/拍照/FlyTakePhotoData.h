//
//  FlyPhotoData.h
//  WHT
//
//  Created by Fly on 2018/3/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FlyPhotoType) {
    FlyTakePhoto,//拍照
    FlyGetPhoto,//相册
};

typedef void(^FlyPhotoDataBlock)(NSData *data);

@interface FlyTakePhotoData : NSObject

@property (nonatomic,copy) FlyPhotoDataBlock dataBlock;

- (void)GetPhotoDataWithType:(FlyPhotoType)type VC:(UIViewController *)VC picData:(FlyPhotoDataBlock)picData;

@end
