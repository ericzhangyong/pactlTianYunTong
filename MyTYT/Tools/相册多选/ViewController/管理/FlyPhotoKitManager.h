//
//  FlyPhotoKitManager.h
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FlyPhotoBlock)(NSArray <NSData *> *Picarray);

@interface FlyPhotoKitManager : NSObject

/*
 *     选择照片最大个数
 */
@property (nonatomic, assign) NSInteger MaxSelectCount;

/*
 *     调用自定义可选相册接口的方法
 *     ViewController 用于调用此方法的VC
 *     result 结果回调 <存放的是选择好的照片二进制数据>
 */
- (void)showInViewController:(UIViewController *)ViewController result:(FlyPhotoBlock)result;


@end
