//
//  FlyPhotopreViewController.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/12/5.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface FlyPhotopreViewController : UIViewController

@property (nonatomic) NSArray <PHAsset *> *photoarray;

@property (nonatomic, assign) NSInteger selectindex;

@end
