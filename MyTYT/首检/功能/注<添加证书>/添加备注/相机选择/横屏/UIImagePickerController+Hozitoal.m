//
//  UIImagePickerController+Hozitoal.m
//  MyTYT
//
//  Created by Fly on 2018/5/3.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "UIImagePickerController+Hozitoal.h"

@implementation UIImagePickerController (Hozitoal)

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
