//
//  FlyPhotoData.m
//  WHT
//
//  Created by Fly on 2018/3/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FlyTakePhotoData.h"
#import <Photos/Photos.h>

@interface FlyTakePhotoData ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation FlyTakePhotoData

- (void)dealloc{
    FlyLog(@"照片选择delloc");
}

- (void)GetPhotoDataWithType:(FlyPhotoType)type VC:(UIViewController *)VC picData:(FlyPhotoDataBlock)picData{
    
    self.dataBlock = picData;
    
    
    switch (type) {
        case FlyTakePhoto:
        {
            [self requestCameraWith:VC];
        }
            break;
            
        case FlyGetPhoto:
        {
            [self requestAutohoPhotolibrayWithVC:VC];
            
        }
            break;
    }
    
}

//请求相册权限
- (void)requestAutohoPhotolibrayWithVC:(UIViewController *)vc{
    
    PHAuthorizationStatus authorizationstatus = [PHPhotoLibrary authorizationStatus];
    
    switch (authorizationstatus) {
            
        case PHAuthorizationStatusDenied://用户拒绝
        {
            [self aleartForUserPhotoAuthorizationStatusDeniedWithVc:vc location:@"照片" withTitle:@"相册"];
        }
            break;
            
        case PHAuthorizationStatusNotDetermined://等待用户决定
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {//请求用户认证相册
                
                if (status == PHAuthorizationStatusAuthorized) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhotoLibraryWithVC:vc];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self aleartForUserPhotoAuthorizationStatusDeniedWithVc:vc location:@"照片" withTitle:@"相册"];
                    });
                    
                }
                
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized://允许使用
        {
            [self takePhotoLibraryWithVC:vc];
        }
            break;
        case PHAuthorizationStatusRestricted://系统限制，用户无操作权限
        {
            
        }
            break;
    }
}
//请求相机权限
- (void)requestCameraWith:(UIViewController *)vc{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (status) {
        case AVAuthorizationStatusNotDetermined:    //用户还没有选择(第一次)
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {  //授权
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takeCameraWithVC:vc];
                    });
                }else {         //拒绝
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self aleartForUserPhotoAuthorizationStatusDeniedWithVc:vc location:@"相机" withTitle:@"相机"];
                    });
                    
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:       //家长控制
        {
            
        }
            break;
        case AVAuthorizationStatusDenied:           //用户拒绝
        {
            [self aleartForUserPhotoAuthorizationStatusDeniedWithVc:vc location:@"相机" withTitle:@"相机"];
            
        }
            break;
        case AVAuthorizationStatusAuthorized:       //已授权
        {
            [self takeCameraWithVC:vc];
        }
            break;
        default:
            break;
    }
    
}
/*
 *    提示用户已经拒绝了相册使用，
 */
- (void)aleartForUserPhotoAuthorizationStatusDeniedWithVc:(UIViewController *)ViewController location:(NSString *)location withTitle:(NSString *)title{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appName = infoDic[@"CFBundleDisplayName"];
    
    NSString *AlearStr = [NSString stringWithFormat:@"请在iPhone的“设置->隐私->%@”开启%@访问你的手机%@",location,appName,title];
    UIAlertController *aleart = [UIAlertController alertControllerWithTitle:@"提醒" message:AlearStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [aleart addAction:ok];
    
    [ViewController presentViewController:aleart animated:YES completion:nil];
}


//相册
- (void)takePhotoLibraryWithVC:(UIViewController *)vc{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate =self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [vc presentViewController:picker animated:YES completion:nil];
    }
}


//相机
- (void)takeCameraWithVC:(UIViewController *)vc{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        picker.sourceType =UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [vc presentViewController:picker animated:YES completion:nil];
    }
}


#pragma mark------------------------------------------------------------------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    UIImage *newimage = [self scaleImageWIthscaleimage:image];

    NSData *imagedata = UIImageJPEGRepresentation(newimage, 0.5f);
    
    self.dataBlock(imagedata);

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//image
- (UIImage *)scaleImageWIthscaleimage:(UIImage *)image{
    
    CGFloat scale = image.size.width/image.size.height;
    
    CGFloat Width = kuan;
    
    CGFloat height = Width /scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(Width, height));
    
    [image drawInRect:CGRectMake(0, 0, Width, height)];
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimage;
    
}
#pragma mark------------------------------------------------------------------------------------

@end
