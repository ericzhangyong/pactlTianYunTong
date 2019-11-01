//
//  FlyPhotoKitManager.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotoKitManager.h"
#import <Photos/Photos.h>
#import "FlyPhotoListViewController.h"
#import "FlyPhotoPickViewController.h"
#import "FlyPhotoNav.h"

@interface FlyPhotoKitManager ()

@property (nonatomic) FlyPhotoListViewController *PhotoListVc;

@property (nonatomic) FlyPhotoPickViewController *PhotoPickerVc;

@property (nonatomic) FlyPhotoNav *nav;

@end

@implementation FlyPhotoKitManager


- (void)showInViewController:(UIViewController *)ViewController result:(FlyPhotoBlock)result{
    
    PHAuthorizationStatus authorizationstatus = [PHPhotoLibrary authorizationStatus];
    
    switch (authorizationstatus) {
        case PHAuthorizationStatusDenied://用户拒绝
            {
                [self aleartForUserPhotoAuthorizationStatusDeniedWithVc:ViewController];
            }
            break;
            
        case PHAuthorizationStatusNotDetermined://等待用户决定
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {//请求用户认证相册
                
                if (status == PHAuthorizationStatusAuthorized) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self showViewController:ViewController result:result];
                    });
            
                }
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized://允许使用
        {
            [self showViewController:ViewController result:result];

        }
            break;
        case PHAuthorizationStatusRestricted://系统限制，用户无操作权限
        {
            
        }
            break;
    }
}

/*
 *    提示用户已经拒绝了相册使用，
 */
- (void)aleartForUserPhotoAuthorizationStatusDeniedWithVc:(UIViewController *)ViewController{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appName = infoDic[@"CFBundleDisplayName"];
    
    NSString *AlearStr = [NSString stringWithFormat:@"请在iPhone的“设置->隐私->照片”开启%@访问你的手机相册",appName];
    UIAlertController *aleart = [UIAlertController alertControllerWithTitle:@"提醒" message:AlearStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [aleart addAction:ok];
    
    [ViewController presentViewController:aleart animated:YES completion:nil];
}


/*
 *   跳转到相册展示页面
 */
- (void)showViewController:(UIViewController *)Viewcontroller result:(FlyPhotoBlock)result{
    
    
    self.PhotoListVc.MaxSelectPicCout = self.MaxSelectCount;
    
    self.PhotoListVc.Photoresult = result;
    

    self.PhotoPickerVc.MaxSelectPicCout = self.MaxSelectCount;
    
    self.PhotoPickerVc.Photoresult = result;
    
    self.PhotoPickerVc.isFirstGetIn = YES;

    [Viewcontroller presentViewController:self.nav animated:YES completion:nil];
    
    [self.nav pushViewController:self.PhotoPickerVc animated:NO];//没有动画直接进入
    
}


#pragma mark----

- (FlyPhotoListViewController *)PhotoListVc{
    if (!_PhotoListVc) {
        _PhotoListVc = [[FlyPhotoListViewController alloc] init];
    }
    return _PhotoListVc;
}

- (FlyPhotoNav *)nav{
    if (!_nav) {
        _nav = [[FlyPhotoNav alloc] initWithRootViewController:self.PhotoListVc];
    }
    return _nav;
}

- (FlyPhotoPickViewController *)PhotoPickerVc{
    if (!_PhotoPickerVc) {
        _PhotoPickerVc = [[FlyPhotoPickViewController alloc] init];
    }
    return _PhotoPickerVc;
}

@end
