//
//  RequestAuthor.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "RequestAuthor.h"
#import <AVFoundation/AVFoundation.h>
@implementation RequestAuthor

+ (instancetype)shareInstance{
    
    static RequestAuthor *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

//相机认证
- (void)requestAVMediaTypeVideoWithAllow:(RequestAllow)allow deny:(RequestDeny)deny withVC:(UIViewController *)VC{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (status) {
            
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                dispatch_async( dispatch_get_main_queue(), ^{
                    
                    if (granted) {
                        
                        allow();
                        
                    }else{

                        [self AlertdenyWithVC:VC];
                    }
                });
                
            }];
        }
            break;
            
        case AVAuthorizationStatusAuthorized:
        {
            allow();
        }
            break;
            
        case AVAuthorizationStatusDenied:
        {
            [self AlertdenyWithVC:VC];
        }
            break;
            
        case AVAuthorizationStatusRestricted:
        {
            
        }
            break;
            
        default:
            break;
    }
}

//相机警告
- (void)AlertdenyWithVC:(UIViewController *)VC{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appName = infoDic[@"CFBundleDisplayName"];
    
    NSString *aleartMessage = [[NSString alloc] initWithFormat:@"请在iPad的“设置>隐私>相机”开启%@访问您的相机权限",appName];
    
    UIAlertController *aleartVc = [UIAlertController alertControllerWithTitle:@"没有权限访问您的相机" message:aleartMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    
    [aleartVc addAction:ok];
    
    [VC presentViewController:aleartVc animated:YES completion:nil];
}

@end
